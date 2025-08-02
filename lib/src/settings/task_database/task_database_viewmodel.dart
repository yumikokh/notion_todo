import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/analytics/analytics_service.dart';
import '../../notion/model/task_database.dart';
import '../../notion/model/index.dart';
import '../../notion/tasks/task_database_repository.dart';
import '../../notion/tasks/project_selection_viewmodel.dart';
import 'selected_database_viewmodel.dart';
import '../../common/debounced_state_mixin.dart';

part 'task_database_viewmodel.g.dart';

@riverpod
class TaskDatabaseViewModel extends _$TaskDatabaseViewModel
    with DebouncedStateMixin<TaskDatabase?> {
  late TaskDatabaseRepository? _taskDatabaseRepository;

  @override
  Future<TaskDatabase?> build() async {
    _taskDatabaseRepository =
        await ref.watch(taskDatabaseRepositoryProvider.future);

    return await _getLatestTaskDatabase();
  }

  Future<TaskDatabase?> _getLatestTaskDatabase() async {
    if (_taskDatabaseRepository == null) {
      return null;
    }
    final taskDatabase = await _taskDatabaseRepository!.loadSetting();
    if (taskDatabase == null) return null;
    try {
      final latestTaskDatabase = await debouncedFetch(() async {
        return await _taskDatabaseRepository!
            .updateDatabaseWithLatestInfo(taskDatabase);
      });
      return latestTaskDatabase;
    } catch (e) {
      return taskDatabase;
    }
  }

  Future<void> save(SelectedDatabaseState selectedTaskDatabase) async {
    final repository = _taskDatabaseRepository;
    if (repository == null) {
      return;
    }
    final status = selectedTaskDatabase.status;
    final date = selectedTaskDatabase.date;
    if (status == null || date == null) {
      throw Exception('Status or date is null');
    }
    final taskDatabase = TaskDatabase(
        id: selectedTaskDatabase.id,
        name: selectedTaskDatabase.name,
        status: status,
        date: date,
        title: selectedTaskDatabase.title,
        priority: selectedTaskDatabase.priority,
        project: selectedTaskDatabase.project);

    // 状態の初期化
    state = const AsyncValue.loading();
    try {
      await repository.save(taskDatabase);
      state = AsyncValue.data(taskDatabase);

      // プロジェクト一覧を更新して読み込み完了を待つ
      await ref
          .read(projectSelectionViewModelProvider.notifier)
          .fetchAndUpdateProjects();

      try {
        final analytics = ref.read(analyticsServiceProvider);
        await analytics.logDatabaseOperation(
          action: 'saved',
          statusType: taskDatabase.status is StatusCompleteStatusProperty
              ? 'status'
              : 'checkbox',
        );
      } catch (e) {
        print('Analytics error: $e');
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> clear() async {
    final repository = _taskDatabaseRepository;
    if (repository == null) {
      return;
    }
    state = const AsyncValue.loading();
    try {
      await repository.clear();
      state = const AsyncValue.data(null);

      // プロジェクト選択のキャッシュをクリア
      ref.invalidate(projectSelectionViewModelProvider);

      try {
        final analytics = ref.read(analyticsServiceProvider);
        await analytics.logDatabaseOperation(
          action: 'cleared',
        );
      } catch (e) {
        print('Analytics error: $e');
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
