import 'dart:convert';
import 'package:http/http.dart' as http;

// NotionAPIの仕様上、titleとstatusプロパティは作成できない
enum CreatePropertyType {
  date,
  checkbox,
  select, // 優先度
}

class NotionDatabaseApi {
  final String accessToken;
  late final Map<String, String> headers;

  NotionDatabaseApi(this.accessToken) {
    headers = {
      'Content-Type': 'application/json',
      'Notion-Version': '2022-06-28',
      'Authorization': 'Bearer $accessToken'
    };
  }

  Future fetchAccessibleDatabases() async {
    final res = await http.post(Uri.parse('https://api.notion.com/v1/search'),
        headers: headers,
        body: jsonEncode({
          "query": "",
          "filter": {"value": "database", "property": "object"}
        }));
    final data = jsonDecode(res.body);
    return data['results'];
  }

  Future fetchDatabaseById(String databaseId) async {
    final res = await http.get(
        Uri.parse('https://api.notion.com/v1/databases/$databaseId'),
        headers: headers);
    final data = jsonDecode(res.body);
    return data;
  }

  /// データベースの全ページを取得
  Future<List<Map<String, dynamic>>> fetchDatabasePagesById(
      String databaseId) async {
    final allPages = <Map<String, dynamic>>[];
    String? startCursor;

    do {
      final uri =
          Uri.parse('https://api.notion.com/v1/databases/$databaseId/query');
      final body = <String, dynamic>{
        'page_size': 100,
        'sorts': [
          {
            'timestamp': 'last_edited_time',
            'direction': 'descending'
          }
        ],
      };

      if (startCursor != null) {
        body['start_cursor'] = startCursor;
      }

      final res = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>?;

      if (results != null) {
        allPages.addAll(results.cast<Map<String, dynamic>>());
      }

      startCursor = data['next_cursor'] as String?;
    } while (startCursor != null);

    return allPages;
  }

  Future createProperty(
      String databaseId, CreatePropertyType type, String name) async {
    final body = {
      "properties": {
        name: switch (type) {
          CreatePropertyType.date => {"date": {}},
          CreatePropertyType.checkbox => {"checkbox": {}},
          CreatePropertyType.select => {
              "select": {
                "options": [
                  {"name": "High", "color": "red"},
                  {"name": "Medium", "color": "yellow"},
                  {"name": "Low", "color": "blue"}
                ]
              },
            }
        }
      }
    };
    final res = await http.patch(
        Uri.parse('https://api.notion.com/v1/databases/$databaseId'),
        headers: headers,
        body: jsonEncode(body));
    final data = jsonDecode(res.body);
    return data;
  }

  Future fetchPageById(String pageId) async {
    final res = await http.get(
        Uri.parse('https://api.notion.com/v1/pages/$pageId'),
        headers: headers);
    final data = jsonDecode(res.body);
    return data;
  }

  Future<List<Map<String, dynamic>>> fetchPagesByIds(
      List<String> pageIds) async {
    final pages = <Map<String, dynamic>>[];

    // バッチ処理のために並列でリクエストを送信
    final futures = pageIds.map((id) => fetchPageById(id));
    final results = await Future.wait(futures);

    for (final result in results) {
      if (result != null && result is Map<String, dynamic>) {
        pages.add(result);
      }
    }

    return pages;
  }
}
