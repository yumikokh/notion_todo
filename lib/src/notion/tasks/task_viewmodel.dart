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
import '../model/property.dart';
import '../model/task.dart';
import '../repository/notion_task_repository.dart';
import 'task_service.dart';
import '../../common/analytics/analytics_service.dart';
import '../../common/app_review/app_review_service.dart';

part 'task_viewmodel.g.dart';

@riverpod
class TaskViewModel extends _$TaskViewModel {
  late TaskService? _taskService;
  late FilterType _filterType;
  late bool _hasCompleted;
  bool _hasMore = false;
  bool get hasMore => _hasMore;
  String? _nextCursor;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _showCompleted = false;
  bool get showCompleted => _showCompleted;

  static final DateHelper d = DateHelper();

  @override
  Future<List<Task>> build({
    FilterType filterType = FilterType.all,
  }) async {
    _taskService = await ref.watch(taskServiceProvider.future);

    if (_taskService == null) {
      await FlutterAppBadger.removeBadge();
      return [];
    }

    _showCompleted = await _taskService!.loadShowCompleted();

    _filterType = filterType;
    // MEMO: ユースケースを鑑みて読み込みは固定にする
    // もしpageSize以上のタスクがあったとき、「showCompleted」と「Load more」の不整合がおきるがいったん無視
    _hasCompleted = filterType == FilterType.today;

    final statusProperty =
        ref.watch(taskDatabaseViewModelProvider).valueOrNull?.status;
    final tasks = await _fetchTasks(isFirstFetch: true);

    if (statusProperty is StatusCompleteStatusProperty) {
      final inProgressOption = statusProperty.inProgressOption;
      if (inProgressOption == null) {
        return tasks;
      }
      return tasks..sort((a, b) => a.isInProgress(inProgressOption) ? -1 : 1);
    }

    return tasks;
  }

  Future<void> toggleShowCompleted() async {
    _showCompleted = !_showCompleted;
    if (_taskService != null) {
      await _taskService!.saveShowCompleted(_showCompleted);
    }
    try {
      final analytics = ref.read(analyticsServiceProvider);
      await analytics.logCompletedTasksToggle(
        isVisible: _showCompleted,
        screenName: _filterType == FilterType.today ? 'Today' : 'All',
      );
    } catch (e) {
      print('Analytics error: $e');
    }
    ref.notifyListeners();
  }

  Future<void> loadMore() async {
    if (!_hasMore || _nextCursor == null || _isLoading) return;

    final currentTasks = state.valueOrNull ?? [];

    try {
      final tasks = await _fetchTasks();
      state = AsyncValue.data([...currentTasks, ...tasks]);

      try {
        final analytics = ref.read(analyticsServiceProvider);
        analytics.logTask('load_more', pageSize: tasks.length);
      } catch (e) {
        print('Analytics error: $e');
      }
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
    final taskService = _taskService;
    if (taskService == null) {
      return [];
    }
    final locale = ref.read(settingsViewModelProvider).locale;
    final l = await AppLocalizations.delegate.load(locale);
    _isLoading = true;
    ref.notifyListeners(); // ローディング状態が更新されるようにする
    try {
      final cursor = isFirstFetch ? null : _nextCursor;
      final result = await taskService.fetchTasks(_filterType, _hasCompleted,
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
        final analytics = ref.read(analyticsServiceProvider);

        taskDatabaseViewModel.clear();
        snackbar.show("${l.not_found_database} ${l.re_set_database}",
            type: SnackbarType.error);

        try {
          await analytics.logError(
            'database_not_found',
            error: e,
            parameters: {'status_code': 404},
          );
        } catch (trackingError) {
          print('Analytics error: $trackingError');
        }
      }
      if (e is TaskException && e.statusCode == 400) {
        final snackbar = ref.read(snackbarProvider.notifier);
        final taskDatabaseViewModel =
            ref.read(taskDatabaseViewModelProvider.notifier);
        final analytics = ref.read(analyticsServiceProvider);

        taskDatabaseViewModel.clear();
        snackbar.show("${l.not_found_property} ${l.re_set_database}",
            type: SnackbarType.error);

        try {
          await analytics.logError(
            'property_not_found',
            error: e,
            parameters: {'status_code': 400},
          );
        } catch (trackingError) {
          print('Analytics error: $trackingError');
        }
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
      final taskService = _taskService;
      if (taskService == null || title.trim().isEmpty) {
        return;
      }
      final snackbar = ref.read(snackbarProvider.notifier);
      final analytics = ref.read(analyticsServiceProvider);

      final prevState = state;
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();
      final tempTask = Task(
          id: tempId,
          title: title,
          status: const TaskStatus.checkbox(checked: false),
          dueDate:
              dueDate != null ? TaskDate(start: d.dateString(dueDate)) : null,
          url: null);

      state = AsyncValue.data([...state.valueOrNull ?? [], tempTask]);

      try {
        final t =
            await taskService.addTask(tempTask.title, tempTask.dueDate?.start);

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

        // アナリティクスを記録（エラーハンドリングを追加）
        try {
          await analytics.logTask(
            'task_created',
            hasDueDate: tempTask.dueDate != null,
          );
        } catch (analyticsError) {
          // アナリティクスのエラーは無視して処理を続行
          print('Analytics error: $analyticsError');
        }
      } catch (e) {
        state = prevState;
        snackbar.show(l.task_add_failed(tempTask.title),
            type: SnackbarType.error);
      }
    });
  }

  Future<void> updateTask(Task task, {bool fromUndo = false}) async {
    await _addOperation(() async {
      final taskService = _taskService;
      final prevState = state;
      final prevTask =
          prevState.valueOrNull?.where((t) => t.id == task.id).firstOrNull;
      if (prevTask == null || task.title.trim().isEmpty) {
        return;
      }
      if (taskService == null) {
        return;
      }

      String? updatedDueDate;
      final inputDueDateStart = task.dueDate?.start;
      final prevDueDateStart = prevTask.dueDate?.start;
      // 入力された日付がある場合のみ
      if (inputDueDateStart != null) {
        updatedDueDate = inputDueDateStart;
        // もともとのタスクに日付がある場合
        if (prevDueDateStart != null) {
          final inputDateTime = DateTime.parse(inputDueDateStart);
          final prevDateTime = DateTime.parse(prevDueDateStart);

          // 日付が変更されている場合は時間情報を削除
          if (!d.isThisDay(prevDateTime, inputDateTime)) {
            updatedDueDate = d.dateString(inputDateTime);
          } else {
            updatedDueDate = inputDueDateStart;
          }
        } else {
          // もともとのタスクに日付がなかった場合
          updatedDueDate = inputDueDateStart;
        }
      }

      final snackbar = ref.read(snackbarProvider.notifier);
      final locale = ref.read(settingsViewModelProvider).locale;
      final l = await AppLocalizations.delegate.load(locale);

      state = AsyncValue.data([
        for (final t in state.valueOrNull ?? [])
          if (t.id == task.id) task else t
      ]);

      snackbar.show(l.task_update_success(task.title),
          type: SnackbarType.success, onUndo: () async {
        updateTask(prevTask, fromUndo: true);
      });

      try {
        final updatedTask =
            await taskService.updateTask(task.id, task.title, updatedDueDate);

        state = AsyncValue.data([
          for (final Task t in state.valueOrNull ?? [])
            if (t.id == task.id) updatedTask else t
        ]);
        ref.invalidateSelf();

        try {
          final analytics = ref.read(analyticsServiceProvider);
          await analytics.logTask(
            'task_updated',
            hasDueDate: updatedTask.dueDate?.start != null,
            isCompleted: updatedTask.isCompleted,
            fromUndo: fromUndo,
          );
        } catch (e) {
          print('Analytics error: $e');
        }
      } catch (e) {
        state = prevState;
        snackbar.show(l.task_update_failed(task.title),
            type: SnackbarType.error);
      }
    });
  }

  Future<void> updateCompleteStatus(Task task, bool isCompleted,
      {bool fromUndo = false}) async {
    await _addOperation(() async {
      final taskService = _taskService;
      if (taskService == null) {
        return;
      }
      final snackbar = ref.read(snackbarProvider.notifier);
      final locale = ref.read(settingsViewModelProvider).locale;
      final l = await AppLocalizations.delegate.load(locale);
      snackbar.show(
          isCompleted
              ? l.task_update_status_success(task.title)
              : l.task_update_status_undo(task.title),
          type: SnackbarType.success, onUndo: () async {
        updateCompleteStatus(task, !isCompleted, fromUndo: true);
      });

      _isLoading = true;
      final prevState = state;
      try {
        final updatedTask =
            await taskService.updateCompleteStatus(task.id, isCompleted);
        state = AsyncValue.data([
          for (final t in state.valueOrNull ?? [])
            if (t.id == updatedTask.id) updatedTask else t
        ]);
        ref.invalidateSelf();

        // [レビューポップアップ] 今日のタスクが全て完了したかチェック
        if (!fromUndo && isCompleted && _filterType == FilterType.today) {
          final tasks = state.valueOrNull ?? [];
          final allTasksCompleted = tasks.every((t) => t.isCompleted);

          if (allTasksCompleted && tasks.isNotEmpty) {
            final reviewService = AppReviewService.instance;
            await reviewService.incrementCompletedDaysCount();

            if (await reviewService.shouldRequestReview()) {
              await reviewService.requestReview();
            }
          }
        }

        try {
          final analytics = ref.read(analyticsServiceProvider);
          await analytics.logTask(
            'task_completed',
            hasDueDate: task.dueDate?.start != null,
            isCompleted: isCompleted,
            fromUndo: fromUndo,
          );
        } catch (e) {
          print('Analytics error: $e');
        }
      } catch (e) {
        state = prevState;
        snackbar.show(l.task_update_status_failed, type: SnackbarType.error);
      } finally {
        _isLoading = false;
      }
    });
  }

  Future<void> updateInProgressStatus(Task task,
      {bool fromUndo = false}) async {
    // checkboxは更新できない
    if (task.status is CheckboxCompleteStatusProperty) {
      return;
    }
    await _addOperation(() async {
      final taskService = _taskService;
      if (taskService == null) {
        return;
      }
      final statusProperty =
          ref.read(taskDatabaseViewModelProvider).valueOrNull?.status;
      if (statusProperty is! StatusCompleteStatusProperty) {
        return;
      }
      final inProgressOption = statusProperty.inProgressOption;
      if (inProgressOption == null) {
        return;
      }
      final snackbar = ref.read(snackbarProvider.notifier);
      final locale = ref.read(settingsViewModelProvider).locale;
      final l = await AppLocalizations.delegate.load(locale);

      final willBeInProgress = !task.isInProgress(inProgressOption);
      final prevState = state;

      snackbar.show(
          willBeInProgress
              ? l.task_update_status_in_progress(task.title)
              : l.task_update_status_todo(task.title),
          type: SnackbarType.success, onUndo: () async {
        updateInProgressStatus(task, fromUndo: true);
      });

      _isLoading = true;

      try {
        final updatedTask =
            await taskService.updateInProgressStatus(task.id, willBeInProgress);
        state = AsyncValue.data([
          for (final t in state.valueOrNull ?? [])
            if (t.id == updatedTask.id) updatedTask else t
        ]);
        ref.invalidateSelf();

        try {
          final analytics = ref.read(analyticsServiceProvider);
          await analytics.logTask(
            'task_in_progress_updated',
            hasDueDate: task.dueDate?.start != null,
            fromUndo: fromUndo,
          );
        } catch (e) {
          print('Analytics error: $e');
        }
      } catch (e) {
        state = prevState;
        snackbar.show(l.task_update_status_failed, type: SnackbarType.error);
      } finally {
        _isLoading = false;
      }
    });
  }

  Future<void> deleteTask(Task task, {bool fromUndo = false}) async {
    await _addOperation(() async {
      final taskService = _taskService;
      if (taskService == null) {
        return;
      }

      final prevState = state;
      final snackbar = ref.read(snackbarProvider.notifier);
      final locale = ref.read(settingsViewModelProvider).locale;
      final l = await AppLocalizations.delegate.load(locale);
      state = AsyncValue.data([
        for (final t in state.valueOrNull ?? [])
          if (t.id != task.id) t
      ]);
      snackbar.show(l.task_delete_success(task.title),
          type: SnackbarType.success, onUndo: () async {
        undoDeleteTask(task);
      });

      try {
        await taskService.deleteTask(task.id);
        try {
          final analytics = ref.read(analyticsServiceProvider);
          await analytics.logTask(
            'task_deleted',
            hasDueDate: task.dueDate?.start != null,
            isCompleted: task.isCompleted,
            fromUndo: fromUndo,
          );
          print('Analytics logged');
        } catch (e) {
          print('Analytics error: $e');
        }
      } catch (e) {
        state = prevState;
        snackbar.show(l.task_delete_failed(task.title),
            type: SnackbarType.error);
      }
    });
  }

  Future<void> undoDeleteTask(Task prev) async {
    await _addOperation(() async {
      final taskService = _taskService;
      if (taskService == null) {
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
        final restoredTask = await taskService.undoDeleteTask(prev.id);
        if (restoredTask == null) {
          return;
        }

        state = state.whenData((tasks) {
          return tasks.map((task) {
            if (task.id == prev.id) {
              return restoredTask;
            }
            return task;
          }).toList();
        });

        ref.invalidateSelf();

        try {
          final analytics = ref.read(analyticsServiceProvider);
          await analytics.logTask(
            'task_deleted',
            hasDueDate: prev.dueDate?.start != null,
            isCompleted: prev.isCompleted,
            fromUndo: true,
          );
        } catch (e) {
          print('Analytics error: $e');
        }
      } catch (e) {
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
