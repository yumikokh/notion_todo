import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzaku_todo/src/settings/task_database/task_database_service.dart';
import 'package:tanzaku_todo/src/notion/model/task_database.dart';
import 'package:tanzaku_todo/src/notion/model/property.dart';

void main() {
  late TaskDatabaseService service;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    service = TaskDatabaseService(notionDatabaseRepository: null);
  });

  group('TaskDatabaseService', () {
    test('初期状態では null を返す', () async {
      final result = await service.loadSetting();
      expect(result, isNull);
    });

    test('保存したデータを読み込める', () async {
      const taskDatabase = TaskDatabase(
        id: 'test-id',
        name: 'Test Database',
        title: TaskTitleProperty(
          id: 'title-id',
          name: 'Title',
          type: PropertyType.title,
          title: '',
        ),
        status: TaskStatusProperty.checkbox(
          id: 'status-id',
          name: 'Status',
          type: PropertyType.checkbox,
          checked: false,
        ),
        date: TaskDateProperty(
          id: 'date-id',
          name: 'Date',
          type: PropertyType.date,
          date: null,
        ),
      );

      await service.save(taskDatabase);
      final result = await service.loadSetting();

      expect(result, isNotNull);
      expect(result?.id, equals('test-id'));
      expect(result?.name, equals('Test Database'));
      expect(result?.title.id, equals('title-id'));
      expect(result?.status.id, equals('status-id'));
      expect(result?.date.id, equals('date-id'));
    });

    test('clear で保存したデータを削除できる', () async {
      const taskDatabase = TaskDatabase(
        id: 'test-id',
        name: 'Test Database',
        title: TaskTitleProperty(
          id: 'title-id',
          name: 'Title',
          type: PropertyType.title,
          title: '',
        ),
        status: TaskStatusProperty.checkbox(
          id: 'status-id',
          name: 'Status',
          type: PropertyType.checkbox,
          checked: false,
        ),
        date: TaskDateProperty(
          id: 'date-id',
          name: 'Date',
          type: PropertyType.date,
          date: null,
        ),
      );

      await service.save(taskDatabase);
      await service.clear();
      final result = await service.loadSetting();

      expect(result, isNull);
    });
  });
}
