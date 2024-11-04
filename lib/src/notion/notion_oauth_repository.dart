import 'dart:async';

import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotionOAuthRepository {
  final String notionAuthUrl;
  final String clientId;
  final String clientSecret;
  final String redirectUri;

  NotionOAuthRepository(
      this.notionAuthUrl, this.clientId, this.clientSecret, this.redirectUri);

  Future<String?> fetchAccessToken() async {
    try {
      final result = await FlutterWebAuth2.authenticate(
          url: notionAuthUrl, callbackUrlScheme: "notiontodo");
      final code = Uri.parse(result).queryParameters['code'];

      if (code != null) {
        final encoded = base64.encode(utf8.encode('$clientId:$clientSecret'));
        final res = await http.post(
          Uri.parse('https://api.notion.com/v1/oauth/token'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Basic $encoded',
          },
          body: jsonEncode({
            'grant_type': 'authorization_code',
            'code': code,
            'redirect_uri': redirectUri,
          }),
        );
        final data = jsonDecode(res.body);
        return data['access_token'];
      } else {
        throw Exception('oAuth Code is null');
      }
    } catch (e) {
      print('Failed to fetch access token: $e');
      return null;
    }
  }
}
