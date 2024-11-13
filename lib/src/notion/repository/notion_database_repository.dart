import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/property.dart';

// - [x] list databases
// - [x] list database pages
// - [] create a database page
// - [x] update a database page
// - [] delete a database page

enum FilterType { today, done, all }

class NotionDatabaseRepository {
  final String _accessToken;
  // ignore: prefer_typing_uninitialized_variables
  late final _headers;

  NotionDatabaseRepository(this._accessToken) {
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

  Future fetchDatabasePages(FilterType type, String databaseId,
      TaskDateProperty dateProperty, TaskStatusProperty statusProperty) async {
    final filter = type == FilterType.today
        ? {
            "and": [
              {
                "property": dateProperty.name,
                "date": {
                  // 今日 '2024-11-11'の形式
                  "on_or_before": DateTime.now().toIso8601String().split('T')[0]
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
          {"property": dateProperty.name, "direction": 'descending'},
          {"timestamp": "last_edited_time", "direction": "descending"}
        ]
      }),
    );
    final data = jsonDecode(res.body);
    return data['results'];
  }

  Future updateStatus(
      String taskId, TaskStatusProperty status, bool isCompleted) async {
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
