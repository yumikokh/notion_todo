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

  Future<bool> loadShowCompleted() async {
    return await notionTaskRepository.loadShowCompleted();
  }

  Future<void> saveShowCompleted(bool value) async {
    await notionTaskRepository.saveShowCompleted(value);
  }

  Future<TaskResult> fetchTasks(FilterType filterType, bool hasCompleted,
      {String? startCursor}) async {
    try {
      final data = await notionTaskRepository
          .fetchPages(filterType, hasCompleted, startCursor: startCursor);

      final tasks = (data['results'] as List)
          .map((page) => Task(
                id: page['id'],
                title: _title(page),
                status: _status(page),
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
      throw Exception('Failed to add task');
    }
    return Task(
      id: data['id'],
      title: title,
      status: _status(data),
      dueDate: _date(data),
      url: data['url'],
    );
  }

  Future<Task> updateTask(String taskId, String title, String? dueDate) async {
    final data = await notionTaskRepository.updateTask(taskId, title, dueDate);
    if (data == null || data['id'] == null) {
      throw Exception('Failed to update task');
    }
    return Task(
      id: data['id'],
      title: title,
      status: _status(data),
      dueDate: _date(data),
      url: data['url'],
    );
  }

  Future<Task> updateCompleteStatus(String taskId, bool isCompleted) async {
    final data =
        await notionTaskRepository.updateCompleteStatus(taskId, isCompleted);
    if (data == null || data.isEmpty) {
      throw Exception('Failed to update task');
    }
    // TODO: すでに存在しないIDだった場合のエラーハンドリング
    return Task(
      id: data['id'],
      title: _title(data),
      status: _status(data),
      dueDate: _date(data),
      url: data['url'],
    );
  }

  Future<Task> updateInProgressStatus(String taskId, bool isInProgress) async {
    final data =
        await notionTaskRepository.updateInProgressStatus(taskId, isInProgress);
    if (data == null || data.isEmpty) {
      throw Exception('Failed to update task');
    }
    return Task(
      id: data['id'],
      title: _title(data),
      status: _status(data),
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
      status: _status(data),
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
      status: _status(data),
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

  TaskStatus _status(Map<String, dynamic> data) {
    final property = taskDatabase.status;
    switch (property) {
      case CheckboxCompleteStatusProperty():
        return TaskStatus.checkbox(
            checked: data['properties'][property.name]['checkbox']);
      case StatusCompleteStatusProperty(status: var status):
        // statusが未指定の場合がある
        if (data['properties'][property.name]['status'] == null) {
          return const TaskStatus.status(group: null, option: null);
        }

        final optionId = data['properties'][property.name]['status']['id'];
        final group = status.groups.firstWhere(
          (group) => group.optionIds.contains(optionId),
        );
        final option = status.options.firstWhere(
          (option) => option.id == optionId,
        );

        return TaskStatus.status(group: group, option: option);
    }
  }
}
