import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotionOAuthRepository {
  final String notionAuthUrl;
  final String clientId;
  final String clientSecret;
  final String redirectUri;
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  static const _accessTokenKey = 'accessToken';
  static const _isFirstLaunchKey = 'isFirstLaunch';

  NotionOAuthRepository(this.notionAuthUrl, this.clientId, this.clientSecret,
      this.redirectUri, this.secureStorage, this.sharedPreferences);

  Future<bool> isFirstLaunch() async {
    return sharedPreferences.getBool(_isFirstLaunchKey) ?? true;
  }

  Future<void> setIsFirstLaunch(bool isFirstLaunch) async {
    await sharedPreferences.setBool(_isFirstLaunchKey, isFirstLaunch);
  }

  Future<String?> loadAccessToken() async {
    return await secureStorage.read(key: _accessTokenKey);
  }

  Future<void> saveAccessToken(String accessToken) async {
    await secureStorage.write(key: _accessTokenKey, value: accessToken);
  }

  Future<void> deleteAccessToken() async {
    await secureStorage.delete(key: _accessTokenKey);
  }

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
