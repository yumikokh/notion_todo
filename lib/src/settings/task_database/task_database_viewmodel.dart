import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../notion/model/task_database.dart';
import '../../notion/model/index.dart';
import '../../notion/repository/notion_database_repository.dart';
import 'task_database_service.dart';
import 'task_database_setting_viewmodel.dart';

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

  void save(SelectedDatabaseState selectedTaskDatabase) {
    final status = selectedTaskDatabase.status;
    final date = selectedTaskDatabase.date;
    if (status == null || date == null) {
      return;
    }
    final json = selectedTaskDatabase.properties
        .firstWhere((property) => property.type == PropertyType.title)
        .toJson();
    final taskDatabase = TaskDatabase(
      id: selectedTaskDatabase.id,
      name: selectedTaskDatabase.name,
      status: status,
      date: date,
      title: TaskTitleProperty.fromJson(json),
    );
    _taskDatabaseService.save(taskDatabase);
    state = AsyncValue.data(taskDatabase);
  }

  void clear() {
    _taskDatabaseService.clear();
    state = const AsyncValue.data(null);
  }
}
