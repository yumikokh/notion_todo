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
    final data = await notionTaskRepository.fetchPages(filterType, hasCompleted,
        startCursor: startCursor);

    final tasks = (data['results'] as List<dynamic>)
        .map((dynamic page) => Task(
              id: page['id'],
              title: _title(page),
              status: _status(page),
              dueDate: _date(page),
              url: page['url'],
              priority: _priority(page),
            ))
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
    return Task(
      id: data['id'],
      title: _title(data),
      status: _status(data),
      dueDate: _date(data),
      url: data['url'],
      priority: _priority(data),
    );
  }

  Future<Task> updateTask(Task task) async {
    final data = await notionTaskRepository.updateTask(task);
    if (data == null || data['id'] == null || data['object'] == 'error') {
      throw Exception('Failed to update task');
    }
    return Task(
      id: data['id'],
      title: _title(data),
      status: _status(data),
      dueDate: _date(data),
      url: data['url'],
      priority: _priority(data),
    );
  }

  Future<Task> updateCompleteStatus(String taskId, bool isCompleted) async {
    final data =
        await notionTaskRepository.updateCompleteStatus(taskId, isCompleted);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      throw Exception('Failed to update task');
    }
    return Task(
      id: data['id'],
      title: _title(data),
      status: _status(data),
      dueDate: _date(data),
      url: data['url'],
      priority: _priority(data),
    );
  }

  Future<Task> updateInProgressStatus(String taskId, bool isInProgress) async {
    final data =
        await notionTaskRepository.updateInProgressStatus(taskId, isInProgress);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      throw Exception('Failed to update task');
    }
    return Task(
      id: data['id'],
      title: _title(data),
      status: _status(data),
      dueDate: _date(data),
      url: data['url'],
      priority: _priority(data),
    );
  }

  Future<Task?> deleteTask(String taskId) async {
    final data = await notionTaskRepository.deleteTask(taskId);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      return null;
    }
    return Task(
      id: data['id'],
      title: _title(data),
      status: _status(data),
      dueDate: _date(data),
      url: data['url'],
      priority: _priority(data),
    );
  }

  Future<Task?> undoDeleteTask(String taskId) async {
    final data = await notionTaskRepository.revertTask(taskId);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      return null;
    }
    return Task(
      id: data['id'],
      title: _title(data),
      status: _status(data),
      dueDate: _date(data),
      url: data['url'],
      priority: _priority(data),
    );
  }

  /// プロパティをIDで検索する共通関数
  Map<String, dynamic>? _findPropertyById(
      Map<String, dynamic> data, String propertyId) {
    try {
      return (data['properties'] as Map<String, dynamic>)
          .entries
          .firstWhere((entry) => entry.value['id'] == propertyId,
              orElse: () => const MapEntry('', {}))
          .value;
    } catch (e) {
      print('Error finding property by id: $e');
      return null;
    }
  }

  String _title(Map<String, dynamic> data) {
    // titleプロパティは常にidが"title"
    final titleProperty = _findPropertyById(data, 'title')?['title'];
    return titleProperty?.length > 0 ? titleProperty[0]['plain_text'] : '';
  }

  TaskDate? _date(Map<String, dynamic> data) {
    final dateProperty = _findPropertyById(data, taskDatabase.date.id);
    if (dateProperty == null) {
      return null;
    }
    final date = dateProperty['date'];
    if (date == null) {
      return null;
    }
    return TaskDate(
      start: NotionDateTime.fromString(date['start']),
      end: date['end'] != null ? NotionDateTime.fromString(date['end']) : null,
    );
  }

  TaskStatus _status(Map<String, dynamic> data) {
    final property = taskDatabase.status;
    final statusData = _findPropertyById(data, property.id);
    if (statusData == null) {
      return const TaskStatus.status(group: null, option: null);
    }

    switch (property) {
      case CheckboxCompleteStatusProperty():
        return TaskStatus.checkbox(checkbox: statusData['checkbox']);
      case StatusCompleteStatusProperty(status: var status):
        // statusが未指定の場合がある
        if (statusData['status'] == null) {
          return const TaskStatus.status(group: null, option: null);
        }

        final optionId = statusData['status']['id'];
        final group = status.groups
            .where((group) => group.optionIds.contains(optionId))
            .firstOrNull;
        final option =
            status.options.where((option) => option.id == optionId).firstOrNull;

        return TaskStatus.status(group: group, option: option);
    }
  }

  SelectOption? _priority(Map<String, dynamic> data) {
    final property = taskDatabase.priority;
    if (property == null) {
      return null;
    }
    final propertyData = _findPropertyById(data, property.id);
    if (propertyData == null || propertyData['select'] == null) {
      return null;
    }
    final selectData = propertyData['select'];

    return SelectOption(
      id: selectData['id'],
      name: selectData['name'],
      color: NotionColor.fromString(selectData['color']),
    );
  }
}
