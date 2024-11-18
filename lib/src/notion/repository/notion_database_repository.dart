import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/date.dart';
import '../model/property.dart';
import '../model/task_database.dart';
import '../oauth/notion_oauth_viewmodel.dart';
import '../task_database/task_database_viewmodel.dart';

part 'notion_database_repository.g.dart';

// - [x] list databases
// - [x] list database pages
// - [x] create a database page
// - [x] update a database page
// - [x] delete a database page

enum FilterType { today, done, all }

class NotionDatabaseRepository {
  final String _accessToken;
  final TaskDatabase? _database;
  // ignore: prefer_typing_uninitialized_variables
  late final _headers;

  NotionDatabaseRepository(this._accessToken, {TaskDatabase? database})
      : _database = database ?? TaskDatabase.initial() {
    _headers = {
      'Content-Type': 'application/json',
      'Notion-Version': '2022-06-28',
      'Authorization': 'Bearer $_accessToken'
    };
  }

  Future fetchAccessibleDatabases() async {
    final res = await http.post(Uri.parse('https://api.notion.com/v1/search'),
        headers: _headers,
        body: jsonEncode({
          "query": "",
          "filter": {"value": "database", "property": "object"}
        }));
    final data = jsonDecode(res.body);
    return data['results'];
  }

  Future fetchPages(FilterType type) async {
    final db = _database;
    if (db == null || db.id.isEmpty) {
      return;
    }
    final databaseId = db.id;
    final dateProperty = db.date;
    final statusProperty = db.status;
    final filter = type == FilterType.today
        ? {
            "and": [
              {
                "property": dateProperty.name,
                "date": {
                  "on_or_before":
                      endTimeOfDay(DateTime.now()).toUtc().toIso8601String()
                }
              },
              statusProperty.type == PropertyType.status
                  ? {
                      "and": getStatusFilter(
                          statusProperty as StatusTaskStatusProperty)
                    }
                  : {
                      "property": statusProperty.name,
                      "checkbox": {"equals": false}
                    }
            ]
          }
        : type == FilterType.done
            ? {
                "or": getStatusFilter(
                    statusProperty as StatusTaskStatusProperty,
                    isCompleted: true)
              }
            : {};
    final res = await http.post(
      Uri.parse('https://api.notion.com/v1/databases/$databaseId/query'),
      headers: _headers,
      body: jsonEncode({
        "filter": filter,
        "sorts": [
          {"property": dateProperty.name, "direction": "ascending"},
          {"timestamp": "last_edited_time", "direction": "descending"}
        ]
      }),
    );
    final data = jsonDecode(res.body);
    return data['results'];
  }

  Future addTask(String title, String? dueDate) async {
    final db = _database;
    if (db == null || db.id.isEmpty) {
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
      if (dueDate != null)
        db.date.name: {
          "date": {"start": dueDate}
        }
    };
    final res = await http.post(
      Uri.parse('https://api.notion.com/v1/pages'),
      headers: _headers,
      body: jsonEncode({
        "parent": {"database_id": db.id},
        "properties": properties
      }),
    );
    return jsonDecode(res.body);
  }

  Future updateTask(String taskId, String title, String? dueDate) async {
    final db = _database;
    if (db == null || db.id.isEmpty) {
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
      headers: _headers,
      body: jsonEncode({"properties": properties}),
    );
    return jsonDecode(res.body);
  }

  Future updateStatus(String taskId, bool isCompleted) async {
    final db = _database;
    if (db == null || db.id.isEmpty) {
      return;
    }
    final status = db.status;
    final res = await http.patch(
      Uri.parse('https://api.notion.com/v1/pages/$taskId'),
      headers: _headers,
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

  Future undoDeleteTask(String taskId) async {
    final res = await http.delete(
      Uri.parse('https://api.notion.com/v1/blocks/$taskId'),
      headers: _headers,
    );
    return jsonDecode(res.body);
  }

  Future revertTask(String taskId) async {
    final res = await http.patch(
      Uri.parse('https://api.notion.com/v1/pages/$taskId'),
      headers: _headers,
      body: jsonEncode({
        "archived": false,
      }),
    );
    return jsonDecode(res.body);
  }
}

dynamic getStatusFilter(StatusTaskStatusProperty statusProperty,
    {bool isCompleted = false}) {
  final optionIds = statusProperty.status.groups
      .firstWhere((e) => e.name == 'Complete')
      .option_ids;
  return optionIds
      .map((id) => {
            "property": statusProperty.name,
            "status": isCompleted
                ? {
                    "equals": statusProperty.status.options
                        .firstWhere((e) => e.id == id)
                        .name
                  }
                : {
                    "does_not_equal": statusProperty.status.options
                        .firstWhere((e) => e.id == id)
                        .name
                  }
          })
      .toList();
}

@riverpod
NotionDatabaseRepository notionDatabaseRepository(ref) {
  final accessToken = ref.watch(notionOAuthViewModelProvider).accessToken;
  final taskDatabase = ref.watch(taskDatabaseViewModelProvider).taskDatabase;
  if (accessToken == null || taskDatabase == null) {
    return NotionDatabaseRepository('');
  }
  return NotionDatabaseRepository(accessToken, database: taskDatabase);
}
