import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../notion/model/index.dart';
import '../../notion/repository/notion_database_repository.dart';
import 'task_database_service.dart';
import 'task_database_viewmodel.dart';

part 'task_database_setting_viewmodel.freezed.dart';
part 'task_database_setting_viewmodel.g.dart';

@riverpod
Future<List<Database>> accessibleDatabases(Ref ref) async {
  final notionDatabaseRepository = ref.watch(notionDatabaseRepositoryProvider);
  final taskDatabaseService =
      TaskDatabaseService(notionDatabaseRepository: notionDatabaseRepository);
  final dbs = await taskDatabaseService.fetchDatabases();
  return dbs;
}

enum SettingPropertyType {
  status,
  date,
}

@freezed
class SelectedDatabaseState with _$SelectedDatabaseState {
  const factory SelectedDatabaseState({
    required String id,
    required String name,
    required List<Property> properties,
    required TaskStatusProperty? status,
    required TaskDateProperty? date,
  }) = _SelectedDatabaseState;
}

@riverpod
class SelectedDatabaseViewModel extends _$SelectedDatabaseViewModel {
  @override
  Future<SelectedDatabaseState?> build() async {
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).valueOrNull;
    final accessibleDatabases = ref.watch(accessibleDatabasesProvider).value;
    final selected = accessibleDatabases
        ?.where((db) => db.id == taskDatabase?.id)
        .firstOrNull;
    if (taskDatabase == null || selected == null) {
      return null;
    }

    return SelectedDatabaseState(
      id: taskDatabase.id,
      name: taskDatabase.name,
      properties: selected.properties,
      status: taskDatabase.status,
      date: taskDatabase.date,
    );
  }

  void selectDatabase(String? databaseId) {
    state = state.whenData((value) {
      final accessibleDatabases = ref.watch(accessibleDatabasesProvider).value;
      final selected =
          accessibleDatabases?.where((db) => db.id == databaseId).firstOrNull;

      if (selected == null) {
        return value;
      }
      return SelectedDatabaseState(
        id: selected.id,
        name: selected.name,
        properties: selected.properties,
        status: null,
        date: null,
      );
    });
  }

  List<Property> propertyOptions(SettingPropertyType type) {
    final types = type == SettingPropertyType.status
        ? [PropertyType.status, PropertyType.checkbox]
        : [PropertyType.date];
    return state.value?.properties
            .where((property) => types.contains(property.type))
            .toList() ??
        [];
  }

  void selectProperty(String? propertyId, SettingPropertyType type) {
    final property = state.value?.properties
        .firstWhere((property) => property.id == propertyId);

    if (property == null) {
      return;
    }

    state = state.whenData((value) {
      if (value == null) {
        return null;
      }
      // Status
      if (type == SettingPropertyType.status) {
        if (property.type == PropertyType.status) {
          return value.copyWith(
            status: TaskStatusProperty.status(
                id: property.id,
                name: property.name,
                type: property.type,
                status: (property as StatusProperty).status,
                todoOption: null,
                completeOption: null),
          );
        }
        // Checkbox
        if (property.type == PropertyType.checkbox) {
          return value.copyWith(
              status: TaskStatusProperty.checkbox(
            id: property.id,
            name: property.name,
            type: property.type,
            checked: (property as CheckboxProperty).checked,
          ));
        }
      }

      // Date
      return value.copyWith(
          date: TaskDateProperty(
        id: property.id,
        name: property.name,
        type: property.type,
        date: (property as DateProperty).date,
      ));
    });
  }

  // optionType: 'To-do' or 'Complete'
  void selectStatusOption(String? optionId, String optionType) {
    state = state.whenData((value) {
      if (value == null ||
          value.status == null ||
          (optionType != 'To-do' && optionType != 'Complete')) {
        return value;
      }

      final status = value.status as StatusTaskStatusProperty;
      final option =
          status.status.options.firstWhere((option) => option.id == optionId);

      if (optionType == 'To-do') {
        return value.copyWith(
          status: status.copyWith(todoOption: option),
        );
      }
      return value.copyWith(
          status: status.copyWith(
        completeOption: option,
      ));
    });
  }

  void clear() {
    state = const AsyncValue.data(null);
  }
}
