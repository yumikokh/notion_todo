import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:home_widget/home_widget.dart';
import 'package:tanzaku_todo/src/notion/model/property.dart';
import 'package:tanzaku_todo/src/notion/model/task_database.dart';
import 'package:tanzaku_todo/src/widget/widget_service.dart';

@GenerateNiceMocks([
  MockSpec<HomeWidget>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WidgetTask', () {
    test('WidgetTaskからJSONへの変換と復元が正しく行われること', () {
      final widgetTask = WidgetTask(
        id: 'task-id-123',
        title: 'テストタスク',
        isCompleted: false,
        isSubmitted: true,
        isOverdue: false,
      );

      // JSONに変換してからStringに変換し、再度デコードすることでJSONの互換性を確認
      final jsonString = jsonEncode(widgetTask.toJson());

      // 必要なプロパティが含まれているか確認
      expect(jsonString.contains('"id"'), isTrue);
      expect(jsonString.contains('"title"'), isTrue);
      expect(jsonString.contains('"isCompleted"'), isTrue);
      expect(jsonString.contains('"isSubmitted"'), isTrue);
      expect(jsonString.contains('"isOverdue"'), isTrue);

      // JSONからオブジェクトに復元
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final restored = WidgetTask.fromJson(jsonMap);

      // 復元されたオブジェクトの値を検証
      expect(restored.id, 'task-id-123');
      expect(restored.title, 'テストタスク');
      expect(restored.isCompleted, false);
      expect(restored.isSubmitted, true);
      expect(restored.isOverdue, false);
    });

    test('JSONをシリアライズ・デシリアライズしても内容が保持されること', () {
      final widgetTask = WidgetTask(
        id: 'task-id-123',
        title: 'テストタスク',
        isCompleted: false,
        isSubmitted: true,
        isOverdue: false,
      );

      final jsonString = jsonEncode(widgetTask.toJson());
      final decodedJson = jsonDecode(jsonString) as Map<String, dynamic>;
      final restored = WidgetTask.fromJson(decodedJson);

      expect(restored.id, 'task-id-123');
      expect(restored.title, 'テストタスク');
      expect(restored.isCompleted, false);
    });
  });

  group('WidgetValue', () {
    test('WidgetValueからJSONへの変換と復元が正しく行われること', () {
      final taskDatabase = TaskDatabase(
        id: 'database-id-123',
        name: 'テストデータベース',
        title: TitleProperty(
          id: 'title-id',
          name: 'タイトル',
          title: 'タイトル',
        ),
        status: StatusCompleteStatusProperty(
          id: 'status-id',
          name: 'ステータス',
          status: (
            groups: [
              StatusGroup(
                id: 'complete-group',
                name: StatusGroupType.complete.value,
                color: NotionColor.green,
                optionIds: ['complete-option'],
              ),
            ],
            options: [
              StatusOption(
                id: 'complete-option',
                name: '完了',
                color: NotionColor.green,
              ),
            ],
          ),
          todoOption: StatusOption(
            id: 'todo-option',
            name: '未完了',
            color: NotionColor.gray,
          ),
          inProgressOption: StatusOption(
            id: 'in-progress-option',
            name: '進行中',
            color: NotionColor.blue,
          ),
          completeOption: StatusOption(
            id: 'complete-option',
            name: '完了',
            color: NotionColor.green,
          ),
        ),
        date: DateProperty(
          id: 'date-id',
          name: '日付',
        ),
        priority: SelectProperty(
          id: 'priority-id',
          name: '優先度',
          select: (
            options: [
              SelectOption(
                id: 'high-priority',
                name: '高',
                color: NotionColor.red,
              ),
              SelectOption(
                id: 'medium-priority',
                name: '中',
                color: NotionColor.yellow,
              ),
              SelectOption(
                id: 'low-priority',
                name: '低',
                color: NotionColor.blue,
              ),
            ],
          ),
        ),
      );

      final tasks = [
        WidgetTask(
          id: 'task1',
          title: 'タスク1',
          isCompleted: false,
          isSubmitted: true,
          isOverdue: false,
        ),
        WidgetTask(
          id: 'task2',
          title: 'タスク2',
          isCompleted: true,
          isSubmitted: true,
          isOverdue: false,
        ),
      ];

      final widgetValue = WidgetValue(
        tasks: tasks,
        accessToken: 'test-token',
        taskDatabase: taskDatabase,
        locale: 'ja',
      );

      // JSONに変換してからStringに変換し、再度デコードすることでJSONの互換性を確認
      final jsonString = jsonEncode(widgetValue.toJson());

      // 必要なプロパティが含まれているか確認
      expect(jsonString.contains('"tasks"'), isTrue);
      expect(jsonString.contains('"accessToken"'), isTrue);
      expect(jsonString.contains('"locale"'), isTrue);
      expect(jsonString.contains('"taskDatabase"'), isTrue);

      // JSONからオブジェクトに復元
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final restored = WidgetValue.fromJson(jsonMap);

      // 復元されたオブジェクトの値を検証
      expect(restored.tasks?.length, 2);
      expect(restored.tasks?[0].id, 'task1');
      expect(restored.tasks?[1].title, 'タスク2');
      expect(restored.accessToken, 'test-token');
      expect(restored.taskDatabase?.id, 'database-id-123');
      expect(restored.locale, 'ja');

      // 優先度が正しく復元されていることを確認
      expect(restored.taskDatabase?.priority?.id, 'priority-id');
      expect(restored.taskDatabase?.priority?.name, '優先度');
    });

    test('JSONをシリアライズ・デシリアライズしても必須情報が保持されること', () {
      // 最小限の情報だけを持つWidgetValueをテスト
      final minimalWidgetValue = WidgetValue(
        accessToken: 'minimal-token',
        locale: 'en',
      );

      final jsonString = jsonEncode(minimalWidgetValue.toJson());
      final decodedJson = jsonDecode(jsonString) as Map<String, dynamic>;
      final restored = WidgetValue.fromJson(decodedJson);

      expect(restored.tasks, isNull);
      expect(restored.accessToken, 'minimal-token');
      expect(restored.taskDatabase, isNull);
      expect(restored.locale, 'en');
    });
  });
}
