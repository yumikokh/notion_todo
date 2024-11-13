import 'package:notion_todo/src/notion/task_database/task_database_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/task.dart';
import '../oauth/notion_oauth_viewmodel.dart';
import '../repository/notion_database_repository.dart';
import 'task_service.dart';

part 'task_viewmodel.g.dart';

@riverpod
class TaskViewModel extends _$TaskViewModel {
  late TaskService? _taskService;

  @override
  List<Task> build() {
    _initialize();
    return [];
  }

  _initialize() async {
    final accessToken = ref.watch(notionOAuthViewModelProvider).accessToken;
    if (accessToken == null) {
      return;
    }
    _taskService = TaskService(accessToken);
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    if (_taskService == null) {
      return;
    }
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).taskDatabase;
    if (taskDatabase == null) {
      return;
    }
    final tasks =
        await _taskService!.fetchTasks(taskDatabase, FilterType.today);

    state = tasks;
  }

  Future updateStatus(String taskId, bool isCompleted) async {
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).taskDatabase;
    if (taskDatabase == null) {
      return;
    }
    final status = taskDatabase.status;
    await _taskService!.updateStatus(taskId, status, isCompleted);
    await fetchTasks();
  }

  Future addTask(String title, DateTime? dueDate) async {
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).taskDatabase;
    if (taskDatabase == null) {
      return;
    }
    final task = await _taskService!.addTask(taskDatabase, title, dueDate);
    state = [...state, task];
    fetchTasks();
  }

  void deleteTask(String taskId) {
    _taskService!.deleteTask(taskId);
    state = state.where((task) => task.id != taskId).toList();
  }

  Future undoDeleteTask(Task prev) async {
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).taskDatabase;
    if (taskDatabase == null) {
      return;
    }
    final task =
        await _taskService!.undoDeleteTask(prev.id, taskDatabase.status);
    state = [...state, prev];
    fetchTasks();
    return task;
  }
}
