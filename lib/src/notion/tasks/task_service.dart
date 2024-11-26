import 'dart:async';

import '../model/property.dart';
import '../model/task.dart';
import '../model/task_database.dart';
import '../repository/notion_task_repository.dart';

class TaskService {
  final NotionTaskRepository notionTaskRepository;
  // TODO: DATABASE情報も所有させる

  TaskService(this.notionTaskRepository);

  FutureOr<List<Task>> fetchTasks(
    TaskDatabase db,
    FilterType filterType,
  ) async {
    try {
      final results = await notionTaskRepository.fetchPages(filterType);

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
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Task> addTask(TaskDatabase db, String title, String? dueDate) async {
    final data = await notionTaskRepository.addTask(title, dueDate);
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

  Future<Task> updateTask(
      TaskDatabase db, String taskId, String title, String? dueDate) async {
    final data = await notionTaskRepository.updateTask(taskId, title, dueDate);
    if (data == null || data['id'] == null) {
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
      TaskDatabase db, String taskId, bool isCompleted) async {
    final data = await notionTaskRepository.updateStatus(taskId, isCompleted);
    if (data == null || data.isEmpty) {
      return Task.initial();
    }
    // TODO: すでに存在しないIDだった場合のエラーハンドリング
    return Task(
      id: data['id'],
      title: _title(data),
      isCompleted: _isTaskCompleted(data, db.status),
      dueDate: _date(data, db.date.name),
    );
  }

  Future<Task?> deleteTask(String taskId, TaskStatusProperty status) async {
    final data = await notionTaskRepository.deleteTask(taskId);
    if (data == null || data.isEmpty) {
      return null;
    }
    return Task(
      id: data['id'],
      title: _title(data),
      isCompleted: _isTaskCompleted(data, status),
      dueDate: _date(data, status.name),
    );
  }

  Future<Task?> undoDeleteTask(String taskId, TaskStatusProperty status) async {
    final data = await notionTaskRepository.revertTask(taskId);
    if (data == null || data.isEmpty) {
      return null;
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

  TaskDate? _date(Map<String, dynamic> task, String dateProperty) {
    final datePropertyData = task['properties'][dateProperty];
    if (datePropertyData == null) {
      return null;
    }
    final date = datePropertyData['date'];
    if (date == null) {
      return null;
    }
    return TaskDate(
      start: date['start'],
      end: date['end'],
    );
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
