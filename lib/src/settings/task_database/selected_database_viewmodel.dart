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
  priority,
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
  final types = switch (type) {
    SettingPropertyType.status => [PropertyType.status, PropertyType.checkbox],
    SettingPropertyType.date => [PropertyType.date],
    SettingPropertyType.priority => [PropertyType.select],
  };

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
    SelectProperty? priority,
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
        status: CompleteStatusProperty.fromJson(taskDatabase.status.toJson()),
        date: taskDatabase.date,
        priority: taskDatabase.priority,
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
        priority: null,
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
    var noPriority = false;
    // s.status, s.date, s.priorityがpropertiesに存在するか精査、なければnullにする
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
    if (properties
        .where((p) =>
            p is SelectProperty &&
            p.id == s.priority?.id &&
            p.name == s.priority?.name)
        .isEmpty) {
      noPriority = true;
    }
    return s.copyWith(
        status: noStatus ? null : s.status,
        date: noDate ? null : s.date,
        priority: noPriority ? null : s.priority);
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
      switch ((type, property)) {
        case (SettingPropertyType.status, StatusProperty p):
          return value.copyWith(
            status: StatusCompleteStatusProperty(
              id: p.id,
              name: p.name,
              status: p.status,
              todoOption: null,
              inProgressOption: null,
              completeOption: null,
            ),
          );
        case (SettingPropertyType.status, CheckboxProperty p):
          return value.copyWith(
            status: CheckboxCompleteStatusProperty(
              id: p.id,
              name: p.name,
              checkbox: p.checkbox,
            ),
          );
        case (SettingPropertyType.date, DateProperty p):
          return value.copyWith(
            date: DateProperty(
              id: p.id,
              name: p.name,
            ),
          );
        case (SettingPropertyType.priority, SelectProperty p):
          return value.copyWith(
            priority: SelectProperty(
              id: p.id,
              name: p.name,
              select: p.select,
            ),
          );
        default:
          return value;
      }
    });
  }

  List<StatusOption> getStatusOptionsByGroup(StatusGroupType groupType) {
    final property = state.value?.status;
    if (property == null || property is! StatusCompleteStatusProperty) {
      return [];
    }
    return property.status.groups
            .where((group) => group.name == groupType.value)
            .firstOrNull
            ?.optionIds
            .map((id) => property.status.options
                .where((option) => option.id == id)
                .first)
            .toList() ??
        [];
  }

  void selectStatusOption(String? optionId, StatusGroupType optionType) {
    if (optionId == null) {
      return;
    }
    state = state.whenData((value) {
      final p = value?.status;
      if (value == null || p is! StatusCompleteStatusProperty) return value;

      final option =
          p.status.options.where((option) => option.id == optionId).firstOrNull;

      return value.copyWith(
        status: switch (optionType) {
          StatusGroupType.todo => p.copyWith(todoOption: option),
          StatusGroupType.complete => p.copyWith(completeOption: option),
          StatusGroupType.inProgress => p.copyWith(inProgressOption: option),
        },
      );
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
      CreatePropertyType.date => '日付', // TODO: ローカライズ
      CreatePropertyType.checkbox => 'チェックボックス',
      CreatePropertyType.select => '優先度',
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
    if (state.hasValue == false) {
      return true;
    }
    final status = state.value?.status;
    if (status == null) {
      return true;
    }
    final statusDisabled = switch (status) {
      StatusCompleteStatusProperty() =>
        status.todoOption == null || status.completeOption == null,
      CheckboxCompleteStatusProperty() => false,
    };
    final dateDisabled = state.value?.date == null;
    return statusDisabled || dateDisabled;
  }
}
