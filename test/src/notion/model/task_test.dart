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
          status: TaskStatus.checkbox(checked: true),
          dueDate: null,
          url: null,
        );
        expect(task.isCompleted, true);
      });

      test('TaskStatusCheckbox - checked: false', () {
        const task = Task(
          id: '1',
          title: 'test',
          status: TaskStatus.checkbox(checked: false),
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
              color: 'gray',
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
              color: 'gray',
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
        color: 'blue',
      );

      test('TaskStatusCheckbox - always returns false', () {
        const task = Task(
          id: '1',
          title: 'test',
          status: TaskStatus.checkbox(checked: false),
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
              color: 'blue',
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
              color: 'gray',
              optionIds: ['2'],
            ),
            option: StatusOption(
              id: '2',
              name: 'To-do',
              color: 'gray',
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
  });
}
