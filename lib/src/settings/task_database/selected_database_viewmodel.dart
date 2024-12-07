import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../notion/model/index.dart';
import '../../notion/repository/notion_database_repository.dart';
import 'task_database_service.dart';
import 'task_database_viewmodel.dart';

part 'selected_database_viewmodel.freezed.dart';
part 'selected_database_viewmodel.g.dart';

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
    required TaskTitleProperty title,
    required TaskStatusProperty? status,
    required TaskDateProperty? date,
  }) = _SelectedDatabaseState;
}

@riverpod
class SelectedDatabaseViewModel extends _$SelectedDatabaseViewModel {
  late TaskDatabaseService _taskDatabaseService;

  @override
  Future<SelectedDatabaseState?> build() async {
    final taskDatabase = await ref.watch(taskDatabaseViewModelProvider.future);
    final notionDatabaseRepository =
        ref.watch(notionDatabaseRepositoryProvider);
    _taskDatabaseService =
        TaskDatabaseService(notionDatabaseRepository: notionDatabaseRepository);
    if (state.value != null) {
      return state.value;
    }

    if (taskDatabase == null) {
      return null;
    }

    return SelectedDatabaseState(
      id: taskDatabase.id,
      name: taskDatabase.name,
      title: taskDatabase.title,
      status: taskDatabase.status,
      date: taskDatabase.date,
    );
  }

  void selectDatabase(String? databaseId) {
    state = state.whenData((value) {
      final accessibleDatabases = ref.read(accessibleDatabasesProvider).value;
      final selected =
          accessibleDatabases?.where((db) => db.id == databaseId).firstOrNull;
      final title = selected?.properties
          .where((property) => property.type == PropertyType.title)
          .firstOrNull
          ?.toJson();

      if (selected == null || title == null) {
        return value;
      }

      return SelectedDatabaseState(
        id: selected.id,
        name: selected.name,
        title: TaskTitleProperty.fromJson(title),
        status: null,
        date: null,
      );
    });
  }

  List<Property> get properties {
    final selectedId = state.value?.id;
    if (selectedId == null) {
      return [];
    }
    final selectedDatabase = ref
        .read(accessibleDatabasesProvider)
        .value
        ?.where((db) => db.id == selectedId)
        .firstOrNull;
    return selectedDatabase?.properties ?? [];
  }

  List<Property> Function(SettingPropertyType) get propertyOptions {
    return (SettingPropertyType type) {
      final types = type == SettingPropertyType.status
          ? [PropertyType.status, PropertyType.checkbox]
          : [PropertyType.date];
      return properties
          .where((property) => types.contains(property.type))
          .toList();
    };
  }

  void selectProperty(String? propertyId, SettingPropertyType type) {
    if (propertyId == null) {
      return;
    }
    final property =
        properties.where((property) => property.id == propertyId).firstOrNull;
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
    if (optionId == null) {
      return;
    }
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

  Future<Property> createProperty(CreatePropertyType type, String name) async {
    final databaseId = state.value?.id;
    if (databaseId == null) {
      throw Exception('databaseId is null');
    }
    final property =
        await _taskDatabaseService.createProperty(databaseId, type, name);
    if (property == null) {
      throw Exception('property is null');
    }

    // データベースの再取得
    ref.invalidate(accessibleDatabasesProvider);
    return property;
  }

  void clear() {
    state = const AsyncValue.data(null);
  }
}
