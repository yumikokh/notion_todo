import 'dart:collection';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../l10n/app_localizations.dart';
import '../../common/error.dart';
import '../../common/snackbar/model/snackbar_state.dart';
import '../../common/snackbar/snackbar.dart';
import '../../helpers/date.dart';
import '../../settings/settings_viewmodel.dart';
import '../../settings/task_database/task_database_viewmodel.dart';
import '../common/filter_type.dart';
import '../model/property.dart';
import '../model/task.dart';
import 'task_repository.dart';
import '../../common/analytics/analytics_service.dart';
import '../../common/app_review/app_review_service.dart';
import '../../widget/widget_service.dart';
import '../../common/debounced_state_mixin.dart';

part 'task_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class TaskViewModel extends _$TaskViewModel
    with DebouncedStateMixin<List<Task>> {
  late TaskRepository? _taskRepository;
  late FilterType _filterType;
  late bool _hasCompleted;
  bool _hasMore = false;
  bool get hasMore => _hasMore;
  String? _nextCursor;
  bool _isLoading = false;
  bool _showCompleted = false;
  bool get showCompleted => _showCompleted;

  static final DateHelper d = DateHelper();

  bool get isToday => _filterType == FilterType.today;

  @override
  Future<List<Task>> build({
    FilterType filterType = FilterType.all,
  }) async {
    final taskDatabase = await ref.watch(taskDatabaseViewModelProvider.future);
    _taskRepository = await ref.watch(taskRepositoryProvider.future);

    if (_taskRepository == null || taskDatabase == null) {
      await FlutterAppBadger.removeBadge();
      await _updateTodayWidget([]);
      return [];
    }

    _showCompleted = await _taskRepository!.loadShowCompleted();

    _filterType = filterType;
    // MEMO: ユースケースを鑑みて読み込みは固定にする
    // もしpageSize以上のタスクがあったとき、「showCompleted」と「Load more」の不整合がおきるがいったん無視
    _hasCompleted = filterType == FilterType.today;

    final tasks = await _fetchTasks(isFirstFetch: true);

    if (isToday) {
      final showBadge =
          ref.watch(settingsViewModelProvider).showNotificationBadge;
      _updateBadge(tasks, showBadge);
      _updateTodayWidget(tasks);
    }

    return tasks;
  }

  bool showDueDate(Task task) {
    final dueDate = task.dueDate;
    if (dueDate == null) return false;
    if (dueDate.end != null) return true;
    if (!isToday) return true;
    if (d.isToday(dueDate.start.datetime) && dueDate.start.isAllDay == true) {
      return false;
    }
    return true;
  }

  bool showStarButton(Task task) {
    if (task.status is! TaskStatusStatus) {
      return false;
    }
    return true;
  }

  Future<void> toggleShowCompleted() async {
    _showCompleted = !_showCompleted;
    ref.notifyListeners();
    if (_taskRepository != null) {
      await _taskRepository!.saveShowCompleted(_showCompleted);
    }
    try {
      final analytics = ref.read(analyticsServiceProvider);
      await analytics.logCompletedTasksToggle(
        isVisible: _showCompleted,
        screenName: isToday ? 'Today' : 'All',
      );
    } catch (e) {
      print('Analytics error: $e');
    }
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

  // キューに操作を追加する関数
  Future<void> _addOperation(Future<void> Function() operation) async {
    operation(); // 即時実行するようにする
  }

  Future<List<Task>> _fetchTasks({bool isFirstFetch = false}) async {
    final taskService = _taskRepository;
    if (taskService == null) {
      return [];
    }
    final locale = ref.read(settingsViewModelProvider).locale;
    final l = await AppLocalizations.delegate.load(locale);
    _isLoading = true;

    return await debouncedFetch(() async {
      try {
        final cursor = isFirstFetch ? null : _nextCursor;
        final result = await taskService.fetchTasks(_filterType, _hasCompleted,
            startCursor: cursor);
        _hasMore = result.hasMore;
        _nextCursor = result.nextCursor;
        return result.tasks;
      } catch (e, stackTrace) {
        final snackbar = ref.read(snackbarProvider.notifier);
        final taskDatabaseViewModel =
            ref.read(taskDatabaseViewModelProvider.notifier);
        final analytics = ref.read(analyticsServiceProvider);

        Sentry.captureException(e, stackTrace: stackTrace);

        if (e is NotionErrorException) {
          switch (e) {
            // MEMO: IDベースでリクエストしているため、プロパティが削除されない限り起こらないはず
            case NotionValidationException():
              snackbar.show(l.not_found_property, type: SnackbarType.error);
              break;
            case NotionInvalidException():
              taskDatabaseViewModel.clear();
              snackbar.show("${l.not_found_database} ${l.re_set_database}",
                  type: SnackbarType.error);
              break;
            case NotionUnknownException():
              snackbar.show(l.task_fetch_failed, type: SnackbarType.error);
              break;
          }
          await analytics.logError(
            e.code,
            error: e.message,
            parameters: {'status_code': e.status},
          );
        } else {
          // その他のエラー処理
          snackbar.show(l.task_fetch_failed, type: SnackbarType.error);
          print('Unknown error: $e');
        }

        // TODO: エラー表示をつくったらthrowする。ネットワークがつながらないときなど
        return [];
      } finally {
        _isLoading = false;
      }
    });
  }

  Future<void> addTask(Task tempTask,
      {bool? needSnackbarFloating = false}) async {
    final locale = ref.read(settingsViewModelProvider).locale;
    final l = await AppLocalizations.delegate.load(locale);
    await _addOperation(() async {
      final taskService = _taskRepository;
      if (taskService == null || tempTask.title.trim().isEmpty) {
        return;
      }
      final snackbar = ref.read(snackbarProvider.notifier);
      final analytics = ref.read(analyticsServiceProvider);

      final prevState = state;

      state = AsyncValue.data([...state.valueOrNull ?? [], tempTask]);

      // ウィジェット更新
      if (isToday) {
        await _updateTodayWidget(state.valueOrNull ?? []);
      }

      try {
        final t = await taskService.addTask(tempTask);

        // 最新のstateを使用して更新
        state = state.whenData((tasks) {
          return tasks.map((task) {
            if (task.isTemp) return t;
            return task;
          }).toList();
        });

        snackbar.show(
          l.add_task_success(t.title),
          type: SnackbarType.success,
          onUndo: () {
            deleteTask(t);
          },
          isFloating: needSnackbarFloating ?? false,
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
      final taskService = _taskRepository;
      final prevState = state;
      final prevTask =
          prevState.valueOrNull?.where((t) => t.id == task.id).firstOrNull;
      if (prevTask == null || task.title.trim().isEmpty) {
        return;
      }
      if (taskService == null) {
        return;
      }

      final snackbar = ref.read(snackbarProvider.notifier);
      final locale = ref.read(settingsViewModelProvider).locale;
      final l = await AppLocalizations.delegate.load(locale);

      state = AsyncValue.data([
        for (final t in state.valueOrNull ?? [])
          if (t.id == task.id) task else t
      ]);
      // ウィジェット更新
      if (isToday) {
        await _updateTodayWidget(state.valueOrNull ?? []);
      }

      snackbar.show(l.task_update_success(task.title),
          type: SnackbarType.success, onUndo: () async {
        updateTask(prevTask, fromUndo: true);
      });

      try {
        final updatedTask = await taskService.updateTask(task);

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
      final taskService = _taskRepository;
      if (taskService == null) {
        return;
      }
      final snackbar = ref.read(snackbarProvider.notifier);
      final locale = ref.read(settingsViewModelProvider).locale;
      final l = await AppLocalizations.delegate.load(locale);

      _isLoading = true;
      final prevState = state;

      state = AsyncValue.data([
        for (final t in state.valueOrNull ?? [])
          if (t.id == task.id) task else t
      ]);

      // ウィジェット更新
      if (isToday) {
        await _updateTodayWidget(state.valueOrNull ?? []);
      }

      try {
        final updatedTask =
            await taskService.updateCompleteStatus(task.id, isCompleted);

        snackbar.show(
            isCompleted
                ? l.task_update_status_success(task.title)
                : l.task_update_status_undo(task.title),
            type: SnackbarType.success, onUndo: () async {
          updateCompleteStatus(task, !isCompleted, fromUndo: true);
        });

        state = AsyncValue.data([
          for (final t in state.valueOrNull ?? [])
            if (t.id == updatedTask.id) updatedTask else t
        ]);
        ref.invalidateSelf();

        // 今日のタスクが全て完了したかチェック
        if (!fromUndo && isCompleted && isToday) {
          final tasks = state.valueOrNull ?? [];
          final allTasksCompleted = tasks.every((t) => t.isCompleted);

          if (allTasksCompleted && tasks.isNotEmpty) {
            // showCompletedをオフにする
            if (_taskRepository != null) {
              await _taskRepository!.saveShowCompleted(false);
            }
            // レビューポップアップ
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
        rethrow;
      } finally {
        _isLoading = false;
      }
    });
  }

  Future<void> updateInProgressStatus(Task task, bool willBeInProgress,
      {bool fromUndo = false}) async {
    // checkboxは更新できない
    if (task.status is CheckboxCompleteStatusProperty) {
      return;
    }
    await _addOperation(() async {
      final taskService = _taskRepository;
      if (taskService == null) {
        return;
      }
      final snackbar = ref.read(snackbarProvider.notifier);
      final locale = ref.read(settingsViewModelProvider).locale;
      final l = await AppLocalizations.delegate.load(locale);

      final prevState = state;

      snackbar.show(
          willBeInProgress
              ? l.task_update_status_in_progress(task.title)
              : l.task_update_status_todo(task.title),
          type: SnackbarType.success, onUndo: () async {
        updateInProgressStatus(task, !willBeInProgress, fromUndo: true);
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
    if (task.isTemp) {
      return;
    }
    final taskService = _taskRepository;
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
    // ウィジェット更新
    if (isToday) {
      await _updateTodayWidget(state.valueOrNull ?? []);
    }
    snackbar.show(l.task_delete_success(task.title), type: SnackbarType.success,
        onUndo: () async {
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
      snackbar.show(l.task_delete_failed(task.title), type: SnackbarType.error);
      // 既にNotion上で削除されている場合があるため、stateを更新する
      // 本来はステータスコードで判定したいが、できないため
      ref.invalidateSelf();
    }
  }

  Future<void> undoDeleteTask(Task prev) async {
    await _addOperation(() async {
      final taskService = _taskRepository;
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

  Future<void> _updateBadge(List<Task> tasks, bool showBadge) async {
    if (!showBadge) {
      FlutterAppBadger.removeBadge();
      return;
    }
    final notCompletedCount = tasks.where((task) => !task.isCompleted).length;
    await FlutterAppBadger.updateBadgeCount(notCompletedCount);
  }

  Future<void> _updateTodayWidget(List<Task> tasks) async {
    await WidgetService.applyTasks(tasks);
  }
}
