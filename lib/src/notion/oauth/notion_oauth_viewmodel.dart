import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/analytics/analytics_service.dart';

import 'notion_oauth_service.dart';

part 'notion_oauth_viewmodel.g.dart';
part 'notion_oauth_viewmodel.freezed.dart';

@freezed
class NotionOAuth with _$NotionOAuth {
  const factory NotionOAuth({
    required String? accessToken,
  }) = _NotionOAuth;

  const NotionOAuth._();

  factory NotionOAuth.initialState() => const NotionOAuth(accessToken: null);

  bool get isAuthenticated => accessToken != null;
}

// バックグラウンドモードでも保持されるようにする
@Riverpod(keepAlive: true)
class NotionOAuthViewModel extends _$NotionOAuthViewModel {
  @override
  Future<NotionOAuth> build() async {
    final currentState = state.valueOrNull;
    if (currentState != null && currentState.accessToken != null) {
      return currentState;
    }

    final accessToken = await ref.watch(notionOAuthServiceProvider.future);

    return NotionOAuth(accessToken: accessToken);
  }

  Future<void> authenticate() async {
    final notionOAuthService = ref.read(notionOAuthServiceProvider.notifier);
    final accessToken = await notionOAuthService.authenticate();
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
    final notionOAuthService = ref.read(notionOAuthServiceProvider.notifier);
    await notionOAuthService.deleteAccessToken();
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
