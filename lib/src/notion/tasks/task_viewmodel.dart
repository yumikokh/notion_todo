import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/snackbar/model/snackbar_state.dart';
import '../../common/snackbar/snackbar.dart';
import '../../helpers/date.dart';
import '../../notion/task_database/task_database_viewmodel.dart';
import '../model/task.dart';
import '../repository/notion_task_repository.dart';
import 'task_service.dart';

part 'task_viewmodel.g.dart';

@riverpod
class TaskViewModel extends _$TaskViewModel {
  late TaskService _taskService;
  late FilterType _filterType;

  @override
  Future<List<Task>> build({FilterType filterType = FilterType.all}) async {
    final repository = ref.watch(notionTaskRepositoryProvider);
    if (repository == null) {
      return [];
    }
    _taskService = TaskService(repository);
    _filterType = filterType;
    return _fetchTasks(filterType);
  }

  Future<List<Task>> _fetchTasks(FilterType filterType) async {
    final taskDatabase =
        ref.read(taskDatabaseViewModelProvider).valueOrNull?.taskDatabase;
    if (taskDatabase == null) {
      return [];
    }
    final tasks = await _taskService.fetchTasks(taskDatabase, filterType);
    state = AsyncValue.data(tasks);
    return tasks;
  }

  Future<void> addTask(String title, DateTime? dueDate) async {
    final taskDatabase =
        ref.read(taskDatabaseViewModelProvider).valueOrNull?.taskDatabase;
    if (taskDatabase == null) {
      return;
    }
    final snackbar = ref.read(snackbarProvider.notifier);

    final prevState = state;
    final tempId = DateTime.now().millisecondsSinceEpoch.toString();
    final newTask = Task(
        id: tempId,
        title: title,
        isCompleted: false,
        dueDate: dueDate != null ? TaskDate(start: dateString(dueDate)) : null);
    state = AsyncValue.data([...state.valueOrNull ?? [], newTask]);
    snackbar.show('「$title」を追加しました', type: SnackbarType.success);

    try {
      final t = await _taskService.addTask(
          taskDatabase, newTask.title, newTask.dueDate?.start); // MEMO: endは未実装
      state = AsyncValue.data([
        for (final task in state.valueOrNull ?? [])
          if (task.id == tempId) t else task
      ]);

      _fetchTasks(_filterType);
    } catch (e) {
      // エラーが起きたら一時的なidを持つタスクを元に戻す
      state = prevState;
      snackbar.show('「$title」の追加に失敗しました', type: SnackbarType.error);
    }
  }

  Future updateTask(Task updatedTask) async {
    final prevState = state;
    final taskDatabase =
        ref.read(taskDatabaseViewModelProvider).valueOrNull?.taskDatabase;
    final db = taskDatabase;
    final dueDate = updatedTask.dueDate;
    final prevTask =
        prevState.valueOrNull?.firstWhere((t) => t.id == updatedTask.id);
    if (prevTask == null) {
      return;
    }
    if (db == null) {
      return;
    }
    final snackbar = ref.read(snackbarProvider.notifier);

    state = state.whenData((t) {
      return t.map((t) => t.id == updatedTask.id ? updatedTask : t).toList();
    });
    snackbar.show('「${updatedTask.title}」を変更しました', type: SnackbarType.success,
        onUndo: () {
      updateTask(prevTask);
    });

    try {
      final res = await _taskService.updateTask(
          db, updatedTask.id, updatedTask.title, dueDate?.start);

      state = state.whenData((t) {
        return t.map((t) => t.id == updatedTask.id ? res : t).toList();
      });

      _fetchTasks(_filterType);
    } catch (e) {
      state = prevState;
      snackbar.show('「${updatedTask.title}」の変更に失敗しました',
          type: SnackbarType.error);
    }
  }

  Future updateStatus(Task task, bool isCompleted) async {
    final prevState = state;
    final taskDatabase =
        ref.read(taskDatabaseViewModelProvider).valueOrNull?.taskDatabase;
    if (taskDatabase == null) {
      return;
    }

    final snackbar = ref.read(snackbarProvider.notifier);

    snackbar.show(
        isCompleted ? '「${task.title}」を完了しました 🎉' : '「${task.title}」を未完了に戻しました',
        type: SnackbarType.success, onUndo: () {
      updateStatus(task, !isCompleted);
    });

    try {
      final res =
          await _taskService.updateStatus(taskDatabase, task.id, isCompleted);
      state = state.whenData((t) {
        return t.map((t) => t.id == res.id ? res : t).toList();
      });
    } catch (e) {
      state = prevState;
      snackbar.show('ステータスの更新に失敗しました', type: SnackbarType.error);
    }
  }

  Future<void> deleteTask(Task task) async {
    final prevState = state;
    final snackbar = ref.read(snackbarProvider.notifier);
    final taskDatabase =
        ref.read(taskDatabaseViewModelProvider).valueOrNull?.taskDatabase;
    if (taskDatabase == null) {
      return;
    }
    state = state.whenData((tasks) {
      return tasks.where((t) => t.id != task.id).toList();
    });
    snackbar.show('「${task.title}」を削除しました', type: SnackbarType.success,
        onUndo: () {
      undoDeleteTask(task);
    });
    try {
      final res = await _taskService.deleteTask(task.id, taskDatabase.status);
      if (res == null) {
        return;
      }
    } catch (e) {
      // エラーが発生した場合は元の状態に戻す
      state = prevState;
      snackbar.show('削除に失敗しました', type: SnackbarType.error);
    }
  }

  Future<Task?> undoDeleteTask(Task prev) async {
    final prevState = state;
    final taskDatabase =
        ref.read(taskDatabaseViewModelProvider).valueOrNull?.taskDatabase;
    if (taskDatabase == null) {
      return null;
    }
    final snackbar = ref.read(snackbarProvider.notifier);
    state = state.whenData((tasks) {
      return [...tasks, prev];
    });
    snackbar.show('「${prev.title}」を復元しました', type: SnackbarType.success);

    try {
      final restoredTask =
          await _taskService.undoDeleteTask(prev.id, taskDatabase.status);
      if (restoredTask == null) {
        return null;
      }

      // APIからの応答で状態を更新
      state = state.whenData((tasks) {
        return tasks.map((task) {
          if (task.id == prev.id) {
            return restoredTask;
          }
          return task;
        }).toList();
      });

      _fetchTasks(_filterType);

      return restoredTask;
    } catch (e) {
      // エラーが発生した場合は元の状態に戻す
      state = prevState;
      snackbar.show('復元に失敗しました', type: SnackbarType.error);
    }
    return null;
  }

  ({Color color, IconData icon, double size, List<String> dateStrings})?
      getDisplayDate(Task task, BuildContext context) {
    final defaultColor = Theme.of(context).colorScheme.secondary;
    const icon = Icons.event_rounded;
    const size = 13.0;
    final dueDate = task.dueDate;
    final now = DateTime.now();

    if (dueDate == null) {
      return null;
    }
    final dueDateEnd = dueDate.end;

    Color determineColor(TaskDate dueDate, DateTime now) {
      final dueDateEnd = dueDate.end;
      if (dueDateEnd == null &&
          isToday(DateTime.parse(dueDate.start)) &&
          !hasTime(dueDate.start)) {
        return Theme.of(context).colorScheme.tertiary; // 今日だったら青
      } else if ((dueDateEnd != null &&
              DateTime.parse(dueDateEnd).isBefore(now)) ||
          (dueDateEnd == null && DateTime.parse(dueDate.start).isBefore(now))) {
        return Theme.of(context).colorScheme.error; // 過ぎてたら赤
      } else {
        return defaultColor; // それ以外は灰色
      }
    }

    final c = determineColor(dueDate, now);

    List<String> dateStrings = [
      formatDateTime(dueDate.start, showToday: _filterType == FilterType.all),
      if (dueDateEnd != null)
        formatDateTime(dueDateEnd, showToday: _filterType == FilterType.all),
    ].whereType<String>().toList();

    return (
      color: c,
      icon: icon,
      size: size,
      dateStrings: dateStrings,
    );
  }
}
