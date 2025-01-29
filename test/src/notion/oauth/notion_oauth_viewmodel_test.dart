import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tanzaku_todo/src/common/analytics/analytics_service.dart';
import 'package:tanzaku_todo/src/notion/oauth/notion_oauth_service.dart';
import 'package:tanzaku_todo/src/notion/oauth/notion_oauth_viewmodel.dart';

@GenerateNiceMocks([
  MockSpec<NotionOAuthService>(),
  MockSpec<AnalyticsService>(),
])
import 'notion_oauth_viewmodel_test.mocks.dart';

void main() {
  late ProviderContainer container;
  late MockNotionOAuthService mockOAuthService;
  late MockAnalyticsService mockAnalyticsService;

  const testToken = 'test_token';

  setUp(() async {
    mockOAuthService = MockNotionOAuthService();
    mockAnalyticsService = MockAnalyticsService();

    container = ProviderContainer(
      overrides: [
        analyticsServiceProvider.overrideWithValue(mockAnalyticsService),
        notionOAuthServiceProvider.overrideWith(
          (ref) => Future.value(mockOAuthService),
        ),
      ],
    );

    // NotionOAuthServiceのモックの振る舞いを設定
    when(mockOAuthService.initialize()).thenAnswer((_) async => testToken);
  });

  tearDown(() {
    container.dispose();
  });

  group('build', () {
    test('初期化時、アクセストークンを読み込む', () async {
      final state = await container.read(notionOAuthViewModelProvider.future);

      expect(state.accessToken, testToken);
      expect(state.isAuthenticated, true);
    });

    test('初期化時、アクセストークンがnullの場合', () async {
      when(mockOAuthService.initialize()).thenAnswer((_) async => null);

      final state = await container.read(notionOAuthViewModelProvider.future);

      expect(state.accessToken, null);
      expect(state.isAuthenticated, false);
    });
  });

  group('authenticate', () {
    test('認証成功時、アクセストークンを保存する', () async {
      // 初期化を待つ
      await container.read(notionOAuthViewModelProvider.future);

      when(mockOAuthService.authenticate()).thenAnswer((_) async => testToken);
      when(mockAnalyticsService.logSettingsChanged(
        settingName: 'notion_auth',
        value: 'authenticated',
      )).thenAnswer((_) async {});

      final viewModel = container.read(notionOAuthViewModelProvider.notifier);
      await viewModel.authenticate();

      verify(mockAnalyticsService.logSettingsChanged(
        settingName: 'notion_auth',
        value: 'authenticated',
      )).called(1);

      final state = container.read(notionOAuthViewModelProvider).value;
      expect(state?.accessToken, testToken);
      expect(state?.isAuthenticated, true);
    });

    test('認証失敗時、アクセストークンを保存しない', () async {
      // 初期化を待つ
      await container.read(notionOAuthViewModelProvider.future);

      when(mockOAuthService.authenticate()).thenAnswer((_) async => null);

      final viewModel = container.read(notionOAuthViewModelProvider.notifier);
      await viewModel.authenticate();

      verifyNever(mockAnalyticsService.logSettingsChanged(
        settingName: 'notion_auth',
        value: 'authenticated',
      ));

      final state = container.read(notionOAuthViewModelProvider).value;
      expect(state?.accessToken, testToken); // 初期状態のまま
    });
  });

  group('deauthenticate', () {
    test('認証解除時、アクセストークンを削除する', () async {
      // 初期化を待つ
      await container.read(notionOAuthViewModelProvider.future);

      when(mockAnalyticsService.logSettingsChanged(
        settingName: 'notion_auth',
        value: 'deauthenticated',
      )).thenAnswer((_) async {});

      final viewModel = container.read(notionOAuthViewModelProvider.notifier);
      await viewModel.deauthenticate();

      verify(mockOAuthService.deleteAccessToken()).called(1);
      verify(mockAnalyticsService.logSettingsChanged(
        settingName: 'notion_auth',
        value: 'deauthenticated',
      )).called(1);

      final state = container.read(notionOAuthViewModelProvider).value;
      expect(state?.accessToken, null);
      expect(state?.isAuthenticated, false);
    });

    test('認証解除時にAnalyticsでエラーが発生しても、トークンは削除される', () async {
      // 初期化を待つ
      await container.read(notionOAuthViewModelProvider.future);

      when(mockAnalyticsService.logSettingsChanged(
        settingName: 'notion_auth',
        value: 'deauthenticated',
      )).thenThrow(Exception('Analytics error'));

      final viewModel = container.read(notionOAuthViewModelProvider.notifier);
      await viewModel.deauthenticate();

      verify(mockOAuthService.deleteAccessToken()).called(1);
      final state = container.read(notionOAuthViewModelProvider).value;
      expect(state?.accessToken, null);
      expect(state?.isAuthenticated, false);
    });
  });
}
