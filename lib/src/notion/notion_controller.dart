import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notion_oauth_service.dart';

class NotionController with ChangeNotifier {
  final NotionOAuthService _notionOAuthService;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  NotionController(this._notionOAuthService) {
    _initialize();
  }

  String? _accessToken;
  String? get accessToken => _accessToken;

  Future<void> authenticate() async {
    _accessToken = await _notionOAuthService.getAccessToken();
    await _saveAccessToken(_accessToken);
    notifyListeners();
  }

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    // 再インストール時に残っていたアクセストークンを削除
    if (isFirstLaunch) {
      await _deleteAccessToken();
      await prefs.setBool('isFirstLaunch', false);
    }

    await _loadAccessToken();
  }

  Future<void> _saveAccessToken(String? token) async {
    await _secureStorage.write(key: 'accessToken', value: token);
  }

  Future<void> _loadAccessToken() async {
    _accessToken = await _secureStorage.read(key: 'accessToken');
    notifyListeners();
  }

  Future<void> _deleteAccessToken() async {
    _accessToken = null;
    await _secureStorage.delete(key: 'accessToken');
    notifyListeners();
  }
}
