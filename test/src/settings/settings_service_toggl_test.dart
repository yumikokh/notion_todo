import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tanzaku_todo/src/settings/settings_service.dart';

void main() {
  group('SettingsService - Toggl関連', () {
    late SettingsService settingsService;

    setUp(() {
      settingsService = SettingsService();
      SharedPreferences.setMockInitialValues({});
    });

    group('Toggl API Token', () {
      test('APIトークンを保存・取得できる', () async {
        // arrange
        const testToken = 'test_api_token_12345';

        // act
        await settingsService.saveTogglApiToken(testToken);
        final result = await settingsService.loadTogglApiToken();

        // assert
        expect(result, testToken);
      });

      test('APIトークンが保存されていない場合nullを返す', () async {
        // act
        final result = await settingsService.loadTogglApiToken();

        // assert
        expect(result, isNull);
      });
    });

    group('Toggl Workspace ID', () {
      test('ワークスペースIDを保存・取得できる', () async {
        // arrange
        const testWorkspaceId = 123456;

        // act
        await settingsService.saveTogglWorkspaceId(testWorkspaceId);
        final result = await settingsService.loadTogglWorkspaceId();

        // assert
        expect(result, testWorkspaceId);
      });

      test('ワークスペースIDが保存されていない場合nullを返す', () async {
        // act
        final result = await settingsService.loadTogglWorkspaceId();

        // assert
        expect(result, isNull);
      });
    });

    group('Toggl Project ID', () {
      test('プロジェクトIDを保存・取得できる', () async {
        // arrange
        const testProjectId = 789012;

        // act
        await settingsService.saveTogglProjectId(testProjectId);
        final result = await settingsService.loadTogglProjectId();

        // assert
        expect(result, testProjectId);
      });

      test('プロジェクトIDにnullを設定できる', () async {
        // arrange
        // 最初に値を設定
        await settingsService.saveTogglProjectId(123);

        // act
        await settingsService.saveTogglProjectId(null);
        final result = await settingsService.loadTogglProjectId();

        // assert
        expect(result, isNull);
      });

      test('プロジェクトIDが保存されていない場合nullを返す', () async {
        // act
        final result = await settingsService.loadTogglProjectId();

        // assert
        expect(result, isNull);
      });
    });

    group('Toggl Enabled', () {
      test('Toggl連携の有効/無効を保存・取得できる', () async {
        // arrange & act & assert
        // デフォルトはfalse
        final defaultResult = await settingsService.loadTogglEnabled();
        expect(defaultResult, false);

        // trueに設定
        await settingsService.saveTogglEnabled(true);
        final enabledResult = await settingsService.loadTogglEnabled();
        expect(enabledResult, true);

        // falseに設定
        await settingsService.saveTogglEnabled(false);
        final disabledResult = await settingsService.loadTogglEnabled();
        expect(disabledResult, false);
      });
    });

    group('isTogglConfigured', () {
      test('すべての設定が揃っている場合trueを返す', () async {
        // arrange
        await settingsService.saveTogglApiToken('test_token');
        await settingsService.saveTogglWorkspaceId(123);
        await settingsService.saveTogglEnabled(true);

        // act
        final result = await settingsService.isTogglConfigured();

        // assert
        expect(result, true);
      });

      test('APIトークンがない場合falseを返す', () async {
        // arrange
        await settingsService.saveTogglWorkspaceId(123);
        await settingsService.saveTogglEnabled(true);

        // act
        final result = await settingsService.isTogglConfigured();

        // assert
        expect(result, false);
      });

      test('APIトークンが空文字の場合falseを返す', () async {
        // arrange
        await settingsService.saveTogglApiToken('');
        await settingsService.saveTogglWorkspaceId(123);
        await settingsService.saveTogglEnabled(true);

        // act
        final result = await settingsService.isTogglConfigured();

        // assert
        expect(result, false);
      });

      test('ワークスペースIDがない場合falseを返す', () async {
        // arrange
        await settingsService.saveTogglApiToken('test_token');
        await settingsService.saveTogglEnabled(true);

        // act
        final result = await settingsService.isTogglConfigured();

        // assert
        expect(result, false);
      });

      test('Toggl連携が無効の場合falseを返す', () async {
        // arrange
        await settingsService.saveTogglApiToken('test_token');
        await settingsService.saveTogglWorkspaceId(123);
        await settingsService.saveTogglEnabled(false);

        // act
        final result = await settingsService.isTogglConfigured();

        // assert
        expect(result, false);
      });

      test('プロジェクトIDは必須ではない', () async {
        // arrange
        await settingsService.saveTogglApiToken('test_token');
        await settingsService.saveTogglWorkspaceId(123);
        await settingsService.saveTogglEnabled(true);
        // プロジェクトIDは設定しない

        // act
        final result = await settingsService.isTogglConfigured();

        // assert
        expect(result, true);
      });
    });
  });
}