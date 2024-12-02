import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/error.dart';
import '../../helpers/date.dart';
import '../model/property.dart';
import '../model/task_database.dart';
import '../oauth/notion_oauth_viewmodel.dart';
import '../../settings/task_database/task_database_viewmodel.dart';

part 'notion_task_repository.g.dart';

enum FilterType { today, all }

class NotionTaskRepository {
  final String accessToken;
  final TaskDatabase database;
  late final Map<String, String> headers;

  NotionTaskRepository(this.accessToken, this.database) {
    headers = {
      'Content-Type': 'application/json',
      'Notion-Version': '2022-06-28',
      'Authorization': 'Bearer $accessToken'
    };
  }

  Future fetchPages(FilterType filterType) async {
    final db = database;
    if (db.id.isEmpty) {
      return;
    }

    final databaseId = db.id;
    final dateProperty = db.date;
    final statusProperty = db.status;
    final now = DateTime.now();
    final todayStart = startTimeOfDay(now).toUtc().toIso8601String();
    final todayEnd = endTimeOfDay(now).toUtc().toIso8601String();
    final filter = {
      "or": [
        // 今日のタスク
        {
          "and": [
            {
              "property": dateProperty.name,
              "date": {"on_or_after": todayStart}
            },
            {
              "property": dateProperty.name,
              "date": {"on_or_before": todayEnd}
            }
          ]
        },
        // 期限切れで未完了のタスク
        {
          "and": [
            {
              "property": dateProperty.name,
              "date": {"before": todayStart}
            },
            if (statusProperty.type == PropertyType.status)
              ...getNotCompleteStatusFilter(
                  statusProperty as StatusTaskStatusProperty)
            else
              {
                "property": statusProperty.name,
                "checkbox": {"equals": false}
              }
          ]
        }
      ]
    };

    final res = await http.post(
      Uri.parse('https://api.notion.com/v1/databases/$databaseId/query'),
      headers: headers,
      body: jsonEncode({
        if (filterType == FilterType.today) "filter": filter,
        "sorts": [
          {
            "property": statusProperty.name,
            "direction":
                FilterType.today == filterType ? "descending" : "ascending"
          },
          {"property": dateProperty.name, "direction": "ascending"},
          {"timestamp": "last_edited_time", "direction": "descending"}
        ],
        "page_size": 100
        // TODO: ページネーション
      }),
    );
    final data = jsonDecode(res.body);
    if (data['object'] == 'error') {
      throw TaskException(data['message'], data['status']);
    }
    return data['results'];
  }

  Future addTask(String title, String? dueDate) async {
    final db = database;
    if (db.id.isEmpty) {
      return;
    }
    final properties = {
      db.title.name: {
        "title": [
          {
            "type": "text",
            "text": {"content": title}
          }
        ]
      },
      if (db.status.type == PropertyType.status)
        db.status.name: {
          "status": {
            "name": (db.status as StatusTaskStatusProperty).todoOption?.name
          }
        }
      else
        db.status.name: {"checkbox": false},
      if (dueDate != null)
        db.date.name: {
          "date": {"start": dueDate}
        }
    };

    final res = await http.post(
      Uri.parse('https://api.notion.com/v1/pages'),
      headers: headers,
      body: jsonEncode({
        "parent": {"database_id": db.id},
        "properties": properties
      }),
    );
    final data = jsonDecode(res.body);
    if (data['object'] == 'error') {
      throw Exception(data['message']);
    }
    return data;
  }

  Future updateTask(String taskId, String title, String? dueDate) async {
    final db = database;
    if (db.id.isEmpty) {
      return;
    }
    final properties = {
      db.title.name: {
        "id": db.title.id,
        "title": [
          {
            "type": "text",
            "text": {"content": title}
          }
        ]
      },
      db.date.name: {
        "id": db.date.id,
        "date": dueDate != null
            ? {
                "start": dueDate,
                // timezoneは時間指定しないとエラーになる see: https://developers.notion.com/changelog/time-zone-support
                // REVIEW: 時間指定がないときのtimezoneがあっているか？
                // if (dueDate.contains('T')) "time_zone": "Asia/Tokyo",
              }
            : null
      }
    };
    final res = await http.patch(
      Uri.parse('https://api.notion.com/v1/pages/$taskId'),
      headers: headers,
      body: jsonEncode({"properties": properties}),
    );
    return jsonDecode(res.body);
  }

  Future updateStatus(String taskId, bool isCompleted) async {
    final db = database;
    if (db.id.isEmpty) {
      return;
    }

    final status = db.status;
    final res = await http.patch(
      Uri.parse('https://api.notion.com/v1/pages/$taskId'),
      headers: headers,
      body: jsonEncode({
        "properties": status.type == PropertyType.status
            ? {
                status.name: {
                  "status": {
                    "name": isCompleted
                        ? (status as StatusTaskStatusProperty)
                                .completeOption
                                ?.name ??
                            'Done'
                        : (status as StatusTaskStatusProperty)
                                .todoOption
                                ?.name ??
                            'To-do'
                  }
                }
              }
            : {
                status.name: {"checkbox": isCompleted}
              }
      }),
    );
    return jsonDecode(res.body);
  }

  Future deleteTask(String taskId) async {
    final res = await http.patch(
      Uri.parse('https://api.notion.com/v1/pages/$taskId'),
      headers: headers,
      body: jsonEncode({"archived": true}),
    );
    return jsonDecode(res.body);
  }

  Future revertTask(String taskId) async {
    final res = await http.patch(
      Uri.parse('https://api.notion.com/v1/pages/$taskId'),
      headers: headers,
      body: jsonEncode({
        "archived": false,
      }),
    );
    return jsonDecode(res.body);
  }
}

List<dynamic> getNotCompleteStatusFilter(
    StatusTaskStatusProperty statusProperty) {
  final optionIds = statusProperty.status.groups
          .where((e) => e.name == 'Complete')
          .firstOrNull
          ?.option_ids ??
      [];
  return optionIds.map((id) {
    final completeOptionName = statusProperty.status.options
        .where((e) => e.id == id)
        .firstOrNull
        ?.name;
    if (completeOptionName == null) {
      throw Exception('Complete option name not found');
    }
    return {
      "property": statusProperty.name,
      "status": {"does_not_equal": completeOptionName}
    };
  }).toList();
}

@riverpod
NotionTaskRepository? notionTaskRepository(Ref ref) {
  final accessToken = ref.watch(notionOAuthViewModelProvider).accessToken;
  final taskDatabase = ref.watch(taskDatabaseViewModelProvider).valueOrNull;
  if (accessToken == null || taskDatabase == null) {
    return null;
  }
  return NotionTaskRepository(accessToken, taskDatabase);
}
