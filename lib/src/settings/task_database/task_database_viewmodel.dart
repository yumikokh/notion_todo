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
    );
  }

  Future<void> save(SelectedDatabaseState selectedTaskDatabase) async {
    final taskDatabase = TaskDatabase(
        id: selectedTaskDatabase.id,
        name: selectedTaskDatabase.name,
        status: selectedTaskDatabase.status as TaskStatusProperty,
        date: selectedTaskDatabase.date as TaskDateProperty,
        title: selectedTaskDatabase.title);
    state = const AsyncValue.loading();
    try {
      await _taskDatabaseService.save(taskDatabase);
      state = AsyncValue.data(taskDatabase);

      try {
        final analytics = ref.read(analyticsServiceProvider);
        await analytics.logSettingsChanged(
          settingName: 'database',
          value: 'saved',
        );
        await analytics.logSettingsChanged(
          settingName: 'database_status_type',
          value: taskDatabase.status.type == PropertyType.status
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
        await analytics.logSettingsChanged(
          settingName: 'database',
          value: 'cleared',
        );
      } catch (e) {
        print('Analytics error: $e');
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
