import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/task_database.dart';
import '../model/index.dart';
import '../repository/notion_database_repository.dart';
import './task_database_service.dart';

part 'task_database_viewmodel.freezed.dart';
part 'task_database_viewmodel.g.dart';

@freezed
class SelectedDatabase with _$SelectedDatabase {
  const factory SelectedDatabase({
    required String id,
    required String name,
    required List<Property> properties,
    required TaskStatusProperty? status,
    required TaskDateProperty? date,
  }) = _SelectedDatabase;

  factory SelectedDatabase.initial() => const SelectedDatabase(
        id: '',
        name: '',
        properties: [],
        status: null,
        date: null,
      );
}

@freezed
class TaskDatabaseState with _$TaskDatabaseState {
  factory TaskDatabaseState({
    required List<Database> databases,
    required TaskDatabase? taskDatabase,
    required SelectedDatabase? selectedTaskDatabase,
  }) = _TaskDatabaseState;

  factory TaskDatabaseState.initialState() => TaskDatabaseState(
      databases: [], taskDatabase: null, selectedTaskDatabase: null);
}

@riverpod
class TaskDatabaseViewModel extends _$TaskDatabaseViewModel {
  late TaskDatabaseService _taskDatabaseService;

  @override
  Future<TaskDatabaseState> build() async {
    final notionDatabaseRepository =
        ref.watch(notionDatabaseRepositoryProvider);
    if (notionDatabaseRepository == null) {
      return TaskDatabaseState.initialState();
    }

    _taskDatabaseService =
        TaskDatabaseService(notionDatabaseRepository: notionDatabaseRepository);
    final taskDatabase = await _taskDatabaseService.loadSetting();
    return TaskDatabaseState(
      databases: await _taskDatabaseService.fetchDatabases(),
      taskDatabase: taskDatabase,
      selectedTaskDatabase: null,
    );
  }

  Future<void> fetchDatabases() async {
    try {
      final taskDatabases = await _taskDatabaseService.fetchDatabases();
      state.whenData((value) {
        state = AsyncValue.data(value.copyWith(databases: taskDatabases));
      });
      // print('taskDatabase length: ${taskDatabases.length}');
      // final s = state.copyWith(databases: taskDatabases);
      // return taskDatabases;
    } catch (e) {
      print(e);
    }
  }

  void selectDatabase(String? databaseId) {
    state.whenData((value) {
      final selected = value.databases.firstWhere((db) => db.id == databaseId);
      state = AsyncValue.data(value.copyWith(
        selectedTaskDatabase: SelectedDatabase(
          id: databaseId!,
          name: selected.name,
          properties: selected.properties,
          status: null,
          date: null,
        ),
      ));
    });
  }

  List<Property> propertyOptions(SettingPropertyType type) {
    final types = type == SettingPropertyType.status
        ? [PropertyType.status, PropertyType.checkbox]
        : [PropertyType.date];
    return state.value?.selectedTaskDatabase?.properties
            .where((property) => types.contains(property.type))
            .toList() ??
        [];
  }

  void selectProperty(String propertyId, SettingPropertyType type) {
    final property = state.value?.selectedTaskDatabase?.properties
        .firstWhere((property) => property.id == propertyId);

    if (property == null) {
      return;
    }

    state.whenData((value) {
      if (type == SettingPropertyType.status) {
        if (property.type == PropertyType.status) {
          state = AsyncValue.data(value.copyWith(
            selectedTaskDatabase: value.selectedTaskDatabase?.copyWith(
              status: TaskStatusProperty.status(
                  id: property.id,
                  name: property.name,
                  type: property.type,
                  status: (property as StatusProperty).status,
                  todoOption: null,
                  completeOption: null),
            ),
          ));
        }
        if (property.type == PropertyType.checkbox) {
          state = AsyncValue.data(value.copyWith(
            selectedTaskDatabase: value.selectedTaskDatabase?.copyWith(
                status: TaskStatusProperty.checkbox(
              id: property.id,
              name: property.name,
              type: property.type,
              checked: (property as CheckboxProperty).checked,
            )),
          ));
        }
      } else {
        state = AsyncValue.data(
          value.copyWith(
            selectedTaskDatabase: value.selectedTaskDatabase?.copyWith(
                date: TaskDateProperty(
              id: property.id,
              name: property.name,
              type: property.type,
              date: (property as DateProperty).date,
            )),
          ),
        );
      }
    });
  }

  // optionType: 'To-do' or 'Complete'
  void selectOption(String optionId, String optionType) {
    final selectedTaskDatabase = state.value?.selectedTaskDatabase;
    state.whenData((value) {
      if (selectedTaskDatabase == null ||
          selectedTaskDatabase.status == null ||
          (optionType != 'To-do' && optionType != 'Complete')) {
        return;
      }
      final status = selectedTaskDatabase.status as StatusTaskStatusProperty;
      final option =
          status.status.options.firstWhere((option) => option.id == optionId);

      if (optionType == 'To-do') {
        state = AsyncValue.data(value.copyWith(
          selectedTaskDatabase: selectedTaskDatabase.copyWith(
            status: status.copyWith(todoOption: option),
          ),
        ));
      } else {
        state = AsyncValue.data(value.copyWith(
          selectedTaskDatabase: selectedTaskDatabase.copyWith(
            status: status.copyWith(
              completeOption: option,
            ),
          ),
        ));
      }
    });
  }

  void save() {
    state.whenData((value) {
      final selectedTaskDatabase = value.selectedTaskDatabase;
      final status = selectedTaskDatabase?.status;
      final date = selectedTaskDatabase?.date;
      if (selectedTaskDatabase == null || status == null || date == null) {
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
      state = AsyncValue.data(value.copyWith(
        taskDatabase: taskDatabase,
        selectedTaskDatabase: null,
      ));
    });
  }

  void clear() {
    _taskDatabaseService.clear();
    state = AsyncValue.data(TaskDatabaseState.initialState());
  }
}

enum SettingPropertyType {
  status,
  date,
}
