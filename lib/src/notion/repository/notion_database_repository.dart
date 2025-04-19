import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../oauth/notion_oauth_viewmodel.dart';

part 'notion_database_repository.g.dart';

// NotionAPIの仕様上、titleとstatusプロパティは作成できない
enum CreatePropertyType {
  date,
  checkbox,
  select, // 優先度
}

class NotionDatabaseRepository {
  final String accessToken;
  late final Map<String, String> headers;

  NotionDatabaseRepository(this.accessToken) {
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

  Future fetchDatabase(String databaseId) async {
    final res = await http.get(
        Uri.parse('https://api.notion.com/v1/databases/$databaseId'),
        headers: headers);
    final data = jsonDecode(res.body);
    return data;
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
}

@riverpod
Future<NotionDatabaseRepository?> notionDatabaseRepository(Ref ref) async {
  final accessToken = await ref
      .watch(notionOAuthViewModelProvider.future)
      .then((value) => value.accessToken);
  if (accessToken == null) {
    return null;
  }
  return NotionDatabaseRepository(accessToken);
}
