import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../oauth/notion_oauth_viewmodel.dart';
import '../entity/index.dart';
import './task_database_service.dart';

part 'task_database_viewmodel.freezed.dart';
part 'task_database_viewmodel.g.dart';

@freezed
class TaskDatabaseState with _$TaskDatabaseState {
  factory TaskDatabaseState({
    required List<Database> databases,
    required TaskDatabase? taskDatabase,
    required TaskDatabase? selectedTaskDatabase,
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
    final taskDatabases = await _taskDatabaseService!.fetchDatabases();
    // print('taskDatabase length: ${taskDatabases.length}');
    state = state.copyWith(databases: taskDatabases);
  }

  void selectDatabase(String? databaseId) {
    final selected = state.databases.firstWhere((db) => db.id == databaseId);
    state = state.copyWith(
      selectedTaskDatabase: TaskDatabase(
        id: databaseId!,
        name: selected.name,
        properties: selected.properties,
        statusId: null,
        dateId: null,
      ),
    );
  }

  List<Property> propertyOptions(SettingPropertyType type) {
    final type0 =
        type == SettingPropertyType.status ? ['status', 'checkbox'] : ['date'];
    return state.selectedTaskDatabase?.properties
            .where((property) => type0.contains(property.type))
            .toList() ??
        [];
  }

  void selectProperty(String? propertyId, SettingPropertyType type) {
    if (type == SettingPropertyType.status) {
      state = state.copyWith(
        selectedTaskDatabase:
            state.selectedTaskDatabase?.copyWith(statusId: propertyId),
      );
    } else {
      state = state.copyWith(
        selectedTaskDatabase:
            state.selectedTaskDatabase?.copyWith(dateId: propertyId),
      );
    }
  }

  void save() {
    if (_taskDatabaseService == null || state.selectedTaskDatabase == null) {
      return;
    }
    _taskDatabaseService!.save(state.selectedTaskDatabase!);
    state = state.copyWith(
        taskDatabase: state.selectedTaskDatabase, selectedTaskDatabase: null);
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
