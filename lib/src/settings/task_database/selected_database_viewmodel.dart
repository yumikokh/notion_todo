import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';

import '../../common/snackbar/model/snackbar_state.dart';
import '../../common/snackbar/snackbar.dart';
import '../../notion/model/index.dart';
import '../../notion/api/notion_database_api.dart';
import '../../notion/tasks/task_database_repository.dart';
import '../../settings/settings_viewmodel.dart';
import 'task_database_viewmodel.dart';

part 'selected_database_viewmodel.freezed.dart';
part 'selected_database_viewmodel.g.dart';

@riverpod
Future<List<Database>> accessibleDatabases(Ref ref) async {
  final taskDatabaseRepository =
      await ref.watch(taskDatabaseRepositoryProvider.future);
  if (taskDatabaseRepository == null) {
    return [];
  }
  final dbs = await taskDatabaseRepository.fetchAccessibleDatabases();
  return dbs;
}

enum SettingPropertyType {
  status,
  date,
  priority,
  project,
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
    SettingPropertyType.project => [PropertyType.relation],
  };

  return properties.where((property) => types.contains(property.type)).toList();
}

@freezed
abstract class SelectedDatabaseState with _$SelectedDatabaseState {
  const factory SelectedDatabaseState({
    required String id,
    required String name,
    required TitleProperty title,
    required CompleteStatusProperty? status,
    required DateProperty? date,
    SelectProperty? priority,
    RelationProperty? project,
  }) = _SelectedDatabaseState;
}

@riverpod
class SelectedDatabaseViewModel extends _$SelectedDatabaseViewModel {
  late TaskDatabaseRepository? _taskDatabaseRepository;

  @override
  Future<SelectedDatabaseState?> build() async {
    final taskDatabase = await ref.watch(taskDatabaseViewModelProvider.future);
    _taskDatabaseRepository =
        await ref.watch(taskDatabaseRepositoryProvider.future);
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
        project: taskDatabase.project,
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

      // 各プロパティを自動検出して初期値を設定
      final statusWithDefaults = _detectStatusProperty(selected.properties);
      final dateProperty = _detectDateProperty(selected.properties);
      final priorityProperty =
          _detectSelectProperty(selected.properties, ['優先度', 'priority']);
      final projectProperty =
          _detectRelationProperty(selected.properties, ['プロジェクト', 'project']);

      return SelectedDatabaseState(
        id: selected.id,
        name: selected.name,
        title: title,
        status: statusWithDefaults,
        date: dateProperty,
        priority: priorityProperty,
        project: projectProperty,
      );
    });
  }

  /// Statusプロパティを検出して初期値を設定
  CompleteStatusProperty? _detectStatusProperty(List<Property> properties) {
    final statusProperty = properties.whereType<StatusProperty>().firstOrNull;
    if (statusProperty != null) {
      return _createStatusWithDefaults(statusProperty);
    }

    final checkboxProperty =
        properties.whereType<CheckboxProperty>().firstOrNull;
    if (checkboxProperty != null) {
      return CheckboxCompleteStatusProperty(
        id: checkboxProperty.id,
        name: checkboxProperty.name,
        checkbox: checkboxProperty.checkbox,
      );
    }

    return null;
  }

  /// StatusPropertyから初期値付きのStatusCompleteStatusPropertyを作成
  StatusCompleteStatusProperty _createStatusWithDefaults(
      StatusProperty statusProperty) {
    final todoOptions =
        _getStatusOptionsByGroup(statusProperty, StatusGroupType.todo);
    final inProgressOptions =
        _getStatusOptionsByGroup(statusProperty, StatusGroupType.inProgress);
    final completeOptions =
        _getStatusOptionsByGroup(statusProperty, StatusGroupType.complete);

    return StatusCompleteStatusProperty(
      id: statusProperty.id,
      name: statusProperty.name,
      status: statusProperty.status,
      todoOption: todoOptions.isNotEmpty ? todoOptions.first : null,
      inProgressOption:
          inProgressOptions.isNotEmpty ? inProgressOptions.first : null,
      completeOption: completeOptions.isNotEmpty ? completeOptions.first : null,
    );
  }

  /// 特定のグループのStatusオプションを取得
  List<StatusOption> _getStatusOptionsByGroup(
      StatusProperty statusProperty, StatusGroupType groupType) {
    return statusProperty.status.groups
            .where((group) =>
                group.name.toLowerCase() == groupType.value.toLowerCase())
            .firstOrNull
            ?.optionIds
            .map((id) => statusProperty.status.options
                .where((option) => option.id == id)
                .firstOrNull)
            .whereType<StatusOption>()
            .toList() ??
        [];
  }

  /// Dateプロパティを検出
  DateProperty? _detectDateProperty(List<Property> properties) {
    return properties.whereType<DateProperty>().firstOrNull;
  }

  /// Selectプロパティを検出（名前に基づいて推測）
  SelectProperty? _detectSelectProperty(
      List<Property> properties, List<String>? names) {
    final selectProperties = properties.whereType<SelectProperty>();
    return selectProperties
            .where((p) =>
                names?.any((name) => p.name.toLowerCase().contains(name)) ??
                false)
            .firstOrNull ??
        selectProperties.firstOrNull;
  }

  /// Relationプロパティを検出（名前に基づいて推測）
  RelationProperty? _detectRelationProperty(
      List<Property> properties, List<String>? names) {
    final relationProperties = properties.whereType<RelationProperty>();
    return relationProperties
            .where((p) =>
                names?.any((name) => p.name.toLowerCase().contains(name)) ??
                false)
            .firstOrNull ??
        relationProperties.firstOrNull;
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
    bool noProject = false;
    if (s.project != null &&
        properties
            .where((p) =>
                p is RelationProperty &&
                p.id == s.project?.id &&
                p.name == s.project?.name)
            .isEmpty) {
      noProject = true;
    }
    return s.copyWith(
        status: noStatus ? null : s.status,
        date: noDate ? null : s.date,
        priority: noPriority ? null : s.priority,
        project: noProject ? null : s.project);
  }

  void selectProperty(String? propertyId, SettingPropertyType type) async {
    // propertyIdがnullの場合は、未選択状態を設定
    if (propertyId == null) {
      state = state.whenData((value) {
        if (value == null) return null;

        return switch (type) {
          SettingPropertyType.status => value.copyWith(status: null),
          SettingPropertyType.date => value.copyWith(date: null),
          SettingPropertyType.priority => value.copyWith(priority: null),
          SettingPropertyType.project => value.copyWith(project: null),
        };
      });
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
          return value.copyWith(status: _createStatusWithDefaults(p));
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
        case (SettingPropertyType.project, RelationProperty p):
          return value.copyWith(
            project: RelationProperty(
              id: p.id,
              name: p.name,
              relation: p.relation,
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
            .where((group) =>
                group.name.toLowerCase() == groupType.value.toLowerCase())
            .firstOrNull
            ?.optionIds
            .map((id) => property.status.options
                .where((option) => option.id == id)
                .firstOrNull)
            .whereType<StatusOption>()
            .toList() ??
        [];
  }

  void selectStatusOption(String? optionId, StatusGroupType optionType) {
    state = state.whenData((value) {
      final p = value?.status;
      if (value == null || p is! StatusCompleteStatusProperty) return value;

      // optionIdがnullの場合は、未設定を選択したとして処理
      final option = optionId == null
          ? null
          : p.status.options
              .where((option) => option.id == optionId)
              .firstOrNull;

      return value.copyWith(
        status: switch (optionType) {
          StatusGroupType.todo => p.copyWith(todoOption: option),
          StatusGroupType.complete => p.copyWith(completeOption: option),
          StatusGroupType.inProgress =>
            p.copyWith(inProgressOption: () => option),
        },
      );
    });
  }

  Future<Property> createProperty(CreatePropertyType type, String name) async {
    final databaseId = state.value?.id;
    final repository = _taskDatabaseRepository;
    if (databaseId == null || repository == null) {
      throw Exception('databaseId or repository is null');
    }
    final property = await repository.createProperty(databaseId, type, name);
    if (property == null) {
      throw Exception('property is null');
    }

    final snackbar = ref.read(snackbarProvider.notifier);
    final locale = ref.read(settingsViewModelProvider).locale;
    final l = await AppLocalizations.delegate.load(locale);
    final propertyName = switch (type) {
      CreatePropertyType.date => l.date_property,
      CreatePropertyType.checkbox => l.checkbox_property,
      CreatePropertyType.select => l.priority_property,
    };
    snackbar.show(l.property_added_success(propertyName, name),
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
