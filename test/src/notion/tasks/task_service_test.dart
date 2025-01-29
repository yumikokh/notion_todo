import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tanzaku_todo/src/notion/model/property.dart';
import 'package:tanzaku_todo/src/notion/model/task_database.dart';
import 'package:tanzaku_todo/src/notion/repository/notion_task_repository.dart';
import 'package:tanzaku_todo/src/notion/tasks/task_service.dart';

@GenerateNiceMocks([
  MockSpec<NotionTaskRepository>(),
])
import 'task_service_test.mocks.dart';

void main() {
  late TaskService service;
  late MockNotionTaskRepository mockRepository;
  late TaskDatabase taskDatabase;

  setUp(() {
    mockRepository = MockNotionTaskRepository();
    taskDatabase = TaskDatabase(
      id: 'test_id',
      name: 'test_database',
      title: TitleProperty(
        id: 'title_id',
        name: 'Title',
        title: 'test_title',
      ),
      status: CheckboxCompleteStatusProperty(
        id: 'status_id',
        name: 'Status',
        checked: false,
      ),
      date: DateProperty(
        id: 'date_id',
        name: 'Date',
        date: null,
      ),
    );
    service = TaskService(mockRepository, taskDatabase);
  });

  group('fetchTasks', () {
    final mockResponse = {
      'results': [
        {
          'id': 'task1',
          'properties': {
            'Title': {
              'type': 'title',
              'title': [
                {'plain_text': 'Test Task'}
              ]
            },
            'Status': {'checkbox': false},
            'Date': {
              'date': {'start': '2024-03-20', 'end': null}
            }
          },
          'url': 'https://notion.so/task1'
        }
      ],
      'has_more': false,
      'next_cursor': null
    };

    test('タスクの一覧を取得できる', () async {
      when(mockRepository.fetchPages(any, any,
              startCursor: anyNamed('startCursor')))
          .thenAnswer((_) async => mockResponse);

      final result = await service.fetchTasks(FilterType.all, false);

      expect(result.tasks.length, 1);
      expect(result.tasks[0].id, 'task1');
      expect(result.tasks[0].title, 'Test Task');
      expect(result.tasks[0].isCompleted, false);
      expect(result.tasks[0].dueDate?.start, '2024-03-20');
      expect(result.hasMore, false);
      expect(result.nextCursor, null);
    });
  });

  group('addTask', () {
    final mockResponse = {
      'id': 'new_task',
      'properties': {
        'Title': {
          'type': 'title',
          'title': [
            {'plain_text': 'New Task'}
          ]
        },
        'Status': {'checkbox': false},
        'Date': {
          'date': {'start': '2024-03-20', 'end': null}
        }
      },
      'url': 'https://notion.so/new_task'
    };

    test('タスクを追加できる', () async {
      when(mockRepository.addTask(any, any))
          .thenAnswer((_) async => mockResponse);

      final result = await service.addTask('New Task', '2024-03-20');

      expect(result.id, 'new_task');
      expect(result.title, 'New Task');
      expect(result.isCompleted, false);
      expect(result.dueDate?.start, '2024-03-20');
    });
  });

  group('updateTask', () {
    final mockResponse = {
      'id': 'task1',
      'properties': {
        'Title': {
          'type': 'title',
          'title': [
            {'plain_text': 'Updated Task'}
          ]
        },
        'Status': {'checkbox': false},
        'Date': {
          'date': {'start': '2024-03-21', 'end': null}
        }
      },
      'url': 'https://notion.so/task1'
    };

    test('タスクを更新できる', () async {
      when(mockRepository.updateTask(any, any, any))
          .thenAnswer((_) async => mockResponse);

      final result =
          await service.updateTask('task1', 'Updated Task', '2024-03-21');

      expect(result.id, 'task1');
      expect(result.title, 'Updated Task');
      expect(result.isCompleted, false);
      expect(result.dueDate?.start, '2024-03-21');
    });
  });

  group('updateStatus', () {
    final mockResponse = {
      'id': 'task1',
      'properties': {
        'Title': {
          'type': 'title',
          'title': [
            {'plain_text': 'Test Task'}
          ]
        },
        'Status': {'checkbox': true},
        'Date': {
          'date': {'start': '2024-03-20', 'end': null}
        }
      },
      'url': 'https://notion.so/task1'
    };

    test('タスクのステータスを更新できる', () async {
      when(mockRepository.updateStatus(any, any))
          .thenAnswer((_) async => mockResponse);

      final result = await service.updateStatus('task1', true);

      expect(result.id, 'task1');
      expect(result.title, 'Test Task');
      expect(result.isCompleted, true);
      expect(result.dueDate?.start, '2024-03-20');
    });
  });

  group('deleteTask', () {
    final mockResponse = {
      'id': 'task1',
      'properties': {
        'Title': {
          'type': 'title',
          'title': [
            {'plain_text': 'Test Task'}
          ]
        },
        'Status': {'checkbox': false},
        'Date': {
          'date': {'start': '2024-03-20', 'end': null}
        }
      },
      'url': 'https://notion.so/task1'
    };

    test('タスクを削除できる', () async {
      when(mockRepository.deleteTask(any))
          .thenAnswer((_) async => mockResponse);

      final result = await service.deleteTask('task1');

      expect(result?.id, 'task1');
      expect(result?.title, 'Test Task');
      expect(result?.isCompleted, false);
      expect(result?.dueDate?.start, '2024-03-20');
    });
  });
}
