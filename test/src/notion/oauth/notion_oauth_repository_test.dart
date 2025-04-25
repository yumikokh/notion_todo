import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tanzaku_todo/src/notion/oauth/notion_oauth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notion_oauth_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterSecureStorage>(),
  MockSpec<SharedPreferences>(),
])
void main() {
  group('initialize', () {
    late NotionOAuthRepository repository;
    late MockFlutterSecureStorage mockSecureStorage;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSecureStorage = MockFlutterSecureStorage();
      mockSharedPreferences = MockSharedPreferences();
      repository = NotionOAuthRepository(
        'notionAuthUrl',
        'clientId',
        'clientSecret',
        'redirectUri',
        mockSecureStorage,
        mockSharedPreferences,
      );
    });

    test('初回起動時かつトークンが存在する場合、トークンを削除する', () async {
      // Arrange
      when(mockSecureStorage.read(key: 'accessToken'))
          .thenAnswer((_) async => 'token');

      // Act
      await repository.initialize();

      // Assert
      verify(mockSharedPreferences.getBool('isFirstLaunch')).called(1);
      verify(mockSecureStorage.read(key: 'accessToken')).called(1);
      verify(mockSecureStorage.delete(key: 'accessToken')).called(1);
      verify(mockSharedPreferences.setBool('isFirstLaunch', false)).called(1);
    });

    test('初回起動時でない場合、トークンは削除されない', () async {
      // Arrange
      when(mockSharedPreferences.getBool('isFirstLaunch')).thenReturn(false);

      // Act
      await repository.initialize();

      // Assert
      verify(mockSharedPreferences.getBool('isFirstLaunch')).called(1);
      verifyNever(mockSecureStorage.read(key: 'accessToken'));
      verifyNever(mockSecureStorage.delete(key: 'accessToken'));
      verify(mockSharedPreferences.setBool('isFirstLaunch', false)).called(1);
    });

    test('初回起動時でもトークンが存在しない場合、トークンは削除されない', () async {
      // Arrange
      when(mockSharedPreferences.getBool('isFirstLaunch')).thenReturn(true);
      when(mockSecureStorage.read(key: 'accessToken'))
          .thenAnswer((_) async => null);

      // Act
      await repository.initialize();

      // Assert
      verify(mockSharedPreferences.getBool('isFirstLaunch')).called(1);
      verify(mockSecureStorage.read(key: 'accessToken')).called(1);
      verifyNever(mockSecureStorage.delete(key: 'accessToken'));
      verify(mockSharedPreferences.setBool('isFirstLaunch', false)).called(1);
    });
  });
}
