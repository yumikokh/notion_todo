import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/utils/notion_converter.dart';
import '../common/filter_type.dart';
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
Future<TaskService?> taskService(Ref ref, TaskDatabase? taskDatabase) async {
  final repository = ref.watch(notionTaskRepositoryProvider(taskDatabase));
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
    final data = await notionTaskRepository.fetchPages(filterType, hasCompleted,
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
    final data = await notionTaskRepository.addTask(task);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      throw Exception('Failed to add task');
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task> updateTask(Task task) async {
    final data = await notionTaskRepository.updateTask(task);
    if (data == null || data['id'] == null || data['object'] == 'error') {
      throw Exception('Failed to update task');
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task> updateCompleteStatus(String taskId, bool isCompleted) async {
    final data =
        await notionTaskRepository.updateCompleteStatus(taskId, isCompleted);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      throw Exception('Failed to update task');
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task> updateInProgressStatus(String taskId, bool isInProgress) async {
    final data =
        await notionTaskRepository.updateInProgressStatus(taskId, isInProgress);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      throw Exception('Failed to update task');
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task?> deleteTask(String taskId) async {
    final data = await notionTaskRepository.deleteTask(taskId);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      return null;
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task?> undoDeleteTask(String taskId) async {
    final data = await notionTaskRepository.revertTask(taskId);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      return null;
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }
}
