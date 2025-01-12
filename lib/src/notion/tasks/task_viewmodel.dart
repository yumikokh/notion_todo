import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'dart:collection';

import '../../common/error.dart';
import '../../common/snackbar/model/snackbar_state.dart';
import '../../common/snackbar/snackbar.dart';
import '../../helpers/date.dart';
import '../../settings/settings_viewmodel.dart';
import '../../settings/task_database/task_database_viewmodel.dart';
import '../model/task.dart';
import '../repository/notion_task_repository.dart';
import 'task_service.dart';

part 'task_viewmodel.g.dart';

@riverpod
class TaskViewModel extends _$TaskViewModel {
  late TaskService _taskService;
  late FilterType _filterType;
  late bool _showCompleted;
  bool _hasMore = false;
  bool get hasMore => _hasMore;
  String? _nextCursor;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  static final DateHelper d = DateHelper();

  @override
  Future<List<Task>> build({
    FilterType filterType = FilterType.all,
  }) async {
    final repository = ref.watch(notionTaskRepositoryProvider);
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).valueOrNull;

    if (repository == null || taskDatabase == null) {
      return [];
    }

    _taskService = TaskService(repository, taskDatabase);
    _filterType = filterType;
    // MEMO: ユースケースを鑑みて読み込みは固定にする
    // もしpageSize以上のタスクがあったとき、「showCompleted」と「Load more」の不整合がおきるがいったん無視
    _showCompleted = filterType == FilterType.today;

    return await _fetchTasks(isFirstFetch: true);
  }

  Future<void> loadMore() async {
    if (!_hasMore || _nextCursor == null || _isLoading) return;

    final currentTasks = state.valueOrNull ?? [];

    try {
      final tasks = await _fetchTasks();
      state = AsyncValue.data([...currentTasks, ...tasks]);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

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

  Future<List<Task>> _fetchTasks({bool isFirstFetch = false}) async {
    final taskDatabase = ref.read(taskDatabaseViewModelProvider).valueOrNull;
    if (taskDatabase == null) {
      return [];
    }
    final locale = ref.read(settingsViewModelProvider).locale;
    final l = await AppLocalizations.delegate.load(locale);
    _isLoading = true;
    ref.notifyListeners(); // ローディング状態が更新されるようにする
    try {
      final cursor = isFirstFetch ? null : _nextCursor;
      final result = await _taskService.fetchTasks(_filterType, _showCompleted,
          startCursor: cursor);
      _hasMore = result.hasMore;
      _nextCursor = result.nextCursor;
      // バッジ更新
      if (filterType == FilterType.today) {
        _updateBadge(result.tasks);
      }
      return result.tasks;
    } catch (e) {
      if (e is TaskException && e.statusCode == 404) {
        final snackbar = ref.read(snackbarProvider.notifier);
        final taskDatabaseViewModel =
            ref.read(taskDatabaseViewModelProvider.notifier);
        taskDatabaseViewModel.clear();
        snackbar.show("${l.not_found_database} ${l.re_set_database}",
            type: SnackbarType.error);
      }
      if (e is TaskException && e.statusCode == 400) {
        final snackbar = ref.read(snackbarProvider.notifier);
        final taskDatabaseViewModel =
            ref.read(taskDatabaseViewModelProvider.notifier);
        taskDatabaseViewModel.clear();
        snackbar.show("${l.not_found_property} ${l.re_set_database}",
            type: SnackbarType.error);
      }
      return [];
    } finally {
      _isLoading = false;
    }
  }

  Future<void> addTask(String title, DateTime? dueDate) async {
    final locale = ref.read(settingsViewModelProvider).locale;
    final l = await AppLocalizations.delegate.load(locale);
    await _addOperation(() async {
      final taskDatabase = ref.read(taskDatabaseViewModelProvider).valueOrNull;
      if (taskDatabase == null || title.trim().isEmpty) {
        return;
      }
      final snackbar = ref.read(snackbarProvider.notifier);

      final prevState = state;
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();
      final tempTask = Task(
          id: tempId,
          title: title,
          isCompleted: false,
          dueDate:
              dueDate != null ? TaskDate(start: d.dateString(dueDate)) : null,
          url: null);

      state = AsyncValue.data([...state.valueOrNull ?? [], tempTask]);

      try {
        final t = await _taskService.addTask(
            tempTask.title, tempTask.dueDate?.start); // TODO: endは未実装

        // 最新のstateを使用して更新
        state = AsyncValue.data([
          for (final task in state.valueOrNull ?? [])
            if (task.id == tempId) t else task
        ]);

        snackbar.show(
          l.add_task_success(title),
          type: SnackbarType.success,
          onUndo: () {
            deleteTask(t);
          },
        );
        ref.invalidateSelf();
      } catch (e) {
        state = prevState;
        snackbar.show(
          l.task_add_failed(title),
          type: SnackbarType.error,
        );
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
      final locale = ref.read(settingsViewModelProvider).locale;
      final l = await AppLocalizations.delegate.load(locale);

      state = state.whenData((t) {
        return t.map((t) => t.id == updatedTask.id ? updatedTask : t).toList();
      });
      snackbar.show(l.task_update_success(updatedTask.title),
          type: SnackbarType.success, onUndo: () {
        updateTask(prevTask);
      });

      try {
        final res = await _taskService.updateTask(
            updatedTask.id, updatedTask.title, dueDate?.start);

        state = state.whenData((t) {
          return t.map((t) => t.id == updatedTask.id ? res : t).toList();
        });
        ref.invalidateSelf();
      } catch (e) {
        state = prevState;
        snackbar.show(l.task_update_failed(updatedTask.title),
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
      final locale = ref.read(settingsViewModelProvider).locale;
      final l = await AppLocalizations.delegate.load(locale);
      snackbar.show(
          isCompleted
              ? l.task_update_status_success(task.title)
              : l.task_update_status_undo(task.title),
          type: SnackbarType.success, onUndo: () {
        updateStatus(task, !isCompleted);
      });

      _isLoading = true;
      try {
        final res = await _taskService.updateStatus(task.id, isCompleted);
        state = state.whenData((t) {
          return t.map((t) => t.id == res.id ? res : t).toList();
        });
        ref.invalidateSelf();
      } catch (e) {
        snackbar.show(l.task_update_status_failed, type: SnackbarType.error);
      } finally {
        _isLoading = false;
      }
    });
  }

  Future<void> deleteTask(Task task) async {
    await _addOperation(() async {
      final taskDatabase = ref.read(taskDatabaseViewModelProvider).valueOrNull;
      if (taskDatabase?.status == null) return;

      final prevState = state;
      final snackbar = ref.read(snackbarProvider.notifier);
      final locale = ref.read(settingsViewModelProvider).locale;
      final l = await AppLocalizations.delegate.load(locale);
      // 最新のstateから該当タスクを削除
      state = AsyncValue.data([
        for (final t in state.valueOrNull ?? [])
          if (t.id != task.id) t
      ]);
      snackbar.show(l.task_delete_success(task.title),
          type: SnackbarType.success, onUndo: () {
        undoDeleteTask(task);
      });

      try {
        await _taskService.deleteTask(task.id);
      } catch (e) {
        state = prevState;
        snackbar.show(l.task_delete_failed(task.title),
            type: SnackbarType.error);
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
      final locale = ref.read(settingsViewModelProvider).locale;
      final l = await AppLocalizations.delegate.load(locale);
      final prevState = state;
      state = state.whenData((tasks) {
        return [...tasks, prev];
      });
      snackbar.show(l.task_delete_undo(prev.title), type: SnackbarType.success);

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

        ref.invalidateSelf();
      } catch (e) {
        // エラーが発生した場合は元の状態に戻す
        state = prevState;
        snackbar.show(l.task_delete_failed_undo(prev.title),
            type: SnackbarType.error);
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
          d.isToday(DateTime.parse(dueDate.start)) &&
          !d.hasTime(dueDate.start)) {
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
      d.formatDateTime(dueDate.start, showToday: _filterType == FilterType.all),
      if (dueDateEnd != null)
        d.formatDateTime(dueDateEnd, showToday: _filterType == FilterType.all),
    ].whereType<String>().toList();

    return (
      color: c,
      icon: icon,
      size: size,
      dateStrings: dateStrings,
    );
  }

  Future<void> _updateBadge(List<Task> tasks) async {
    final notCompletedCount = tasks.where((task) => !task.isCompleted).length;
    await FlutterAppBadger.updateBadgeCount(notCompletedCount);
  }
}
