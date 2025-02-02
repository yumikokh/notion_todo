import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzaku_todo/src/notion/oauth/notion_oauth_service.dart';
import 'package:tanzaku_todo/src/notion/repository/notion_oauth_repository.dart';
import 'package:tanzaku_todo/src/common/analytics/analytics_service.dart';

@GenerateNiceMocks([
  MockSpec<NotionOAuthRepository>(),
  MockSpec<AnalyticsService>(),
])
import 'notion_oauth_service_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  late ProviderContainer container;
  late MockNotionOAuthRepository mockRepository;
  late MockAnalyticsService mockAnalyticsService;
  const testToken = 'test_token';

  setUp(() async {
    mockRepository = MockNotionOAuthRepository();
    mockAnalyticsService = MockAnalyticsService();

    container = ProviderContainer(
      overrides: [
        notionOAuthRepositoryProvider.overrideWith(
          (ref) => Future.value(mockRepository),
        ),
        analyticsServiceProvider.overrideWithValue(mockAnalyticsService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('build', () {
    test('初回起動時かつトークンが存在する場合、トークンを削除しアナリティクスを送信する', () async {
      when(mockRepository.isFirstLaunch()).thenAnswer((_) async => true);
      when(mockRepository.loadAccessToken()).thenAnswer((_) async => testToken);
      when(mockAnalyticsService.logNotionAuth(
        action: 'reinstalled',
      )).thenAnswer((_) async {});

      final result = await container.read(notionOAuthServiceProvider.future);

      verify(mockRepository.loadAccessToken()).called(1);
      verify(mockRepository.saveAccessToken(testToken)).called(1);
      verify(mockRepository.deleteAccessToken()).called(1);
      verify(mockRepository.setIsFirstLaunch(false)).called(1);
      verify(mockAnalyticsService.logNotionAuth(
        action: 'reinstalled',
      )).called(1);
      expect(result, null);
    });

    test('初回起動時かつトークンが存在する場合でアナリティクスがエラーの場合も、トークンは削除される', () async {
      when(mockRepository.isFirstLaunch()).thenAnswer((_) async => true);
      when(mockRepository.loadAccessToken()).thenAnswer((_) async => testToken);
      when(mockAnalyticsService.logNotionAuth(
        action: 'reinstalled',
      )).thenThrow(Exception('Analytics error'));

      final result = await container.read(notionOAuthServiceProvider.future);

      verify(mockRepository.loadAccessToken()).called(1);
      verify(mockRepository.saveAccessToken(testToken)).called(1);
      verify(mockRepository.deleteAccessToken()).called(1);
      verify(mockRepository.setIsFirstLaunch(false)).called(1);
      verify(mockAnalyticsService.logNotionAuth(
        action: 'reinstalled',
      )).called(1);
      expect(result, null);
    });

    test('初回起動時かつトークンが存在しない場合、初期化フラグのみ設定する', () async {
      when(mockRepository.isFirstLaunch()).thenAnswer((_) async => true);
      when(mockRepository.loadAccessToken()).thenAnswer((_) async => null);

      final result = await container.read(notionOAuthServiceProvider.future);

      verify(mockRepository.loadAccessToken()).called(1);
      verifyNever(mockRepository.deleteAccessToken());
      verify(mockRepository.setIsFirstLaunch(false)).called(1);
      expect(result, null);
    });

    test('2回目以降の起動時、トークンを保持する', () async {
      when(mockRepository.isFirstLaunch()).thenAnswer((_) async => false);
      when(mockRepository.loadAccessToken()).thenAnswer((_) async => testToken);

      final result = await container.read(notionOAuthServiceProvider.future);

      verify(mockRepository.loadAccessToken()).called(1);
      verify(mockRepository.saveAccessToken(testToken)).called(1);
      verifyNever(mockRepository.setIsFirstLaunch(false));
      verifyNever(mockRepository.deleteAccessToken());
      expect(result, testToken);
    });
  });

  group('authenticate', () {
    setUp(() async {
      // サービスの初期化を待つ
      await container.read(notionOAuthServiceProvider.future);
    });

    test('認証成功時、アクセストークンを保存する', () async {
      when(mockRepository.fetchAccessToken())
          .thenAnswer((_) async => testToken);

      final service = container.read(notionOAuthServiceProvider.notifier);
      final result = await service.authenticate();

      verify(mockRepository.saveAccessToken(testToken)).called(1);
      expect(result, testToken);
    });

    test('認証失敗時、アクセストークンを保存しない', () async {
      when(mockRepository.fetchAccessToken()).thenAnswer((_) async => null);

      final service = container.read(notionOAuthServiceProvider.notifier);
      final result = await service.authenticate();

      verify(mockRepository.fetchAccessToken()).called(1);
      verifyNever(mockRepository.saveAccessToken(testToken));
      expect(result, null);
    });
  });

  group('deleteAccessToken', () {
    setUp(() async {
      // サービスの初期化を待つ
      await container.read(notionOAuthServiceProvider.future);
    });

    test('アクセストークンを削除する', () async {
      final service = container.read(notionOAuthServiceProvider.notifier);
      await service.deleteAccessToken();

      verify(mockRepository.deleteAccessToken()).called(1);
    });
  });
}
