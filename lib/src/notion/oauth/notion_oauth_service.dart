import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/analytics/analytics_service.dart';
import '../../env/env.dart';
import '../repository/notion_oauth_repository.dart';

part 'notion_oauth_service.g.dart';

@riverpod
Future<NotionOAuthService> notionOAuthService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage(
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  final repository = NotionOAuthRepository(
    Env.notionAuthUrl,
    Env.oAuthClientId,
    Env.oAuthClientSecret,
    Env.redirectUri,
    secureStorage,
    prefs,
  );
  final analytics = ref.read(analyticsServiceProvider);
  return NotionOAuthService(repository, analytics);
}

class NotionOAuthService {
  final NotionOAuthRepository _notionOAuthRepository;
  final AnalyticsService _analyticsService;

  NotionOAuthService(
    this._notionOAuthRepository,
    this._analyticsService,
  );

  Future<String?> initialize() async {
    final isFirstLaunch = await _notionOAuthRepository.isFirstLaunch();
    final currentToken = await _notionOAuthRepository.loadAccessToken();

    // 初回起動時かつトークンが存在する場合のみ削除
    // これにより、正常なアプリの初回起動時にはトークンを削除せず
    // アプリの再インストール時のみトークンを削除する
    if (isFirstLaunch && currentToken != null) {
      await deleteAccessToken();
      await _notionOAuthRepository.setIsFirstLaunch(false);

      try {
        await _analyticsService.logNotionAuth(
          action: 'reinstalled',
        );
      } catch (e) {
        print('Analytics error: $e');
      }

      return null;
    }

    // 初回起動だが、トークンが存在しない場合は、フラグのみ更新
    if (isFirstLaunch) {
      await _notionOAuthRepository.setIsFirstLaunch(false);
    }

    return currentToken;
  }

  Future<String?> authenticate() async {
    final code = await _notionOAuthRepository.fetchAccessToken();
    if (code == null) return null;
    await _notionOAuthRepository.saveAccessToken(code);
    return code;
  }

  Future<void> deleteAccessToken() async {
    await _notionOAuthRepository.deleteAccessToken();
  }
}
