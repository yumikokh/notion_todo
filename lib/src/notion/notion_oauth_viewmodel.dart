import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../env/env.dart';
import './notion_oauth_service.dart';

part 'notion_oauth_viewmodel.g.dart';

@riverpod
class NotionOAuthViewModel extends _$NotionOAuthViewModel {
  final NotionOAuthService _notionOAuthService = NotionOAuthService(
      Env.notionAuthUrl,
      Env.oAuthClientId,
      Env.oAuthClientSecret,
      Env.redirectUri);

  NotionOAuthViewModel() {
    _initialize();
  }

  @override
  NotionOAuth build() => NotionOAuth.initialState();

  Future<void> _initialize() async {
    final accessToken = await _notionOAuthService.loadAccessToken();
    state = NotionOAuth(accessToken: accessToken);
  }

  Future<void> authenticate() async {
    final accessToken = await _notionOAuthService.fetchAccessToken();
    if (accessToken != null) {
      await _notionOAuthService.saveAccessToken(accessToken);
      state = NotionOAuth(accessToken: accessToken);
    }
  }

  Future<void> deauthenticate() async {
    await _notionOAuthService.deleteAccessToken();
    state = NotionOAuth.initialState();
  }
}

@riverpod
bool isAuthenticated(Ref ref) {
  final viewModel = ref.watch(notionOAuthViewModelProvider);
  return viewModel.accessToken != null;
}
