import 'package:flutter/material.dart';
import 'notion_oauth_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NotionController with ChangeNotifier {
  final NotionOAuthService _notionOAuthService;

  String? _accessToken;

  NotionController(this._notionOAuthService);

  String? get accessToken => _accessToken;

  Future<void> authenticate() async {
    _accessToken = await _notionOAuthService.getAccessToken();
    notifyListeners();
  }

  // Future<void> _saveAccessToken(String? token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('accessToken', token ?? '');
  // }

  // Future<void> _loadAccessToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _accessToken = prefs.getString('accessToken');
  //   notifyListeners();
  // }
}
