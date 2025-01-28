import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tanzaku_todo/src/notion/oauth/notion_oauth_service.dart';
import 'package:tanzaku_todo/src/notion/repository/notion_oauth_repository.dart';

@GenerateNiceMocks([
  MockSpec<NotionOAuthRepository>(),
])
import 'notion_oauth_service_test.mocks.dart';

void main() {
  late NotionOAuthService service;
  late MockNotionOAuthRepository mockRepository;

  const testToken = 'test_token';

  setUp(() async {
    mockRepository = MockNotionOAuthRepository();
    service = NotionOAuthService(mockRepository);
  });

  group('initialize', () {
    test('初回起動時かつトークンが存在する場合、トークンを削除する', () async {
      when(mockRepository.isFirstLaunch()).thenAnswer((_) async => true);
      when(mockRepository.loadAccessToken()).thenAnswer((_) async => testToken);

      final result = await service.initialize();

      verify(mockRepository.deleteAccessToken()).called(1);
      verify(mockRepository.setIsFirstLaunch(false)).called(1);
      expect(result, null);
    });

    test('初回起動時かつトークンが存在しない場合、初期化フラグのみ設定する', () async {
      when(mockRepository.isFirstLaunch()).thenAnswer((_) async => true);
      when(mockRepository.loadAccessToken()).thenAnswer((_) async => null);

      final result = await service.initialize();

      verifyNever(mockRepository.deleteAccessToken());
      verify(mockRepository.setIsFirstLaunch(false)).called(1);
      expect(result, null);
    });

    test('2回目以降の起動時、トークンを保持する', () async {
      when(mockRepository.isFirstLaunch()).thenAnswer((_) async => false);
      when(mockRepository.loadAccessToken()).thenAnswer((_) async => testToken);

      final result = await service.initialize();

      verifyNever(mockRepository.deleteAccessToken());
      verifyNever(mockRepository.setIsFirstLaunch(any));
      expect(result, testToken);
    });
  });

  group('authenticate', () {
    test('認証成功時、アクセストークンを保存する', () async {
      when(mockRepository.fetchAccessToken())
          .thenAnswer((_) async => testToken);

      final result = await service.authenticate();

      verify(mockRepository.saveAccessToken(testToken)).called(1);
      expect(result, testToken);
    });

    test('認証失敗時、アクセストークンを保存しない', () async {
      when(mockRepository.fetchAccessToken()).thenAnswer((_) async => null);

      final result = await service.authenticate();

      verifyNever(mockRepository.saveAccessToken(any));
      expect(result, null);
    });
  });

  group('deleteAccessToken', () {
    test('アクセストークンを削除する', () async {
      await service.deleteAccessToken();

      verify(mockRepository.deleteAccessToken()).called(1);
    });
  });
}
