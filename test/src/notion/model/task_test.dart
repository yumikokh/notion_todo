import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tanzaku_todo/src/notion/model/property.dart';
import 'package:tanzaku_todo/src/notion/model/task.dart';

void main() {
  group('Task', () {
    group('isCompleted', () {
      test('TaskStatusCheckbox - checked: true', () {
        const task = Task(
          id: '1',
          title: 'test',
          status: TaskStatus.checkbox(checkbox: true),
          dueDate: null,
          url: null,
        );
        expect(task.isCompleted, true);
      });

      test('TaskStatusCheckbox - checked: false', () {
        const task = Task(
          id: '1',
          title: 'test',
          status: TaskStatus.checkbox(checkbox: false),
          dueDate: null,
          url: null,
        );
        expect(task.isCompleted, false);
      });

      test('TaskStatusStatus - group: Complete', () {
        var task = Task(
          id: '1',
          title: 'test',
          status: TaskStatus.status(
            group: StatusGroup(
              id: '1',
              name: StatusGroupType.complete.value,
              color: NotionColor.gray,
              optionIds: [],
            ),
            option: null,
          ),
          dueDate: null,
          url: null,
        );
        expect(task.isCompleted, true);
      });

      test('TaskStatusStatus - group: To-do', () {
        var task = Task(
          id: '1',
          title: 'test',
          status: TaskStatus.status(
            group: StatusGroup(
              id: '1',
              name: StatusGroupType.todo.value,
              color: NotionColor.gray,
              optionIds: [],
            ),
            option: null,
          ),
          dueDate: null,
          url: null,
        );
        expect(task.isCompleted, false);
      });
    });

    group('isInProgress', () {
      final inProgressOption = StatusOption(
        id: '1',
        name: 'In Progress',
        color: NotionColor.blue,
      );

      test('TaskStatusCheckbox - always returns false', () {
        const task = Task(
          id: '1',
          title: 'test',
          status: TaskStatus.checkbox(checkbox: false),
          dueDate: null,
          url: null,
        );
        expect(task.isInProgress(inProgressOption), false);
      });

      test('TaskStatusStatus - matches inProgressOption', () {
        var task = Task(
          id: '1',
          title: 'test',
          status: TaskStatus.status(
            group: StatusGroup(
              id: '1',
              name: StatusGroupType.inProgress.value,
              color: NotionColor.blue,
              optionIds: [inProgressOption.id],
            ),
            option: inProgressOption,
          ),
          dueDate: null,
          url: null,
        );
        expect(task.isInProgress(inProgressOption), true);
      });

      test('TaskStatusStatus - different option', () {
        var task = Task(
          id: '1',
          title: 'test',
          status: TaskStatus.status(
            group: StatusGroup(
              id: '1',
              name: StatusGroupType.todo.value,
              color: NotionColor.gray,
              optionIds: ['2'],
            ),
            option: StatusOption(
              id: '2',
              name: 'To-do',
              color: NotionColor.gray,
            ),
          ),
          dueDate: null,
          url: null,
        );
        expect(task.isInProgress(inProgressOption), false);
      });

      test('TaskStatusStatus - null option', () {
        const task = Task(
          id: '1',
          title: 'test',
          status: TaskStatus.status(
            group: null,
            option: null,
          ),
          dueDate: null,
          url: null,
        );
        expect(task.isInProgress(inProgressOption), false);
      });
    });

    group('priority', () {
      test('priorityを持つTaskを作成できる', () {
        final priority = SelectOption(
          id: 'high',
          name: '高',
          color: NotionColor.red,
        );

        final task = Task(
          id: '1',
          title: 'テストタスク',
          status: const TaskStatus.checkbox(checkbox: false),
          dueDate: null,
          url: null,
          priority: priority,
        );

        expect(task.priority, equals(priority));
        expect(task.priority?.id, equals('high'));
        expect(task.priority?.name, equals('高'));
        expect(task.priority?.color, equals(NotionColor.red));
      });

      test('priorityを省略できる', () {
        const task = Task(
          id: '1',
          title: 'テストタスク',
          status: TaskStatus.checkbox(checkbox: false),
          dueDate: null,
          url: null,
        );

        expect(task.priority, isNull);
      });

      test('Task.tempファクトリでpriorityを指定できる', () {
        final priority = SelectOption(
          id: 'medium',
          name: '中',
          color: NotionColor.yellow,
        );

        final task = Task.temp(
          title: 'テストタスク',
          priority: priority,
        );

        expect(task.isTemp, isTrue);
        expect(task.title, equals('テストタスク'));
        expect(task.priority, equals(priority));
      });

      test('JSON変換でpriorityが保持される', () {
        final priority = SelectOption(
          id: 'low',
          name: '低',
          color: NotionColor.blue,
        );

        final task = Task(
          id: '1',
          title: 'テストタスク',
          status: const TaskStatus.checkbox(checkbox: false),
          dueDate: null,
          url: null,
          priority: priority,
        );

        // JSONに変換してからStringに変換し、再度デコードすることでJSONの互換性を確認
        final jsonString = jsonEncode(task.toJson());
        expect(jsonString.contains('"priority"'), isTrue);

        // JSONからオブジェクトに復元
        final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
        final restoredTask = Task.fromJson(jsonMap);

        // 復元されたオブジェクトの値を検証
        expect(restoredTask.priority, isNotNull);
        expect(restoredTask.priority?.id, equals('low'));
        expect(restoredTask.priority?.name, equals('低'));
        expect(restoredTask.priority?.color, equals(NotionColor.blue));
      });
    });
  });
}
