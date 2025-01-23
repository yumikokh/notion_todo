import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../env/env.dart';
import '../../common/analytics/analytics_service.dart';
import 'notion_oauth_service.dart';

part 'notion_oauth_viewmodel.g.dart';

@riverpod
class NotionOAuthViewModel extends _$NotionOAuthViewModel {
  final NotionOAuthService _notionOAuthService = NotionOAuthService(
      Env.notionAuthUrl,
      Env.oAuthClientId,
      Env.oAuthClientSecret,
      Env.redirectUri);

  @override
  Future<NotionOAuth> build() async {
    return await _initialize();
  }

  Future<NotionOAuth> _initialize() async {
    final accessToken = await _notionOAuthService.initialize();
    return NotionOAuth(accessToken: accessToken);
  }

  Future<void> authenticate() async {
    final accessToken = await _notionOAuthService.fetchAccessToken();
    if (accessToken != null) {
      await _notionOAuthService.saveAccessToken(accessToken);
      state = AsyncValue.data(NotionOAuth(accessToken: accessToken));

      try {
        final analytics = ref.read(analyticsServiceProvider);
        await analytics.logSettingsChanged(
          settingName: 'notion_auth',
          value: 'authenticated',
        );
      } catch (e) {
        print('Analytics error: $e');
      }
    }
  }

  Future<void> deauthenticate() async {
    await _notionOAuthService.deleteAccessToken();
    state = AsyncValue.data(NotionOAuth.initialState());

    try {
      final analytics = ref.read(analyticsServiceProvider);
      await analytics.logSettingsChanged(
        settingName: 'notion_auth',
        value: 'deauthenticated',
      );
    } catch (e) {
      print('Analytics error: $e');
    }
  }
}
