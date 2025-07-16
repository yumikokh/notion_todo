import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';

import 'package:tanzaku_todo/src/toggl/toggl_api_service.dart';

import 'toggl_api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('TogglApiService', () {
    late MockClient mockClient;
    late TogglApiService togglApiService;

    setUp(() {
      mockClient = MockClient();
      togglApiService = TogglApiService(
        apiToken: 'test_token',
        workspaceId: 123,
      );
    });

    group('startTimeEntry', () {
      test('正常にタイムエントリーを開始できる', () async {
        // arrange
        final responseJson = {
          'id': 456,
          'description': 'Test Task',
          'start': '2023-01-01T10:00:00Z',
          'stop': null,
          'duration': -1,
          'workspace_id': 123,
          'project_id': null,
        };

        when(mockClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(
              json.encode(responseJson),
              200,
            ));

        // act
        final result = await togglApiService.startTimeEntry(
          description: 'Test Task',
        );

        // assert
        expect(result.id, 456);
        expect(result.description, 'Test Task');
        expect(result.isRunning, true);
        expect(result.workspaceId, 123);
      });

      test('APIエラー時に例外が発生する', () async {
        // arrange
        when(mockClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(
              'Unauthorized',
              401,
            ));

        // act & assert
        expect(
          () => togglApiService.startTimeEntry(description: 'Test Task'),
          throwsA(isA<TogglApiException>()),
        );
      });
    });

    group('getCurrentTimeEntry', () {
      test('現在のタイムエントリーを取得できる', () async {
        // arrange
        final responseJson = {
          'id': 456,
          'description': 'Current Task',
          'start': '2023-01-01T10:00:00Z',
          'stop': null,
          'duration': -1,
          'workspace_id': 123,
          'project_id': null,
        };

        when(mockClient.get(
          any,
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(
              json.encode(responseJson),
              200,
            ));

        // act
        final result = await togglApiService.getCurrentTimeEntry();

        // assert
        expect(result, isNotNull);
        expect(result!.id, 456);
        expect(result.description, 'Current Task');
        expect(result.isRunning, true);
      });

      test('現在のタイムエントリーが無い場合nullを返す', () async {
        // arrange
        when(mockClient.get(
          any,
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(
              '',
              404,
            ));

        // act
        final result = await togglApiService.getCurrentTimeEntry();

        // assert
        expect(result, isNull);
      });
    });

    group('stopTimeEntry', () {
      test('タイムエントリーを停止できる', () async {
        // arrange
        final responseJson = {
          'id': 456,
          'description': 'Stopped Task',
          'start': '2023-01-01T10:00:00Z',
          'stop': '2023-01-01T11:00:00Z',
          'duration': 3600,
          'workspace_id': 123,
          'project_id': null,
        };

        when(mockClient.patch(
          any,
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(
              json.encode(responseJson),
              200,
            ));

        // act
        final result = await togglApiService.stopTimeEntry(456);

        // assert
        expect(result.id, 456);
        expect(result.description, 'Stopped Task');
        expect(result.isRunning, false);
        expect(result.duration, 3600);
      });
    });

    group('getWorkspaces', () {
      test('ワークスペース一覧を取得できる', () async {
        // arrange
        final responseJson = [
          {
            'id': 123,
            'name': 'My Workspace',
          },
          {
            'id': 456,
            'name': 'Another Workspace',
          },
        ];

        when(mockClient.get(
          any,
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(
              json.encode(responseJson),
              200,
            ));

        // act
        final result = await togglApiService.getWorkspaces();

        // assert
        expect(result.length, 2);
        expect(result[0].id, 123);
        expect(result[0].name, 'My Workspace');
        expect(result[1].id, 456);
        expect(result[1].name, 'Another Workspace');
      });
    });

    group('getProjects', () {
      test('プロジェクト一覧を取得できる', () async {
        // arrange
        final responseJson = [
          {
            'id': 789,
            'name': 'Project A',
            'color': '#ff0000',
            'workspace_id': 123,
          },
          {
            'id': 101112,
            'name': 'Project B',
            'color': null,
            'workspace_id': 123,
          },
        ];

        when(mockClient.get(
          any,
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(
              json.encode(responseJson),
              200,
            ));

        // act
        final result = await togglApiService.getProjects();

        // assert
        expect(result.length, 2);
        expect(result[0].id, 789);
        expect(result[0].name, 'Project A');
        expect(result[0].color, '#ff0000');
        expect(result[1].id, 101112);
        expect(result[1].name, 'Project B');
        expect(result[1].color, isNull);
      });
    });

    group('TogglTimeEntry', () {
      test('実行中のタイマーを正しく判定できる', () {
        // arrange & act
        final runningEntry = TogglTimeEntry(
          id: 1,
          description: 'Running Task',
          start: DateTime.now(),
          duration: -1,
          workspaceId: 123,
        );

        final stoppedEntry = TogglTimeEntry(
          id: 2,
          description: 'Stopped Task',
          start: DateTime.now().subtract(const Duration(hours: 1)),
          stop: DateTime.now(),
          duration: 3600,
          workspaceId: 123,
        );

        // assert
        expect(runningEntry.isRunning, true);
        expect(stoppedEntry.isRunning, false);
      });
    });

    group('TogglApiException', () {
      test('適切なエラーメッセージを表示する', () {
        // arrange & act
        final exception = TogglApiException('Test error message');

        // assert
        expect(exception.toString(), 'TogglApiException: Test error message');
        expect(exception.message, 'Test error message');
      });
    });
  });
}