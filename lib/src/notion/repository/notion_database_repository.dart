import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../oauth/notion_oauth_viewmodel.dart';

part 'notion_database_repository.g.dart';

class NotionDatabaseRepository {
  final String accessToken;
  // ignore: prefer_typing_uninitialized_variables
  late final _headers;

  NotionDatabaseRepository(this.accessToken) {
    _headers = {
      'Content-Type': 'application/json',
      'Notion-Version': '2022-06-28',
      'Authorization': 'Bearer $accessToken'
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
}

@riverpod
NotionDatabaseRepository? notionDatabaseRepository(Ref ref) {
  final accessToken = ref.watch(notionOAuthViewModelProvider).accessToken;
  if (accessToken == null) {
    return null;
  }
  return NotionDatabaseRepository(accessToken);
}
