import 'package:notion_todo/src/notion/task_database/task_database_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    return [Task.initial()];
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
    final tasks = await _taskService!.fetchTasks(taskDatabase.id,
        FilterType.today, taskDatabase.date!.name, taskDatabase.status!.name);
    state = tasks;
  }

  // void selectTask(String? taskId) {
  //   final selected = state.tasks.firstWhere((task) => task.id == taskId);
  //   state = state.copyWith(
  //     selectedTask: Task(
  //       id: taskId!,
  //       title: selected.title,
  //       description: selected.description,
  //       status: selected.status,
  //       dueDate: selected.dueDate,
  //     ),
  //   );
  // }

  // void updateTask(Task task) {
  //   state = state.copyWith(
  //     tasks: state.tasks.map((t) {
  //       if (t.id == task.id) {
  //         return task;
  //       }
  //       return t;
  //     }).toList(),
  //   );
  // }

  // void addTask(Task task) {
  //   state = state.copyWith(tasks: [...state.tasks, task]);
  // }

  // void deleteTask(String taskId) {
  //   state = state.copyWith(
  //     tasks: state.tasks.where((task) => task.id != taskId).toList(),
  //   );
  // }
}
