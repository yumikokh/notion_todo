import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notion_todo/src/notion/task_database/task_database_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/task.dart';
import '../repository/notion_database_repository.dart';
import 'task_service.dart';

part 'task_viewmodel.g.dart';

@riverpod
class TaskViewModel extends _$TaskViewModel {
  late final TaskService _taskService;

  @override
  List<Task> build() {
    final repository = ref.watch(notionDatabaseRepositoryProvider);
    _taskService = TaskService(repository);

    fetchTasks();
    return [];
  }

  Future<void> fetchTasks() async {
    final taskDatabase = ref.read(taskDatabaseViewModelProvider).taskDatabase;
    if (taskDatabase == null) {
      return;
    }
    final tasks = await _taskService.fetchTasks(
        taskDatabase, FilterType.today); // TODO: filterを追加
    state = tasks;
  }

  Future addTask(String title, DateTime? dueDate) async {
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).taskDatabase;
    if (taskDatabase == null) {
      return;
    }
    await _taskService.addTask(taskDatabase, title, dueDate);
    // state = [...state, task]; // 表示の更新はfetchTasksで行う
    fetchTasks();
  }

  Future updateTask(Task task) async {
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).taskDatabase;
    final db = taskDatabase;
    final dueDate = task.dueDate;
    if (db == null) {
      return;
    }
    await _taskService.updateTask(db, task.id, task.title,
        dueDate == null ? null : DateTime.parse(dueDate.start));
    // state = state.map((t) => t.id == task.id ? updatedTask : t).toList(); // 表示の更新はfetchTasksで行う

    fetchTasks();
  }

  Future updateStatus(String taskId, bool isCompleted) async {
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).taskDatabase;
    if (taskDatabase == null) {
      return;
    }
    await _taskService.updateStatus(taskDatabase, taskId, isCompleted);
    await fetchTasks();
  }

  void deleteTask(String taskId) {
    _taskService.deleteTask(taskId);
    state = state.where((task) => task.id != taskId).toList();
  }

  Future undoDeleteTask(Task prev) async {
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).taskDatabase;
    if (taskDatabase == null) {
      return;
    }
    final task =
        await _taskService.undoDeleteTask(prev.id, taskDatabase.status);
    state = [...state, prev];
    fetchTasks();
    return task;
  }

  ({Color color, IconData icon, double size, List<String> dateStrings})?
      getDisplayDate(Task task) {
    final defaultColor = Colors.grey[600];
    const icon = Icons.event_rounded;
    const size = 13.0;
    final dueDate = task.dueDate;
    final now = DateTime.now();

    if (dueDate == null) {
      return null;
    }

    final color =
        ((dueDate.end != null && DateTime.parse(dueDate.end!).isBefore(now)) ||
                (dueDate.end == null &&
                    DateTime.parse(dueDate.start).isBefore(now)))
            ? Colors.red // 過ぎてたら赤
            : defaultColor; // それ以外は灰色

    List<String> dateStrings = [
      formatDateTime(dueDate.start),
      if (dueDate.end != null) formatDateTime(dueDate.end!),
    ].whereType<String>().toList();

    return (
      color: color!,
      icon: icon,
      size: size,
      dateStrings: dateStrings,
    );
  }
}

String? formatDateTime(String dateTime, {bool showToday = false}) {
  final parsed = DateTime.parse(dateTime).toLocal();
  final date = DateTime(parsed.year, parsed.month, parsed.day);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  final hasTime = dateTime.contains('T');

  String? formatText() {
    if (date == today) {
      if (!showToday) {
        return hasTime ? "HH:mm" : null;
      }
      return hasTime ? "'Today' HH:mm" : "'Today'";
    }
    if (date == yesterday) {
      return hasTime ? "'Yesterday' HH:mm" : "'Yesterday'";
    }
    if (date == tomorrow) {
      return hasTime ? "'Tomorrow' HH:mm" : "'Tomorrow'";
    }
    if (date.year == today.year) {
      if (date.month == today.month) {
        return hasTime ? "dd E HH:mm" : "dd E";
      }
      return hasTime ? "MM/dd HH:mm" : "MM/dd";
    }
    return 'yyyy/MM/dd';
  }

  final format = formatText();

  return format != null ? DateFormat(format).format(parsed.toLocal()) : null;
}
