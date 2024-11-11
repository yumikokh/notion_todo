import 'dart:convert';
import 'package:http/http.dart' as http;

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
      String dateProperty, String statusProperty) async {
    final headers = {
      'Content-Type': 'application/json',
      'Notion-Version': '2022-06-28',
      'Authorization': 'Bearer $_accessToken',
    };
    final filter = type == FilterType.today
        ? {
            "property": dateProperty,
            "date": {
              "equals": DateTime.now().toIso8601String().substring(0, 10),
            }
          }
        : type == FilterType.done
            ? {
                "property": statusProperty,
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
        // "sorts": [
        //   {"property": dateProperty, "direction": "ascending"},
        //   {"timestamp": "last_edited_time", "direction": "descending"}
        // ]
      }),
    );
    final data = jsonDecode(res.body);
    return data['results'];
  }
}
