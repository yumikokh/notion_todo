import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notion_todo/src/notion/task_database/task_database_service.dart';

import '../entity/property.dart';
import '../repository/notion_database_repository.dart';

part 'task_service.freezed.dart';
part 'task_service.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required bool isCompleted,
    required DateTime? dueDate,
    // required String createdTime,
    // required String updatedTime,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.initial() =>
      const Task(id: '', title: '', isCompleted: false, dueDate: null);
}

class TaskService {
  final String _accessToken;

  late final NotionDatabaseRepository _notionDatabaseRepository;

  TaskService(this._accessToken) {
    _notionDatabaseRepository = NotionDatabaseRepository(_accessToken);
  }

  FutureOr<List<Task>> fetchTasks(
    TaskDatabase db,
    FilterType type,
  ) async {
    final results = await _notionDatabaseRepository.fetchDatabasePages(
        db.id, type, db.date, db.status);
    if (results == null) {
      return [];
    }
    return results
        .map<Task>((data) => Task(
            id: data['id'],
            title: title(data),
            isCompleted: isTaskCompleted(data, db.status),
            dueDate: date(data, db.date.name)))
        .toList();
  }

  String title(Map<String, dynamic> task) {
    return task['properties']
        .entries
        .firstWhere((e) => e.value['type'] == 'title')
        .value['title'][0]['plain_text'];
  }

  DateTime? date(Map<String, dynamic> task, String dateProperty) {
    return task['properties'][dateProperty]['date'] != null
        ? DateTime.parse(
            task['properties'][dateProperty]['date']['start']) // TODO: end
        : null;
  }

  bool isTaskCompleted(Map<String, dynamic> task, TaskStatusProperty status) {
    if (status.type == PropertyType.checkbox) {
      return task['properties'][status.name]['checkbox'];
    }
    if (status.type == PropertyType.status &&
        status is StatusTaskStatusProperty) {
      final completeGroupIds = status.status.groups
          .firstWhere(
            (group) => group.name == 'Complete',
          )
          .option_ids;
      return completeGroupIds.contains(
        task['properties'][status.name]['status']['id'],
      );
    }
    return false;
  }
}
