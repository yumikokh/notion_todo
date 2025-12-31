import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/analytics/analytics_service.dart';

import 'notion_oauth_repository.dart';

part 'notion_oauth_viewmodel.g.dart';
part 'notion_oauth_viewmodel.freezed.dart';

@freezed
abstract class NotionOAuth with _$NotionOAuth {
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
  late NotionOAuthRepository _repository;

  @override
  Future<NotionOAuth> build() async {
    final currentState = state.value;
    if (currentState != null && currentState.accessToken != null) {
      return currentState;
    }

    _repository = await ref.watch(notionOAuthRepositoryProvider.future);

    final accessToken = await _repository.loadAccessToken(); // kari

    return NotionOAuth(accessToken: accessToken);
  }

  Future<void> authenticate() async {
    final accessToken = await _repository.fetchAccessToken();
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
    await _repository.deleteAccessToken();
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
