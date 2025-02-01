import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/analytics/analytics_service.dart';
import 'notion_oauth_service.dart';

part 'notion_oauth_viewmodel.g.dart';
part 'notion_oauth_viewmodel.freezed.dart';

@freezed
class NotionOAuth with _$NotionOAuth {
  NotionOAuth._();

  const factory NotionOAuth({
    required String? accessToken,
  }) = _NotionOAuth;

  factory NotionOAuth.initialState() => const NotionOAuth(accessToken: null);

  bool get isAuthenticated => accessToken != null;
}

@Riverpod(keepAlive: true)
class NotionOAuthViewModel extends _$NotionOAuthViewModel {
  late final NotionOAuthService _notionOAuthService;

  @override
  Future<NotionOAuth> build() async {
    final currentState = state.valueOrNull;
    if (currentState != null && currentState.accessToken != null) {
      return currentState;
    }

    _notionOAuthService = await ref.watch(notionOAuthServiceProvider.future);
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
