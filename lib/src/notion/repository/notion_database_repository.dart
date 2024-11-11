import 'dart:convert';
import 'package:http/http.dart' as http;

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
}
