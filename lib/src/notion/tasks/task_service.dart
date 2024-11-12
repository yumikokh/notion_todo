import 'dart:async';

import '../model/property.dart';
import '../model/task.dart';
import '../model/task_database.dart';
import '../repository/notion_database_repository.dart';

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
        type, db.id, db.date, db.status);
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

  Future<Task> updateStatus(
      String taskId, TaskStatusProperty status, bool isCompleted) async {
    final data = await _notionDatabaseRepository.updateStatus(
        taskId, status, isCompleted);
    if (data == null) {
      return Task.initial();
    }
    return Task(
      id: data['id'],
      title: title(data),
      isCompleted: isTaskCompleted(data, status),
      dueDate: date(data, status.name),
    );
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
