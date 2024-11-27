import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:collection';

import '../../common/error.dart';
import '../../common/snackbar/model/snackbar_state.dart';
import '../../common/snackbar/snackbar.dart';
import '../../helpers/date.dart';
import '../../settings/task_database/task_database_viewmodel.dart';
import '../model/task.dart';
import '../repository/notion_task_repository.dart';
import 'task_service.dart';

part 'task_viewmodel.g.dart';

@riverpod
class TaskViewModel extends _$TaskViewModel {
  late TaskService _taskService;
  late FilterType _filterType;

  // 操作のキューを管理するための変数
  final _operationQueue = Queue<Future<void> Function()>();
  bool _isProcessing = false;

  // キューを処理する関数
  Future<void> _processQueue() async {
    if (_isProcessing) return;

    _isProcessing = true;
    try {
      while (_operationQueue.isNotEmpty) {
        final operation = _operationQueue.removeFirst();
        await operation();
      }
    } finally {
      _isProcessing = false;
    }
  }

  // キューに操作を追加する関数
  Future<void> _addOperation(Future<void> Function() operation) async {
    _operationQueue.add(operation);
    await _processQueue();
  }

  @override
  Future<List<Task>> build({FilterType filterType = FilterType.all}) async {
    final repository = ref.watch(notionTaskRepositoryProvider);
    final taskDatabase = ref.read(taskDatabaseViewModelProvider).valueOrNull;
    if (repository == null || taskDatabase == null) {
      return [];
    }
    _taskService = TaskService(repository, taskDatabase);
    _filterType = filterType;
    return _fetchTasks(filterType);
  }

  Future<List<Task>> _fetchTasks(FilterType filterType) async {
    final taskDatabase = ref.read(taskDatabaseViewModelProvider).valueOrNull;
    if (taskDatabase == null) {
      return [];
    }
    try {
      final tasks = await _taskService.fetchTasks(filterType);
      state = AsyncValue.data(tasks);
      return tasks;
    } catch (e) {
      if (e is TaskException && e.statusCode == 404) {
        final snackbar = ref.read(snackbarProvider.notifier);
        final taskDatabaseViewModel =
            ref.read(taskDatabaseViewModelProvider.notifier);
        taskDatabaseViewModel.clear();
        snackbar.show('適切なデータベースが見つかりませんでした。再設定が必要です。',
            type: SnackbarType.error);
      }
      if (e is TaskException && e.statusCode == 400) {
        final snackbar = ref.read(snackbarProvider.notifier);
        final taskDatabaseViewModel =
            ref.read(taskDatabaseViewModelProvider.notifier);
        taskDatabaseViewModel.clear();
        snackbar.show('適切なプロパティが見つかりませんでした。再設定が必要です。',
            type: SnackbarType.error);
      }
      return [];
    }
  }

  Future<void> addTask(String title, DateTime? dueDate) async {
    await _addOperation(() async {
      final taskDatabase = ref.read(taskDatabaseViewModelProvider).valueOrNull;
      if (taskDatabase == null || title.trim().isEmpty) {
        return;
      }
      final snackbar = ref.read(snackbarProvider.notifier);

      final prevState = state;
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();
      final newTask = Task(
          id: tempId,
          title: title,
          isCompleted: false,
          dueDate:
              dueDate != null ? TaskDate(start: dateString(dueDate)) : null);

      state = AsyncValue.data([...state.valueOrNull ?? [], newTask]);

      try {
        final t = await _taskService.addTask(
            newTask.title, newTask.dueDate?.start); // TODO: endは未実装

        // 最新のstateを使用して更新
        state = AsyncValue.data([
          for (final task in state.valueOrNull ?? [])
            if (task.id == tempId) t else task
        ]);

        snackbar.show('「$title」を追加しました', type: SnackbarType.success,
            onUndo: () {
          deleteTask(t);
        });
      } catch (e) {
        state = prevState;
        snackbar.show('「$title」の追加に失敗しました', type: SnackbarType.error);
      }
    });
  }

  Future updateTask(Task updatedTask) async {
    await _addOperation(() async {
      final db = ref.read(taskDatabaseViewModelProvider).valueOrNull;
      final dueDate = updatedTask.dueDate;
      final prevState = state;
      final prevTask = prevState.valueOrNull
          ?.where((t) => t.id == updatedTask.id)
          .firstOrNull;
      if (prevTask == null || updatedTask.title.trim().isEmpty) {
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
            updatedTask.id, updatedTask.title, dueDate?.start);

        state = state.whenData((t) {
          return t.map((t) => t.id == updatedTask.id ? res : t).toList();
        });

        _fetchTasks(_filterType);
      } catch (e) {
        state = prevState;
        snackbar.show('「${updatedTask.title}」の変更に失敗しました',
            type: SnackbarType.error);
      }
    });
  }

  Future updateStatus(Task task, bool isCompleted) async {
    await _addOperation(() async {
      final taskDatabase = ref.read(taskDatabaseViewModelProvider).valueOrNull;
      if (taskDatabase == null) {
        return;
      }

      final snackbar = ref.read(snackbarProvider.notifier);

      snackbar.show(
          isCompleted
              ? '「${task.title}」を完了しました 🎉'
              : '「${task.title}」を未完了に戻しました',
          type: SnackbarType.success, onUndo: () {
        updateStatus(task, !isCompleted);
      });

      try {
        final res = await _taskService.updateStatus(task.id, isCompleted);
        state = state.whenData((t) {
          return t.map((t) => t.id == res.id ? res : t).toList();
        });
      } catch (e) {
        snackbar.show('ステータスの更新に失敗しました', type: SnackbarType.error);
      }
    });
  }

  Future<void> deleteTask(Task task) async {
    await _addOperation(() async {
      final taskDatabase = ref.read(taskDatabaseViewModelProvider).valueOrNull;
      if (taskDatabase?.status == null) return;

      final prevState = state;
      final snackbar = ref.read(snackbarProvider.notifier);

      // 最新のstateから該当タスクを削除
      state = AsyncValue.data([
        for (final t in state.valueOrNull ?? [])
          if (t.id != task.id) t
      ]);

      try {
        await _taskService.deleteTask(task.id);
        snackbar.show('「${task.title}」を削除しました', type: SnackbarType.success,
            onUndo: () {
          undoDeleteTask(task);
        });
      } catch (e) {
        state = prevState;
        snackbar.show('「${task.title}」の削除に失敗しました', type: SnackbarType.error);
      }
    });
  }

  Future<void> undoDeleteTask(Task prev) async {
    await _addOperation(() async {
      final taskDatabase = ref.read(taskDatabaseViewModelProvider).valueOrNull;
      if (taskDatabase == null) {
        return;
      }
      final snackbar = ref.read(snackbarProvider.notifier);
      final prevState = state;
      state = state.whenData((tasks) {
        return [...tasks, prev];
      });
      snackbar.show('「${prev.title}」を復元しました', type: SnackbarType.success);

      try {
        final restoredTask = await _taskService.undoDeleteTask(prev.id);
        if (restoredTask == null) {
          return;
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
      } catch (e) {
        // エラーが発生した場合は元の状態に戻す
        state = prevState;
        snackbar.show('復元に失敗しました', type: SnackbarType.error);
      }
    });
  }

  ({Color color, IconData icon, double size, List<String> dateStrings})?
      getDisplayDate(Task task, BuildContext context) {
    final defaultColor = Theme.of(context).colorScheme.secondary;
    const icon = Icons.event_rounded;
    const size = 13.0;
    final dueDate = task.dueDate;

    if (dueDate == null) {
      return null;
    }
    final dueDateEnd = dueDate.end;

    Color determineColor(TaskDate dueDate) {
      final now = DateTime.now();
      final dueDateEnd = dueDate.end;
      if (dueDateEnd == null &&
          isToday(DateTime.parse(dueDate.start)) &&
          !hasTime(dueDate.start)) {
        return Theme.of(context).colorScheme.tertiary; // 今日だったら青
      }

      if ((dueDateEnd != null && DateTime.parse(dueDateEnd).isBefore(now)) ||
          (dueDateEnd == null && DateTime.parse(dueDate.start).isBefore(now))) {
        return Theme.of(context).colorScheme.error; // 過ぎてたら赤
      }

      return defaultColor; // それ以外は灰色
    }

    final c = determineColor(dueDate);

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
