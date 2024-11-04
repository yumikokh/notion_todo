import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './notion_oauth_repository.dart';

class NotionOAuth {
  final String? accessToken;

  NotionOAuth({
    required this.accessToken,
  });

  NotionOAuth.initialState() : accessToken = null;
}

class NotionOAuthService {
  final String notionAuthUrl;
  final String clientId;
  final String clientSecret;
  final String redirectUri;

  static const _accessTokenKey = 'accessToken';
  late final NotionOAuthRepository _notionOAuthRepository;
  late final FlutterSecureStorage _secureStorage;

  NotionOAuthService(
      this.notionAuthUrl, this.clientId, this.clientSecret, this.redirectUri) {
    _notionOAuthRepository = NotionOAuthRepository(
        notionAuthUrl, clientId, clientSecret, redirectUri);
    _secureStorage = const FlutterSecureStorage();
    _initialize();
  }

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    // 再インストール時に残っていたアクセストークンを削除
    if (isFirstLaunch) {
      await deleteAccessToken();
      await prefs.setBool('isFirstLaunch', false);
    }

    await loadAccessToken();
  }

  Future<String?> fetchAccessToken() async {
    return _notionOAuthRepository.fetchAccessToken();
  }

  Future<String?> loadAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(key: _accessTokenKey, value: token);
  }

  Future<void> deleteAccessToken() async {
    await _secureStorage.delete(key: _accessTokenKey);
  }
}
