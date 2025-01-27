import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/snackbar/model/snackbar_state.dart';
import '../../common/snackbar/snackbar.dart';
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

@riverpod
Future<List<Property>> properties(
  Ref ref,
  SettingPropertyType type,
) async {
  final selectedState =
      await ref.watch(selectedDatabaseViewModelProvider.future);
  final selectedId = selectedState?.id;
  if (selectedId == null) {
    return [];
  }
  final accessibleDatabases =
      await ref.watch(accessibleDatabasesProvider.future);
  final selectedDatabase =
      accessibleDatabases.where((db) => db.id == selectedId).firstOrNull;
  final properties = selectedDatabase?.properties ?? [];
  final types = type == SettingPropertyType.status
      ? [PropertyType.status, PropertyType.checkbox]
      : [PropertyType.date];

  // ignore: invalid_use_of_protected_member
  return properties.where((property) => types.contains(property.type)).toList();
}

@freezed
class SelectedDatabaseState with _$SelectedDatabaseState {
  const factory SelectedDatabaseState({
    required String id,
    required String name,
    required TitleProperty title,
    required CompleteStatusProperty? status,
    required DateProperty? date,
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
      return await _removeNoExistsProperties(state.value?.id, state.value);
    }

    if (taskDatabase == null) {
      return null;
    }

    return await _removeNoExistsProperties(
      taskDatabase.id,
      SelectedDatabaseState(
        id: taskDatabase.id,
        name: taskDatabase.name,
        title: taskDatabase.title,
        status: taskDatabase.status,
        date: taskDatabase.date,
      ),
    );
  }

  void selectDatabase(String? databaseId) {
    state = state.whenData((value) {
      final accessibleDatabases = ref.read(accessibleDatabasesProvider).value;
      final selected =
          accessibleDatabases?.where((db) => db.id == databaseId).firstOrNull;
      final title = selected?.properties.whereType<TitleProperty>().firstOrNull;

      if (selected == null || title == null) {
        return value;
      }

      return SelectedDatabaseState(
        id: selected.id,
        name: selected.name,
        title: title,
        status: null,
        date: null,
      );
    });
  }

  Future<SelectedDatabaseState?> _removeNoExistsProperties(
      String? selectedId, SelectedDatabaseState? state) async {
    if (selectedId == null) {
      return null;
    }
    final accessibleDatabases =
        await ref.watch(accessibleDatabasesProvider.future);
    final selectedDatabase =
        accessibleDatabases.where((db) => db.id == selectedId).firstOrNull;
    final properties = selectedDatabase?.properties ?? [];
    final s = state;
    if (s == null) return null;
    var noStatus = false;
    var noDate = false;
    // s.status, s.dateがpropertiesに存在するか精査、なければnullにする
    if (properties
        .where((p) =>
            p.id == s.status?.id &&
            p.name == s.status?.name &&
            (p is StatusProperty || p is CheckboxProperty))
        .isEmpty) {
      noStatus = true;
    }
    if (properties
        .where((p) =>
            p is DateProperty && p.id == s.date?.id && p.name == s.date?.name)
        .isEmpty) {
      noDate = true;
    }
    return s.copyWith(
        status: noStatus ? null : s.status, date: noDate ? null : s.date);
  }

  void selectProperty(String? propertyId, SettingPropertyType type) async {
    if (propertyId == null) {
      return;
    }
    final properties = await ref.read(propertiesProvider(type).future);
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
        final statusProperty = property;
        switch (statusProperty) {
          case StatusProperty():
            return value.copyWith(
              status: CompleteStatusProperty.status(
                id: property.id,
                name: property.name,
                status: statusProperty.status,
                todoOption: null,
                completeOption: null,
              ),
            );
          case CheckboxProperty():
            return value.copyWith(
                status: CompleteStatusProperty.checkbox(
              id: property.id,
              name: property.name,
              checked: statusProperty.checked,
            ));
          default:
            return value;
        }
      }

      // Date
      return value.copyWith(
          date: DateProperty(
        id: property.id,
        name: property.name,
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
      final status = value.status;
      if (status is! StatusCompleteStatusProperty) {
        return value;
      }

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

    final snackbar = ref.read(snackbarProvider.notifier);
    final propertyName = switch (type) {
      CreatePropertyType.date => '日付',
      CreatePropertyType.checkbox => 'チェックボックス',
    };
    snackbar.show('$propertyNameプロパティ「$name」を追加しました',
        type: SnackbarType.success);

    // データベースの再取得
    ref.invalidate(accessibleDatabasesProvider);
    return property;
  }

  Future<bool> checkPropertyExists(String propertyName) async {
    final selectedId = state.value?.id;
    if (selectedId == null) {
      return false;
    }
    final accessibleDatabases =
        await ref.watch(accessibleDatabasesProvider.future);
    final selectedDatabase =
        accessibleDatabases.where((db) => db.id == selectedId).firstOrNull;
    final properties = selectedDatabase?.properties ?? [];
    return properties.any((property) => property.name == propertyName.trim());
  }

  void clear() {
    state = const AsyncValue.data(null);
  }

  bool get submitDisabled {
    final status = state.value?.status;
    if (status == null) {
      return true;
    }
    switch (status) {
      case StatusCompleteStatusProperty():
        return status.todoOption == null || status.completeOption == null;
      case CheckboxCompleteStatusProperty():
        return false;
    }
  }
}
