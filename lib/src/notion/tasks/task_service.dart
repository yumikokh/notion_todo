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
    final results = await _notionDatabaseRepository.fetchPages(
        type, db.id, db.date, db.status);
    if (results == null) {
      return [];
    }
    return results
        .map<Task>((data) => Task(
            id: data['id'],
            title: _title(data),
            isCompleted: _isTaskCompleted(data, db.status),
            dueDate: _date(data, db.date.name)))
        .toList();
  }

  Future<Task> addTask(TaskDatabase db, String title, DateTime? dueDate) async {
    final data = await _notionDatabaseRepository.addTask(db, title, dueDate);
    if (data == null || data.isEmpty) {
      return Task.initial();
    }
    return Task(
      id: data['id'],
      title: title,
      isCompleted: _isTaskCompleted(data, db.status),
      dueDate: _date(data, db.date.name),
    );
  }

  Future<Task> updateStatus(
      String taskId, TaskStatusProperty status, bool isCompleted) async {
    final data = await _notionDatabaseRepository.updateStatus(
        taskId, status, isCompleted);
    if (data == null || data.isEmpty) {
      return Task.initial();
    }
    // TODO: すでに存在しないIDだった場合のエラーハンドリング
    return Task(
      id: data['id'],
      title: _title(data),
      isCompleted: _isTaskCompleted(data, status),
      dueDate: _date(data, status.name),
    );
  }

  Future<void> deleteTask(String taskId) async {
    await _notionDatabaseRepository.undoDeleteTask(taskId);
  }

  Future<Task> undoDeleteTask(String taskId, TaskStatusProperty status) async {
    final data = await _notionDatabaseRepository.revertTask(taskId);
    if (data == null || data.isEmpty) {
      return Task.initial();
    }
    return Task(
      id: data['id'],
      title: _title(data),
      isCompleted: _isTaskCompleted(data, status),
      dueDate: _date(data, status.name),
    );
  }

  String _title(Map<String, dynamic> task) {
    final titleProperty = task['properties']
        .entries
        .firstWhere((e) => e.value['type'] == 'title')
        .value['title'];
    return titleProperty.length > 0 ? titleProperty[0]['plain_text'] : '';
  }

  DateTime? _date(Map<String, dynamic> task, String dateProperty) {
    return task['properties'][dateProperty]['date'] != null
        ? DateTime.parse(
            task['properties'][dateProperty]['date']['start']) // TODO: end
        : null;
  }

  bool _isTaskCompleted(Map<String, dynamic> task, TaskStatusProperty status) {
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