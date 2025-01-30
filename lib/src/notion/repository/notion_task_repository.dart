import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static const _showCompletedKey = 'showCompleted';
  static final DateHelper d = DateHelper();
  static const _pageSize = 100; // NOTE: NotionAPIの最大許容サイズ

  NotionTaskRepository(this.accessToken, this.database) {
    headers = {
      'Content-Type': 'application/json',
      'Notion-Version': '2022-06-28',
      'Authorization': 'Bearer $accessToken'
    };
  }

  Future<bool> loadShowCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showCompletedKey) ?? false;
  }

  Future<void> saveShowCompleted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showCompletedKey, value);
  }

  Future fetchPages(FilterType filterType, bool hasCompleted,
      {String? startCursor}) async {
    final db = database;
    if (db.id.isEmpty) {
      return;
    }

    final databaseId = db.id;
    final dateProperty = db.date;
    final statusProperty = db.status;
    final now = DateTime.now();
    final todayStart = d.startTimeOfDay(now).toUtc().toIso8601String();
    final todayEnd = d.endTimeOfDay(now).toUtc().toIso8601String();
    final Object? filter;
    if (filterType == FilterType.today) {
      filter = {
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
              },
              if (!hasCompleted) ...getNotCompleteStatusFilter(statusProperty)
            ]
          },
          // 期限切れで未完了のタスク
          {
            "and": [
              {
                "property": dateProperty.name,
                "date": {"before": todayStart}
              },
              ...getNotCompleteStatusFilter(statusProperty)
            ]
          }
        ]
      };
    } else if (filterType == FilterType.all && !hasCompleted) {
      filter = {
        "and": [...getNotCompleteStatusFilter(statusProperty)]
      };
    } else {
      filter = null;
    }

    final res = await http.post(
      Uri.parse('https://api.notion.com/v1/databases/$databaseId/query'),
      headers: headers,
      body: jsonEncode({
        if (filter != null) "filter": filter,
        "sorts": [
          {"property": dateProperty.name, "direction": "ascending"},
          {"timestamp": "created_time", "direction": "ascending"}
        ],
        if (startCursor != null) "start_cursor": startCursor,
        "page_size": _pageSize
      }),
    );
    final data = jsonDecode(res.body);
    if (data['object'] == 'error') {
      throw TaskException(data['message'], data['status']);
    }
    return {
      'results': data['results'],
      'has_more': data['has_more'],
      'next_cursor': data['next_cursor']
    };
  }

  Future addTask(String title, String? dueDate) async {
    final db = database;
    final status = db.status;
    final statusReady = switch (status) {
      StatusCompleteStatusProperty() => {
          "status": {"name": status.todoOption?.name}
        },
      CheckboxCompleteStatusProperty() => {"checkbox": false},
    };

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
      db.status.name: statusReady,
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

  Future updateCompleteStatus(String taskId, bool isCompleted) async {
    final db = database;
    if (db.id.isEmpty) {
      return;
    }

    final status = db.status;
    final statusProperties = switch ((status, isCompleted)) {
      (
        StatusCompleteStatusProperty(completeOption: var completeOption),
        true
      ) =>
        {
          "status": {"name": completeOption?.name ?? 'Done'}
        },
      (StatusCompleteStatusProperty(todoOption: var todoOption), false) => {
          "status": {"name": todoOption?.name ?? 'To-do'}
        },
      (CheckboxCompleteStatusProperty(), _) => {"checkbox": isCompleted},
    };

    final res = await http.patch(
      Uri.parse('https://api.notion.com/v1/pages/$taskId'),
      headers: headers,
      body: jsonEncode({
        "properties": {status.name: statusProperties},
      }),
    );
    return jsonDecode(res.body);
  }

  Future updateInProgressStatus(String taskId, bool isInProgress) async {
    final db = database;
    if (db.id.isEmpty) {
      return;
    }

    final status = db.status;

    final statusProperties = switch ((status, isInProgress)) {
      (
        StatusCompleteStatusProperty(inProgressOption: var inProgressOption),
        true
      ) =>
        {
          "status": {"name": inProgressOption?.name ?? 'In Progress'}
        },
      (StatusCompleteStatusProperty(todoOption: var todoOption), false) => {
          "status": {"name": todoOption?.name ?? 'To-do'}
        },
      // checkboxは更新しない
      (CheckboxCompleteStatusProperty(), _) => {"checkbox": false},
    };

    final res = await http.patch(
      Uri.parse('https://api.notion.com/v1/pages/$taskId'),
      headers: headers,
      body: jsonEncode({
        "properties": {status.name: statusProperties},
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

List<dynamic> getNotCompleteStatusFilter(CompleteStatusProperty property) {
  switch (property) {
    case StatusCompleteStatusProperty(status: var status):
      final optionIds = status.groups
              .where(
                  (e) => e.name.toLowerCase() == StatusGroupType.complete.name)
              .firstOrNull
              ?.optionIds ??
          [];
      return optionIds.map((id) {
        final completeOptionName =
            status.options.where((e) => e.id == id).firstOrNull?.name;
        if (completeOptionName == null) {
          throw Exception('Complete option name not found');
        }
        return {
          "property": property.name,
          "status": {"does_not_equal": completeOptionName}
        };
      }).toList();
    case CheckboxCompleteStatusProperty():
      return [
        {
          "property": property.name,
          "checkbox": {"equals": false}
        }
      ];
  }
}

@riverpod
NotionTaskRepository? notionTaskRepository(Ref ref) {
  final accessToken =
      ref.watch(notionOAuthViewModelProvider).valueOrNull?.accessToken;
  final taskDatabase = ref.watch(taskDatabaseViewModelProvider).valueOrNull;
  if (accessToken == null || taskDatabase == null) {
    return null;
  }
  return NotionTaskRepository(accessToken, taskDatabase);
}
