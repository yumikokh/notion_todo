import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/analytics/analytics_service.dart';
import '../../notion/model/task_database.dart';
import '../../notion/model/index.dart';
import '../../notion/repository/notion_database_repository.dart';
import 'task_database_service.dart';
import 'selected_database_viewmodel.dart';

part 'task_database_viewmodel.g.dart';

@riverpod
class TaskDatabaseViewModel extends _$TaskDatabaseViewModel {
  late TaskDatabaseService _taskDatabaseService;

  @override
  Future<TaskDatabase?> build() async {
    final notionDatabaseRepository =
        ref.watch(notionDatabaseRepositoryProvider);
    _taskDatabaseService =
        TaskDatabaseService(notionDatabaseRepository: notionDatabaseRepository);

    if (notionDatabaseRepository == null) {
      return null;
    }

    final taskDatabase = await _taskDatabaseService.loadSetting();

    if (taskDatabase == null) {
      return null;
    }

    return TaskDatabase(
      id: taskDatabase.id,
      name: taskDatabase.name,
      status: taskDatabase.status,
      date: taskDatabase.date,
      title: taskDatabase.title,
      priority: taskDatabase.priority,
    );
  }

  Future<void> save(SelectedDatabaseState selectedTaskDatabase) async {
    final taskDatabase = TaskDatabase(
        id: selectedTaskDatabase.id,
        name: selectedTaskDatabase.name,
        status: selectedTaskDatabase.status!, // TODO: !消す
        date: selectedTaskDatabase.date!, // TODO: !消す
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
