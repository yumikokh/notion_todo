import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/error.dart';
import '../../helpers/date.dart';
import '../model/property.dart';
import '../model/task.dart';
import '../model/task_database.dart';
import '../common/filter_type.dart';

class NotionTaskApi {
  final String accessToken;
  final TaskDatabase database;
  late final Map<String, String> headers;

  static const _showCompletedKey = 'showCompleted';
  static final DateHelper d = DateHelper();
  static const _pageSize = 100; // NOTE: NotionAPIの最大許容サイズ

  NotionTaskApi(this.accessToken, this.database) {
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
    final priorityProperty = db.priority;
    final now = DateTime.now();
    final todayStart = d.startTimeOfDay(now).toUtc().toIso8601String();
    final todayEnd = d.endTimeOfDay(now).toUtc().toIso8601String();
    final Object? filter;
    if (filterType == FilterType.today) {
      filter = {
        "or": [
          // 今日のタスク
          if (hasCompleted) ...[
            {
              "and": [
                {
                  "property": dateProperty.id,
                  "date": {"on_or_after": todayStart}
                },
                {
                  "property": dateProperty.id,
                  "date": {"on_or_before": todayEnd}
                },
                ..._getCompleteStatusFilter(statusProperty, onlyComplete: true),
              ],
            },
            {
              "and": [
                {
                  "property": dateProperty.id,
                  "date": {"on_or_after": todayStart}
                },
                {
                  "property": dateProperty.id,
                  "date": {"on_or_before": todayEnd}
                },
                ..._getNotCompleteStatusFilter(statusProperty,
                    onlyNotComplete: true),
              ],
            }
          ],
          if (!hasCompleted)
            {
              "and": [
                {
                  "property": dateProperty.id,
                  "date": {"on_or_after": todayStart}
                },
                {
                  "property": dateProperty.id,
                  "date": {"on_or_before": todayEnd}
                },
                ..._getNotCompleteStatusFilter(statusProperty,
                    onlyNotComplete: true),
              ],
            },
          // 期限切れで未完了のタスク
          {
            "and": [
              {
                "property": dateProperty.id,
                "date": {"before": todayStart}
              },
              ..._getNotCompleteStatusFilter(statusProperty,
                  onlyNotComplete: true)
            ]
          },
          // 進行中のタスク
          ..._getInProgressStatusFilter(db)
        ]
      };
    } else if (filterType == FilterType.all && !hasCompleted) {
      filter = {
        "and": [..._getNotCompleteStatusFilter(statusProperty)]
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
          if (priorityProperty != null)
            {"property": priorityProperty.name, "direction": "ascending"},
          {"timestamp": "created_time", "direction": "ascending"}
        ],
        if (startCursor != null) "start_cursor": startCursor,
        "page_size": _pageSize
      }),
    );
    final data = jsonDecode(res.body);
    if (NotionErrorException.isErrorResponse(data)) {
      throw NotionErrorException.fromJson(data);
    }
    return {
      'results': data['results'],
      'has_more': data['has_more'],
      'next_cursor': data['next_cursor']
    };
  }

  Future addTask(Task task) async {
    final db = database;
    if (db.id.isEmpty) return;

    final status = db.status;
    final startDate = task.dueDate?.start.submitFormat;
    final endDate = task.dueDate?.end?.submitFormat;

    final properties = {
      db.title.id: {
        "title": [
          {
            "type": "text",
            "text": {"content": task.title}
          }
        ]
      },
      db.status.id: CompleteStatusProperty.initialJson(status),
      if (startDate != null)
        db.date.id: {
          "date": {"start": startDate, if (endDate != null) "end": endDate}
        },
      if (db.priority != null && task.priority != null)
        db.priority!.id: {
          "select": {"name": task.priority!.name}
        },
      if (db.project != null &&
          task.projects != null &&
          task.projects!.isNotEmpty)
        db.project!.id: {
          "relation": task.projects!
              .map((p) => {
                    "id": p.id,
                  })
              .toList()
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
    if (NotionErrorException.isErrorResponse(data)) {
      throw NotionErrorException.fromJson(data);
    }
    return data;
  }

  Future updateTask(Task task) async {
    final db = database;
    if (db.id.isEmpty) return;

    final startDate = task.dueDate?.start.submitFormat;
    final endDate = task.dueDate?.end?.submitFormat;

    final properties = {
      db.title.id: {
        "title": [
          {
            "type": "text",
            "text": {"content": task.title}
          }
        ]
      },
      db.date.id: {
        "date": startDate != null
            ? {
                "start": startDate,
                if (endDate != null) "end": endDate,
                // timezoneは時間指定しないとエラーになる see: https://developers.notion.com/changelog/time-zone-support
              }
            : null
      },
      if (db.priority != null)
        db.priority!.id: {
          "select":
              task.priority?.name != null ? {"name": task.priority!.name} : null
        },
      if (db.project != null)
        db.project!.id: {
          "relation": task.projects != null && task.projects!.isNotEmpty
              ? task.projects!.map((p) => {"id": p.id}).toList()
              : []
        }
    };
    final res = await http.patch(
      Uri.parse('https://api.notion.com/v1/pages/${task.id}'),
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
        StatusCompleteStatusProperty(completeOption: var completeOption?),
        true
      ) =>
        {
          "status": {"id": completeOption.id}
        },
      (StatusCompleteStatusProperty(todoOption: var todoOption?), false) => {
          "status": {"id": todoOption.id}
        },
      (CheckboxCompleteStatusProperty(), _) => {"checkbox": isCompleted},
      (_, _) => throw Exception('Invalid status property'),
    };

    final res = await http.patch(
      Uri.parse('https://api.notion.com/v1/pages/$taskId'),
      headers: headers,
      body: jsonEncode({
        "properties": {status.id: statusProperties},
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
        StatusCompleteStatusProperty(inProgressOption: var inProgressOption?),
        true
      ) =>
        {
          "status": {"id": inProgressOption.id}
        },
      (StatusCompleteStatusProperty(todoOption: var todoOption?), false) => {
          "status": {"id": todoOption.id}
        },
      // checkboxは更新しない
      (CheckboxCompleteStatusProperty(), _) => {"checkbox": false},
      (_, _) => throw Exception('Invalid status property'),
    };

    final res = await http.patch(
      Uri.parse('https://api.notion.com/v1/pages/$taskId'),
      headers: headers,
      body: jsonEncode({
        "properties": {status.id: statusProperties},
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

List<dynamic> _getCompleteStatusFilter(CompleteStatusProperty property,
    {bool onlyComplete = false}) {
  switch ((property, onlyComplete)) {
    case (
        StatusCompleteStatusProperty(completeOption: var completeOption?),
        true
      ):
      return [
        {
          "property": property.id,
          "status": {"equals": completeOption.name}
        }
      ];
    case (StatusCompleteStatusProperty(status: var status), false):
      // 完了グループ, or条件
      final optionIds = status.groups
              .where(
                  (e) => e.name.toLowerCase() == StatusGroupType.complete.value.toLowerCase())
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
          "property": property.id,
          "status": {"equals": completeOptionName}
        };
      }).toList();
    case (CheckboxCompleteStatusProperty(), _):
      return [
        {
          "property": property.id,
          "checkbox": {"equals": true}
        }
      ];
    case (StatusCompleteStatusProperty(completeOption: null), true):
      return [];
  }
}

List<dynamic> _getNotCompleteStatusFilter(CompleteStatusProperty property,
    {bool onlyNotComplete = false}) {
  switch ((property, onlyNotComplete)) {
    case (StatusCompleteStatusProperty(todoOption: var todoOption?), true):
      // 未完了に指定されたオプションステータスのみ
      return [
        {
          "property": property.id,
          "status": {"equals": todoOption.name}
        }
      ];
    case (StatusCompleteStatusProperty(status: var status), false):
      // 完了グループ以外, and条件
      final optionIds = status.groups
              .where(
                  (e) => e.name.toLowerCase() == StatusGroupType.complete.value.toLowerCase())
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
          "property": property.id,
          "status": {"does_not_equal": completeOptionName}
        };
      }).toList();
    case (CheckboxCompleteStatusProperty(), _):
      return [
        {
          "property": property.id,
          "checkbox": {"equals": false}
        }
      ];
    case (StatusCompleteStatusProperty(todoOption: null), true):
      return [];
  }
}

List<dynamic> _getInProgressStatusFilter(TaskDatabase database) {
  switch (database.status) {
    case StatusCompleteStatusProperty(
        id: var id,
        inProgressOption: var inProgressOption
      ):
      if (inProgressOption == null) {
        return [];
      }
      return [
        {
          "property": id,
          "status": {"equals": inProgressOption.name}
        }
      ];
    case CheckboxCompleteStatusProperty():
      return [];
  }
}
