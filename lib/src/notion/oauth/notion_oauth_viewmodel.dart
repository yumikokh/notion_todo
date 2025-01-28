import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/analytics/analytics_service.dart';
import 'notion_oauth_service.dart';

part 'notion_oauth_viewmodel.g.dart';

class NotionOAuth {
  final String? accessToken;

  NotionOAuth({
    required this.accessToken,
  });

  bool get isAuthenticated => accessToken != null;

  NotionOAuth.initialState() : accessToken = null;
}

@riverpod
class NotionOAuthViewModel extends _$NotionOAuthViewModel {
  late final NotionOAuthService _notionOAuthService;

  @override
  Future<NotionOAuth> build() async {
    if (state.valueOrNull?.accessToken != null) {
      return NotionOAuth(accessToken: state.valueOrNull?.accessToken);
    }
    _notionOAuthService = await ref.read(notionOAuthServiceProvider.future);
    final accessToken = await _notionOAuthService.initialize();
    return NotionOAuth(accessToken: accessToken);
  }

  Future<void> authenticate() async {
    final accessToken = await _notionOAuthService.authenticate();
    if (accessToken == null) return;

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
