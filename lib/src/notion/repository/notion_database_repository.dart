import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notion_todo/src/notion/entity/property.dart';

// - [x] list databases
// - [x] list database pages
// - [] create a database page
// - [] update a database page
// - [] delete a database page

enum FilterType { today, done, all }

class NotionDatabaseRepository {
  final String _accessToken;

  NotionDatabaseRepository(this._accessToken);

  Future fetchAccessibleDatabases() async {
    final headers = {
      'Content-Type': 'application/json',
      'Notion-Version': '2022-06-28',
      'Authorization': 'Bearer $_accessToken',
    };
    final res = await http.post(Uri.parse('https://api.notion.com/v1/search'),
        headers: headers,
        body: jsonEncode({
          "query": "",
          "filter": {"value": "database", "property": "object"}
        }));
    final data = jsonDecode(res.body);
    return data['results'];
  }

  Future fetchDatabasePages(String databaseId, FilterType type,
      TaskDateProperty dateProperty, TaskStatusProperty statusProperty) async {
    final headers = {
      'Content-Type': 'application/json',
      'Notion-Version': '2022-06-28',
      'Authorization': 'Bearer $_accessToken',
    };
    final filter = type == FilterType.today
        ? {
            "and": [
              {
                "property": dateProperty.name,
                "date": {
                  // 今日 '2024-11-11'の形式
                  "equals": DateTime.now().toIso8601String().split('T')[0]
                }
              },
              // ...statusProperty.status.groups
              //     .firstWhere(
              //       (e) => e.name == 'Complete',
              //     )
              //     .option_ids
              //     .map((e) => statusProperty.status.options.firstWhere(
              //           (e2) => e2.id == e,
              //         ))
              //     .map((e) => {
              //           "property": statusProperty.name,
              //           "select": {"equals": e.name}
              //         })
            ]
          }
        : type == FilterType.done
            ? {
                "property": statusProperty.name,
                "select": {
                  "equals": "Done" // TODO
                }
              }
            : {};
    final res = await http.post(
      Uri.parse('https://api.notion.com/v1/databases/$databaseId/query'),
      headers: headers,
      body: jsonEncode({
        "filter": filter,
        "sorts": [
          {"property": dateProperty.name, "direction": "ascending"},
          {"timestamp": "last_edited_time", "direction": "descending"}
        ]
      }),
    );
    final data = jsonDecode(res.body);
    print('results: ${data['results']}');
    return data['results'];
  }
}
