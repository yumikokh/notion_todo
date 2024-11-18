import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/task_database.dart';
import '../oauth/notion_oauth_viewmodel.dart';
import '../model/index.dart';
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
  late TaskDatabaseService? _taskDatabaseService;

  @override
  TaskDatabaseState build() {
    _initialize();
    return TaskDatabaseState.initialState();
  }

  _initialize() async {
    final accessToken = ref.watch(notionOAuthViewModelProvider).accessToken;
    if (accessToken == null) {
      return;
    }
    _taskDatabaseService = TaskDatabaseService(accessToken);
    state = TaskDatabaseState(
      databases: [],
      taskDatabase: await _taskDatabaseService!.loadSetting(),
      selectedTaskDatabase: null,
    );
    fetchDatabases();
  }

  Future<void> fetchDatabases() async {
    if (_taskDatabaseService == null) {
      return;
    }
    try {
      final taskDatabases = await _taskDatabaseService!.fetchDatabases();
      // print('taskDatabase length: ${taskDatabases.length}');
      state = state.copyWith(databases: taskDatabases);
    } catch (e) {
      print(e);
    }
  }

  void selectDatabase(String? databaseId) {
    final selected = state.databases.firstWhere((db) => db.id == databaseId);
    state = state.copyWith(
      selectedTaskDatabase: SelectedDatabase(
        id: databaseId!,
        name: selected.name,
        properties: selected.properties,
        status: null,
        date: null,
      ),
    );
  }

  List<Property> propertyOptions(SettingPropertyType type) {
    final types = type == SettingPropertyType.status
        ? [PropertyType.status, PropertyType.checkbox]
        : [PropertyType.date];
    return state.selectedTaskDatabase?.properties
            .where((property) => types.contains(property.type))
            .toList() ??
        [];
  }

  void selectProperty(String propertyId, SettingPropertyType type) {
    final property = state.selectedTaskDatabase?.properties
        .firstWhere((property) => property.id == propertyId);

    if (property == null) {
      return;
    }

    if (type == SettingPropertyType.status) {
      if (property.type == PropertyType.status) {
        state = state.copyWith(
          selectedTaskDatabase: state.selectedTaskDatabase?.copyWith(
            status: TaskStatusProperty.status(
                id: property.id,
                name: property.name,
                type: property.type,
                status: (property as StatusProperty).status,
                todoOption: null,
                completeOption: null),
          ),
        );
      }
      if (property.type == PropertyType.checkbox) {
        state = state.copyWith(
          selectedTaskDatabase: state.selectedTaskDatabase?.copyWith(
              status: TaskStatusProperty.checkbox(
            id: property.id,
            name: property.name,
            type: property.type,
            checked: (property as CheckboxProperty).checked,
          )),
        );
      }
    } else {
      state = state.copyWith(
        selectedTaskDatabase: state.selectedTaskDatabase?.copyWith(
            date: TaskDateProperty(
          id: property.id,
          name: property.name,
          type: property.type,
          date: (property as DateProperty).date,
        )),
      );
    }
  }

  // optionType: 'To-do' or 'Complete'
  void selectOption(String optionId, String optionType) {
    if (state.selectedTaskDatabase == null ||
        state.selectedTaskDatabase?.status == null ||
        (optionType != 'To-do' && optionType != 'Complete')) {
      return;
    }
    final status =
        state.selectedTaskDatabase!.status as StatusTaskStatusProperty;
    final option =
        status.status.options.firstWhere((option) => option.id == optionId);

    if (optionType == 'To-do') {
      state = state.copyWith(
        selectedTaskDatabase: state.selectedTaskDatabase!.copyWith(
          status: status.copyWith(todoOption: option),
        ),
      );
    } else {
      state = state.copyWith(
        selectedTaskDatabase: state.selectedTaskDatabase?.copyWith(
          status: status.copyWith(
            completeOption: option,
          ),
        ),
      );
    }
  }

  void save() {
    if (_taskDatabaseService == null || state.selectedTaskDatabase == null) {
      return;
    }
    final json = state.selectedTaskDatabase!.properties
        .firstWhere((property) => property.type == PropertyType.title)
        .toJson();
    final taskDatabase = TaskDatabase(
        id: state.selectedTaskDatabase!.id,
        name: state.selectedTaskDatabase!.name,
        status: state.selectedTaskDatabase!.status!,
        date: state.selectedTaskDatabase!.date!,
        title: TaskTitleProperty.fromJson(json));
    _taskDatabaseService!.save(taskDatabase);
    state =
        state.copyWith(taskDatabase: taskDatabase, selectedTaskDatabase: null);
  }

  void clear() {
    if (_taskDatabaseService == null) {
      return;
    }
    _taskDatabaseService!.clear();
    state = TaskDatabaseState.initialState();
  }
}

enum SettingPropertyType {
  status,
  date,
}
