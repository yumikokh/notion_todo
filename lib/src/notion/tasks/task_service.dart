import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../repository/notion_database_repository.dart';

part 'task_service.freezed.dart';
part 'task_service.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    // required bool isCompleted,
    // required DateTime? dueDate,
    // required String createdTime,
    // required String updatedTime,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.initial() => const Task(
        id: '',
        title: '',
        // isCompleted: false,
      );
}

class TaskService {
  final String _accessToken;

  late final NotionDatabaseRepository _notionDatabaseRepository;

  TaskService(this._accessToken) {
    _notionDatabaseRepository = NotionDatabaseRepository(_accessToken);
  }

  FutureOr<List<Task>> fetchTasks(String databaseId, FilterType type,
      String dateProperty, String statusProperty) async {
    final tasks = await _notionDatabaseRepository.fetchDatabasePages(
      databaseId,
      type,
      dateProperty,
      statusProperty,
    );
    print('databaseId: $databaseId');
    if (tasks == null) {
      return [];
    }
    return tasks
        .map<Task>((e) => Task(
              id: e['id'],
              title: e['properties']
                  .entries
                  .firstWhere((e) => e.value['type'] == 'title')
                  .value['title'][0]['plain_text'],
              // isCompleted: e['']
            ))
        .toList();
  }
}
