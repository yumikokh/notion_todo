import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzaku_todo/src/settings/task_database/task_database_service.dart';
import 'package:tanzaku_todo/src/notion/model/task_database.dart';
import 'package:tanzaku_todo/src/notion/model/property.dart';

void main() {
  late TaskDatabaseService service;

  setUp(() {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    service = TaskDatabaseService(notionDatabaseRepository: null);
  });

  group('TaskDatabaseService', () {
    test('初期状態では null を返す', () async {
      final result = await service.loadSetting();
      expect(result, isNull);
    });

    test('保存したデータを読み込める', () async {
      var taskDatabase = TaskDatabase(
        id: 'test-id',
        name: 'Test Database',
        title: TitleProperty(
          id: 'title-id',
          name: 'Title',
          title: '',
        ),
        status: CheckboxCompleteStatusProperty(
          id: 'status-id',
          name: 'Status',
          checked: false,
        ),
        date: DateProperty(
          id: 'date-id',
          name: 'Date',
          date: null,
        ),
      );

      await service.save(taskDatabase);

      // 保存されたJSONデータを確認
      final pref = await SharedPreferences.getInstance();
      final savedJson = pref.getString('taskDatabase');
      print('Saved JSON: $savedJson');
      if (savedJson != null) {
        print('Decoded JSON: ${jsonDecode(savedJson)}');
      }

      final result = await service.loadSetting();

      expect(result, isNotNull);
      expect(result?.id, equals('test-id'));
      expect(result?.name, equals('Test Database'));
      expect(result?.title.id, equals('title-id'));
      expect(result?.status.id, equals('status-id'));
      expect(result?.date.id, equals('date-id'));
    });

    test('clear で保存したデータを削除できる', () async {
      var taskDatabase = TaskDatabase(
        id: 'test-id',
        name: 'Test Database',
        title: TitleProperty(
          id: 'title-id',
          name: 'Title',
          title: '',
        ),
        status: CheckboxCompleteStatusProperty(
          id: 'status-id',
          name: 'Status',
          checked: false,
        ),
        date: DateProperty(
          id: 'date-id',
          name: 'Date',
          date: null,
        ),
      );

      await service.save(taskDatabase);
      await service.clear();
      final result = await service.loadSetting();

      expect(result, isNull);
    });

    test('不正なJSONデータが保存されている場合はnullを返す', () async {
      final pref = await SharedPreferences.getInstance();
      await pref.setString('taskDatabase', '{"invalid": "json"}');

      final result = await service.loadSetting();
      expect(result, isNull);
    });
  });
}
