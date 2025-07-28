import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/utils/notion_converter.dart';
import '../../settings/task_database/task_database_viewmodel.dart';
import '../../widget/widget_service.dart';
import '../common/filter_type.dart';
import '../model/task.dart';
import '../model/task_database.dart';
import '../oauth/notion_oauth_viewmodel.dart';
import '../api/notion_task_api.dart';
import '../api/notion_database_api.dart';

part 'task_repository.g.dart';

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
Future<TaskRepository?> taskRepository(Ref ref) async {
  final taskDatabase = await ref.watch(taskDatabaseViewModelProvider.future);
  final accessToken =
      ref.watch(notionOAuthViewModelProvider).valueOrNull?.accessToken;
  WidgetService.sendDatabaseSettings(accessToken, taskDatabase);

  if (accessToken == null || taskDatabase == null) {
    return null;
  }
  final notionTaskApi = NotionTaskApi(accessToken, taskDatabase);
  final notionDatabaseApi = NotionDatabaseApi(accessToken);

  return TaskRepository(notionTaskApi, notionDatabaseApi, taskDatabase);
}

class TaskRepository {
  final NotionTaskApi notionTaskApi;
  final NotionDatabaseApi notionDatabaseApi;
  final TaskDatabase taskDatabase;

  TaskRepository(this.notionTaskApi, this.notionDatabaseApi, this.taskDatabase);

  Future<bool> loadShowCompleted() async {
    return await notionTaskApi.loadShowCompleted();
  }

  Future<void> saveShowCompleted(bool value) async {
    await notionTaskApi.saveShowCompleted(value);
  }

  Future<TaskResult> fetchTasks(FilterType filterType, bool hasCompleted,
      {String? startCursor}) async {
    final data = await notionTaskApi.fetchPages(filterType, hasCompleted,
        startCursor: startCursor);

    final tasks = (data['results'] as List<dynamic>)
        .map((dynamic page) =>
            NotionConverter.createTaskFromData(page, taskDatabase))
        .toList();

    return TaskResult(
      tasks: tasks,
      hasMore: data['has_more'] ?? false,
      nextCursor: data['next_cursor'],
    );
  }

  Future<Task> addTask(Task task) async {
    final data = await notionTaskApi.addTask(task);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      throw Exception('Failed to add task');
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task> updateTask(Task task) async {
    final data = await notionTaskApi.updateTask(task);
    if (data == null || data['id'] == null || data['object'] == 'error') {
      throw Exception('Failed to update task');
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task> updateCompleteStatus(String taskId, bool isCompleted) async {
    final data = await notionTaskApi.updateCompleteStatus(taskId, isCompleted);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      throw Exception('Failed to update task');
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task> updateInProgressStatus(String taskId, bool isInProgress) async {
    final data =
        await notionTaskApi.updateInProgressStatus(taskId, isInProgress);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      throw Exception('Failed to update task');
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task?> deleteTask(String taskId) async {
    final data = await notionTaskApi.deleteTask(taskId);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      return null;
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task?> undoDeleteTask(String taskId) async {
    final data = await notionTaskApi.revertTask(taskId);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      return null;
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

}
