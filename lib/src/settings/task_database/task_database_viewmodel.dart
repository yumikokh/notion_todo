import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/analytics/analytics_service.dart';
import '../../notion/model/task_database.dart';
import '../../notion/model/index.dart';
import '../../notion/repository/notion_database_repository.dart';
import 'task_database_service.dart';
import 'selected_database_viewmodel.dart';
import '../../common/debounced_state_mixin.dart';

part 'task_database_viewmodel.g.dart';

@riverpod
class TaskDatabaseViewModel extends _$TaskDatabaseViewModel
    with DebouncedStateMixin<TaskDatabase?> {
  late TaskDatabaseService _taskDatabaseService;

  @override
  Future<TaskDatabase?> build() async {
    if (state.hasValue && !shouldUpdateState()) {
      return state.value!;
    }

    final notionDatabaseRepository =
        await ref.watch(notionDatabaseRepositoryProvider.future);
    _taskDatabaseService =
        TaskDatabaseService(notionDatabaseRepository: notionDatabaseRepository);

    final taskDatabase = await _taskDatabaseService.loadSetting();
    if (taskDatabase == null) return null;
    try {
      final updatedTaskDatabase =
          await _taskDatabaseService.updateDatabaseWithLatestInfo(taskDatabase);
      return updatedTaskDatabase ?? taskDatabase;
    } catch (e) {
      return taskDatabase;
    }
  }

  Future<void> save(SelectedDatabaseState selectedTaskDatabase) async {
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
        priority: selectedTaskDatabase.priority);
    state = const AsyncValue.loading();
    try {
      await _taskDatabaseService.save(taskDatabase);
      state = AsyncValue.data(taskDatabase);

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
    state = const AsyncValue.loading();
    try {
      await _taskDatabaseService.clear();
      state = const AsyncValue.data(null);

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
