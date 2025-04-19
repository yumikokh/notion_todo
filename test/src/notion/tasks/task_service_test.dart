import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tanzaku_todo/src/notion/model/property.dart';
import 'package:tanzaku_todo/src/notion/model/task.dart';
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
      status: StatusCompleteStatusProperty(
        id: 'status_id',
        name: 'Status',
        status: (
          groups: [
            StatusGroup(
              id: 'todo_group',
              name: StatusGroupType.todo.value,
              color: NotionColor.gray,
              optionIds: ['todo_option'],
            ),
            StatusGroup(
              id: 'in_progress_group',
              name: StatusGroupType.inProgress.value,
              color: NotionColor.blue,
              optionIds: ['in_progress_option'],
            ),
            StatusGroup(
              id: 'complete_group',
              name: StatusGroupType.complete.value,
              color: NotionColor.green,
              optionIds: ['complete_option'],
            ),
          ],
          options: [
            StatusOption(
              id: 'todo_option',
              name: 'To-do',
              color: NotionColor.gray,
            ),
            StatusOption(
              id: 'in_progress_option',
              name: 'In Progress',
              color: NotionColor.blue,
            ),
            StatusOption(
              id: 'complete_option',
              name: 'Complete',
              color: NotionColor.green,
            ),
          ],
        ),
        todoOption: StatusOption(
          id: 'todo_option',
          name: 'To-do',
          color: NotionColor.gray,
        ),
        inProgressOption: StatusOption(
          id: 'in_progress_option',
          name: 'In Progress',
          color: NotionColor.blue,
        ),
        completeOption: StatusOption(
          id: 'complete_option',
          name: 'Complete',
          color: NotionColor.green,
        ),
      ),
      date: DateProperty(
        id: 'date_id',
        name: 'Date',
      ),
      priority: SelectProperty(
        id: 'priority_id',
        name: 'Priority',
        select: (
          options: [
            SelectOption(
              id: 'high_priority',
              name: 'High',
              color: NotionColor.red,
            ),
            SelectOption(
              id: 'medium_priority',
              name: 'Medium',
              color: NotionColor.yellow,
            ),
            SelectOption(
              id: 'low_priority',
              name: 'Low',
              color: NotionColor.blue,
            ),
          ],
        ),
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
              'id': 'title',
              'type': 'title',
              'title': [
                {'plain_text': 'Test Task'}
              ]
            },
            'Status': {
              'id': 'status_id',
              'type': 'checkbox',
              'checkbox': false
            },
            'Date': {
              'id': 'date_id',
              'type': 'date',
              'date': {'start': '2024-03-20', 'end': null}
            },
            'Priority': {
              'id': 'priority_id',
              'type': 'select',
              'select': {'id': 'high_priority', 'name': 'High', 'color': 'red'}
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
      expect(result.tasks[0].dueDate?.start.submitFormat, '2024-03-20');
      expect(result.tasks[0].priority?.name, 'High');
      expect(result.hasMore, false);
      expect(result.nextCursor, null);
    });

    test('今日のタスクと進行中のタスクを取得できる', () async {
      final mockResponseWithInProgress = {
        'results': [
          {
            'id': 'task1',
            'properties': {
              'Title': {
                'id': 'title',
                'type': 'title',
                'title': [
                  {'plain_text': 'Today Task'}
                ]
              },
              'Status': {
                'id': 'status_id',
                'type': 'status',
                'status': {
                  'id': 'todo_option',
                  'name': 'To-do',
                  'color': 'gray',
                }
              },
              'Date': {
                'id': 'date_id',
                'type': 'date',
                'date': {'start': DateTime.now().toIso8601String(), 'end': null}
              },
              'Priority': {
                'id': 'priority_id',
                'type': 'select',
                'select': {
                  'id': 'medium_priority',
                  'name': 'Medium',
                  'color': 'yellow'
                }
              }
            },
            'url': 'https://notion.so/task1'
          },
          {
            'id': 'task2',
            'properties': {
              'Title': {
                'id': 'title',
                'type': 'title',
                'title': [
                  {'plain_text': 'In Progress Task'}
                ]
              },
              'Status': {
                'id': 'status_id',
                'type': 'status',
                'status': {
                  'id': 'in_progress_option',
                  'name': 'In Progress',
                  'color': 'blue',
                }
              },
              'Date': {
                'id': 'date_id',
                'type': 'date',
                'date': {'start': '2024-04-01', 'end': null}
              },
              'Priority': {
                'id': 'priority_id',
                'type': 'select',
                'select': {'id': 'low_priority', 'name': 'Low', 'color': 'blue'}
              }
            },
            'url': 'https://notion.so/task2'
          }
        ],
        'has_more': false,
        'next_cursor': null
      };

      when(mockRepository.fetchPages(FilterType.today, false,
              startCursor: anyNamed('startCursor')))
          .thenAnswer((_) async => mockResponseWithInProgress);

      final result = await service.fetchTasks(FilterType.today, false);

      expect(result.tasks.length, 2);

      // 今日のタスク
      expect(result.tasks[0].id, 'task1');
      expect(result.tasks[0].title, 'Today Task');
      expect(
        result.tasks[0].status,
        isA<TaskStatusStatus>()
            .having((s) => s.option?.name, 'option.name', 'To-do'),
      );
      expect(result.tasks[0].priority?.name, 'Medium');

      // 進行中のタスク
      expect(result.tasks[1].id, 'task2');
      expect(result.tasks[1].title, 'In Progress Task');
      expect(
        result.tasks[1].status,
        isA<TaskStatusStatus>()
            .having((s) => s.option?.name, 'option.name', 'In Progress'),
      );
      expect(result.tasks[1].dueDate?.start.submitFormat, '2024-04-01');
      expect(result.tasks[1].priority?.name, 'Low');

      expect(result.hasMore, false);
      expect(result.nextCursor, null);
    });
  });

  group('addTask', () {
    final mockResponse = {
      'id': 'new_task',
      'properties': {
        'Title': {
          'id': 'title',
          'type': 'title',
          'title': [
            {'plain_text': 'New Task'}
          ]
        },
        'Status': {'id': 'status_id', 'type': 'checkbox', 'checkbox': false},
        'Date': {
          'id': 'date_id',
          'type': 'date',
          'date': {'start': '2024-03-20', 'end': null}
        },
        'Priority': {
          'id': 'priority_id',
          'type': 'select',
          'select': {'id': 'high_priority', 'name': 'High', 'color': 'red'}
        }
      },
      'url': 'https://notion.so/new_task'
    };

    test('タスクを追加できる', () async {
      when(mockRepository.addTask(any)).thenAnswer((_) async => mockResponse);

      final newTask = Task.temp(
        title: 'New Task',
        dueDate: TaskDate(
          start: NotionDateTime(
            datetime: DateTime.parse('2024-03-20'),
            isAllDay: true,
          ),
        ),
        priority: SelectOption(
          id: 'high_priority',
          name: 'High',
          color: NotionColor.red,
        ),
      );

      final result = await service.addTask(newTask);

      expect(result.id, 'new_task');
      expect(result.title, 'New Task');
      expect(result.isCompleted, false);
      expect(result.dueDate?.start.submitFormat, '2024-03-20');
      expect(result.priority?.name, 'High');
    });
  });

  group('updateTask', () {
    final mockResponse = {
      'id': 'task1',
      'properties': {
        'Title': {
          'id': 'title',
          'type': 'title',
          'title': [
            {'plain_text': 'Updated Task'}
          ]
        },
        'Status': {'id': 'status_id', 'type': 'checkbox', 'checkbox': false},
        'Date': {
          'id': 'date_id',
          'type': 'date',
          'date': {'start': '2024-03-21', 'end': null}
        },
        'Priority': {
          'id': 'priority_id',
          'type': 'select',
          'select': {
            'id': 'medium_priority',
            'name': 'Medium',
            'color': 'yellow'
          }
        }
      },
      'url': 'https://notion.so/task1'
    };

    test('タスクを更新できる', () async {
      when(mockRepository.updateTask(any))
          .thenAnswer((_) async => mockResponse);

      final taskToUpdate = Task.temp(
        title: 'Updated Task',
        dueDate: TaskDate(
          start: NotionDateTime(
            datetime: DateTime.parse('2024-03-21'),
            isAllDay: true,
          ),
        ),
        priority: SelectOption(
          id: 'medium_priority',
          name: 'Medium',
          color: NotionColor.yellow,
        ),
      );

      final result = await service.updateTask(taskToUpdate);

      expect(result.id, 'task1');
      expect(result.title, 'Updated Task');
      expect(result.isCompleted, false);
      expect(result.dueDate?.start.submitFormat, '2024-03-21');
      expect(result.priority?.name, 'Medium');
    });
  });

  group('updateStatus', () {
    final mockResponse = {
      'id': 'task1',
      'properties': {
        'Title': {
          'id': 'title',
          'type': 'title',
          'title': [
            {'plain_text': 'Test Task'}
          ]
        },
        'Status': {
          'id': 'status_id',
          'type': 'status',
          'status': {
            'id': 'complete_option',
            'name': 'Complete',
            'color': 'green',
          }
        },
        'Date': {
          'id': 'date_id',
          'type': 'date',
          'date': {'start': '2024-03-20', 'end': null}
        },
        'Priority': {
          'id': 'priority_id',
          'type': 'select',
          'select': {'id': 'high_priority', 'name': 'High', 'color': 'red'}
        }
      },
      'url': 'https://notion.so/task1'
    };

    test('タスクのステータスを更新できる', () async {
      when(mockRepository.updateCompleteStatus(any, any))
          .thenAnswer((_) async => mockResponse);

      final result = await service.updateCompleteStatus('task1', true);

      expect(result.id, 'task1');
      expect(result.title, 'Test Task');
      expect(result.isCompleted, true);
      expect(result.dueDate?.start.submitFormat, '2024-03-20');
      expect(result.priority?.name, 'High');
    });
  });

  group('deleteTask', () {
    final mockResponse = {
      'id': 'task1',
      'properties': {
        'Title': {
          'id': 'title',
          'type': 'title',
          'title': [
            {'plain_text': 'Test Task'}
          ]
        },
        'Status': {'id': 'status_id', 'type': 'checkbox', 'checkbox': false},
        'Date': {
          'id': 'date_id',
          'type': 'date',
          'date': {'start': '2024-03-20', 'end': null}
        },
        'Priority': {
          'id': 'priority_id',
          'type': 'select',
          'select': {'id': 'low_priority', 'name': 'Low', 'color': 'blue'}
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
      expect(result?.dueDate?.start.submitFormat, '2024-03-20');
      expect(result?.priority?.name, 'Low');
    });
  });

  group('updateInProgressStatus', () {
    test('タスクのステータスを進行中に更新できる', () async {
      final mockResponse = {
        'id': 'task1',
        'properties': {
          'Title': {
            'id': 'title',
            'type': 'title',
            'title': [
              {'plain_text': 'Test Task'}
            ]
          },
          'Status': {
            'id': 'status_id',
            'type': 'status',
            'status': {
              'id': 'in_progress_option',
              'name': 'In Progress',
              'color': 'blue',
            }
          },
          'Priority': {
            'id': 'priority_id',
            'type': 'select',
            'select': {
              'id': 'medium_priority',
              'name': 'Medium',
              'color': 'yellow'
            }
          }
        }
      };

      when(mockRepository.updateInProgressStatus(any, any))
          .thenAnswer((_) async => mockResponse);

      final updatedTask = await service.updateInProgressStatus('task1', true);

      verify(mockRepository.updateInProgressStatus('task1', true)).called(1);
      expect(updatedTask.id, 'task1');
      expect(updatedTask.title, 'Test Task');
      expect(
        updatedTask.status,
        isA<TaskStatusStatus>()
            .having((s) => s.option?.id, 'option.id', 'in_progress_option')
            .having((s) => s.option?.name, 'option.name', 'In Progress')
            .having((s) => s.option?.color, 'option.color', NotionColor.blue),
      );
      expect(updatedTask.priority?.name, 'Medium');
    });

    test('タスクのステータスを進行中から未着手に更新できる', () async {
      const taskId = 'task_id';
      const taskTitle = 'Test Task';
      when(mockRepository.updateInProgressStatus(taskId, false))
          .thenAnswer((_) async => {
                'id': taskId,
                'properties': {
                  'Title': {
                    'id': 'title',
                    'type': 'title',
                    'title': [
                      {'plain_text': taskTitle}
                    ]
                  },
                  'Status': {
                    'id': 'status_id',
                    'type': 'status',
                    'status': {
                      'id': 'todo_option',
                      'name': 'To-do',
                      'color': 'gray',
                    }
                  },
                  'Priority': {
                    'id': 'priority_id',
                    'type': 'select',
                    'select': {
                      'id': 'low_priority',
                      'name': 'Low',
                      'color': 'blue'
                    }
                  }
                }
              });

      final updatedTask = await service.updateInProgressStatus(taskId, false);

      verify(mockRepository.updateInProgressStatus(taskId, false)).called(1);
      expect(updatedTask.id, taskId);
      expect(updatedTask.title, taskTitle);
      expect(
        updatedTask.status,
        isA<TaskStatusStatus>()
            .having((s) => s.option?.id, 'option.id', 'todo_option')
            .having((s) => s.option?.name, 'option.name', 'To-do')
            .having((s) => s.option?.color, 'option.color', NotionColor.gray),
      );
      expect(updatedTask.priority?.name, 'Low');
    });

    test('API呼び出しに失敗した場合に例外がスローされる', () async {
      const taskId = 'task_id';
      when(mockRepository.updateInProgressStatus(taskId, true))
          .thenAnswer((_) async => null);

      expect(
        () => service.updateInProgressStatus(taskId, true),
        throwsA(isA<Exception>()),
      );
      verify(mockRepository.updateInProgressStatus(taskId, true)).called(1);
    });
  });
}
