import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../settings/task_database/task_database_viewmodel.dart';
import '../model/property.dart';
import '../model/task.dart';
import '../model/task_database.dart';
import '../repository/notion_task_repository.dart';

part 'task_service.g.dart';

class TaskResult {
  final List<Task> tasks;
  final bool hasMore;
  final String? nextCursor;

  TaskResult({
    required this.tasks,
    required this.hasMore,
    this.nextCursor,
  });
}

@riverpod
Future<TaskService?> taskService(Ref ref) async {
  final repository = ref.watch(notionTaskRepositoryProvider);
  final taskDatabase = ref.watch(taskDatabaseViewModelProvider).valueOrNull;
  if (repository == null || taskDatabase == null) {
    return null;
  }
  return TaskService(repository, taskDatabase);
}

class TaskService {
  final NotionTaskRepository notionTaskRepository;
  final TaskDatabase taskDatabase;

  TaskService(this.notionTaskRepository, this.taskDatabase);

  Future<TaskResult> fetchTasks(FilterType filterType, bool hasCompleted,
      {String? startCursor}) async {
    try {
      final data = await notionTaskRepository
          .fetchPages(filterType, hasCompleted, startCursor: startCursor);

      final tasks = (data['results'] as List)
          .map((page) => Task(
                id: page['id'],
                title: _title(page),
                isCompleted: _isTaskCompleted(page),
                dueDate: _date(page),
                url: page['url'],
              ))
          .toList();

      return TaskResult(
        tasks: tasks,
        hasMore: data['has_more'] ?? false,
        nextCursor: data['next_cursor'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Task> addTask(String title, String? dueDate) async {
    final data = await notionTaskRepository.addTask(title, dueDate);
    if (data == null || data.isEmpty) {
      return Task.initial();
    }
    return Task(
      id: data['id'],
      title: title,
      isCompleted: _isTaskCompleted(data),
      dueDate: _date(data),
      url: data['url'],
    );
  }

  Future<Task> updateTask(String taskId, String title, String? dueDate) async {
    final data = await notionTaskRepository.updateTask(taskId, title, dueDate);
    if (data == null || data['id'] == null) {
      return Task.initial();
    }
    return Task(
      id: data['id'],
      title: title,
      isCompleted: _isTaskCompleted(data),
      dueDate: _date(data),
      url: data['url'],
    );
  }

  Future<Task> updateStatus(String taskId, bool isCompleted) async {
    final data = await notionTaskRepository.updateStatus(taskId, isCompleted);
    if (data == null || data.isEmpty) {
      return Task.initial();
    }
    // TODO: すでに存在しないIDだった場合のエラーハンドリング
    return Task(
      id: data['id'],
      title: _title(data),
      isCompleted: _isTaskCompleted(data),
      dueDate: _date(data),
      url: data['url'],
    );
  }

  Future<Task?> deleteTask(String taskId) async {
    final data = await notionTaskRepository.deleteTask(taskId);
    if (data == null || data.isEmpty) {
      return null;
    }
    return Task(
      id: data['id'],
      title: _title(data),
      isCompleted: _isTaskCompleted(data),
      dueDate: _date(data),
      url: data['url'],
    );
  }

  Future<Task?> undoDeleteTask(String taskId) async {
    final data = await notionTaskRepository.revertTask(taskId);
    if (data == null || data.isEmpty) {
      return null;
    }
    return Task(
      id: data['id'],
      title: _title(data),
      isCompleted: _isTaskCompleted(data),
      dueDate: _date(data),
      url: data['url'],
    );
  }

  String _title(Map<String, dynamic> data) {
    final titleProperty = data['properties']
        .entries
        .firstWhere((e) => e.value['type'] == 'title')
        .value['title'];
    return titleProperty?.length > 0 ? titleProperty[0]['plain_text'] : '';
  }

  TaskDate? _date(Map<String, dynamic> data) {
    final dateProperty = taskDatabase.date.name;
    final datePropertyData = data['properties'][dateProperty];
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

  bool _isTaskCompleted(Map<String, dynamic> data) {
    final property = taskDatabase.status;
    switch (property) {
      case CheckboxCompleteStatusProperty():
        return data['properties'][property.name]['checkbox'];
      case StatusCompleteStatusProperty(status: var status):
        final completeGroupIds = status.groups
            .where(
              (group) => group.name == 'Complete',
            )
            .firstOrNull
            ?.optionIds;
        if (completeGroupIds == null) {
          throw Exception('Complete group not found');
        }
        // statusが未指定の場合がある
        if (data['properties'][property.name]['status'] == null) {
          return false;
        }
        return completeGroupIds.contains(
          data['properties'][property.name]['status']['id'],
        );
    }
  }
}
