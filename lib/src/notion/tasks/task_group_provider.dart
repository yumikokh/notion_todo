import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';

import '../../settings/task_database/task_database_viewmodel.dart';
import '../common/filter_type.dart';
import '../model/property.dart';
import '../model/task.dart';
import './project_selection_viewmodel.dart';
import 'task_sort_provider.dart';

part 'task_group_provider.g.dart';

// グループタイプの列挙型
enum GroupType {
  none, // グループ化なし（完了済みのみグループ化）
  date, // 日付ごと
  status, // ステータスごと
  priority, // 優先度ごと
  project, // プロジェクトごと
}

// グループタイプの名前を取得する拡張メソッド
extension GroupTypeExtension on GroupType {
  String getLocalizedName(AppLocalizations l) {
    switch (this) {
      case GroupType.none:
        return l.sort_by_default;
      case GroupType.date:
        return l.date_property;
      case GroupType.status:
        return l.status_property;
      case GroupType.priority:
        return l.priority_property;
      case GroupType.project:
        return l.project_property;
    }
  }
}

// SharedPreferences操作用のサービスクラス
class TaskGroupService {
  static const String _groupTypeKeyPrefix = 'group_type_';

  // グループタイプをSharedPreferencesに保存
  Future<void> saveGroupType(FilterType filterType, GroupType groupType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        '$_groupTypeKeyPrefix${filterType.name}', groupType.index);
  }

  // グループタイプをSharedPreferencesから読み込み
  Future<GroupType> loadGroupType(FilterType filterType) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt('$_groupTypeKeyPrefix${filterType.name}');
    if (value != null && value < GroupType.values.length) {
      return GroupType.values[value];
    }
    return _getDefaultGroupType(filterType);
  }

  // フィルタータイプごとのデフォルトグループタイプを取得
  GroupType _getDefaultGroupType(FilterType filterType) {
    // デフォルトは「なし」
    return GroupType.none;
  }
}

// TaskGroupServiceのProviderを定義
@Riverpod(keepAlive: true)
TaskGroupService taskGroupService(Ref ref) {
  return TaskGroupService();
}

// タスクのグループ機能を提供するNotifier
@riverpod
class TaskGroup extends _$TaskGroup {
  late TaskGroupService _groupService;

  @override
  Future<Map<FilterType, GroupType>> build() async {
    _groupService = ref.read(taskGroupServiceProvider);

    // 全てのFilterTypeに対するGroupTypeを読み込む
    final Map<FilterType, GroupType> groupTypes = {};
    for (final type in FilterType.values) {
      groupTypes[type] = await _groupService.loadGroupType(type);
    }

    return groupTypes;
  }

  // 指定したFilterTypeのGroupTypeを取得
  GroupType getGroupType(FilterType filterType) {
    return state.valueOrNull?[filterType] ?? GroupType.none;
  }

  // 指定したFilterTypeのGroupTypeを設定
  Future<void> setGroupType(FilterType filterType, GroupType groupType) async {
    await _groupService.saveGroupType(filterType, groupType);

    // stateを更新
    if (state.hasValue) {
      state = AsyncData({
        ...state.value!,
        filterType: groupType,
      });
    }
  }

  // タスクリストをグループ化する
  Map<String, List<Task>> groupTasks(
      List<Task> tasks, FilterType filterType, bool showCompleted) {
    final groupType = getGroupType(filterType);
    final taskDatabaseViewModel =
        ref.read(taskDatabaseViewModelProvider).valueOrNull;

    // 結果を格納するマップ（順序を保持するためLinkedHashMapを使用）
    Map<String, List<Task>> groupedTasks = {};

    // GroupType.none では完了/未完了でタスクを分ける
    if (groupType == GroupType.none) {
      final notCompletedTasks =
          tasks.where((task) => !task.isCompleted).toList();
      final completedTasks = tasks.where((task) => task.isCompleted).toList();

      groupedTasks['not_completed'] =
          _sortTasksInGroup(notCompletedTasks, filterType, showCompleted);
      if (completedTasks.isNotEmpty) {
        groupedTasks['completed'] =
            _sortTasksInGroup(completedTasks, filterType, showCompleted);
      }

      return groupedTasks;
    }

    // 以下、グループ化する場合の処理（日付、ステータス、優先度）
    switch (groupType) {
      case GroupType.date:
        // 日付ごとにグループ化
        final unsortedGroups = <String, List<Task>>{};

        for (final task in tasks) {
          if (task.dueDate != null) {
            final dateKey = task.dueDate!.start.datetime
                .toLocal()
                .toIso8601String()
                .split('T')[0];
            unsortedGroups.putIfAbsent(dateKey, () => []);
            unsortedGroups[dateKey]!.add(task);
          } else {
            // 日付なしのタスク
            unsortedGroups.putIfAbsent('no_date', () => []);
            unsortedGroups['no_date']!.add(task);
          }
        }

        // 各グループをソートして追加
        final entries = unsortedGroups.entries.toList();

        // 日付キーで昇順ソート（no_dateは最後に）
        entries.sort((a, b) {
          if (a.key == 'no_date') return 1;
          if (b.key == 'no_date') return -1;
          return a.key.compareTo(b.key);
        });

        // 各グループ内のタスクをソート
        for (final entry in entries) {
          groupedTasks[entry.key] =
              _sortTasksInGroup(entry.value, filterType, showCompleted);
        }

        return groupedTasks;

      case GroupType.status:
        // ステータスごとにグループ化
        final unsortedGroups = <String, List<Task>>{};

        switch (taskDatabaseViewModel?.status) {
          case StatusProperty status:
            try {
              final statusProperty = status;

              // StatusPropertyからオプションとグループを取得
              final options = statusProperty.status.options;
              final groups = statusProperty.status.groups;

              // StatusGroupTypeの順序に対応するマップ
              final groupOrderMap = {
                StatusGroupType.todo.value: 1,
                StatusGroupType.inProgress.value: 2,
                StatusGroupType.complete.value: 3,
                "": 4, // グループに属さないオプション用
              };

              // オプションID、グループID、名前のマッピングのリストを作成
              List<(String, String, String)> optionMappings = [];

              for (final option in options) {
                // オプションが属するグループを探す
                String groupName = "";
                for (final group in groups) {
                  if (group.optionIds.contains(option.id)) {
                    groupName = group.name;
                    break;
                  }
                }

                optionMappings.add((option.id, groupName, option.name));
              }

              // 1. グループ順、2. オプション名で並び替え
              optionMappings.sort((a, b) {
                // まずグループ順で比較
                final groupOrderA = groupOrderMap[a.$2] ?? 4;
                final groupOrderB = groupOrderMap[b.$2] ?? 4;

                if (groupOrderA != groupOrderB) {
                  return groupOrderA.compareTo(groupOrderB);
                }

                // 同じグループ内ではオプション名で比較
                return a.$3.toLowerCase().compareTo(b.$3.toLowerCase());
              });

              // ステータスなしタスクを追加
              final noStatusTasks = tasks.where((task) {
                if (task.status is TaskStatusStatus) {
                  final statusTask = task.status as TaskStatusStatus;
                  return statusTask.option == null;
                }
                return task.status is TaskStatusCheckbox;
              }).toList();

              if (noStatusTasks.isNotEmpty) {
                unsortedGroups['no_status'] = noStatusTasks;
              }

              // ソートされた順序でグループ化
              for (final mapping in optionMappings) {
                final optionId = mapping.$1;

                final taskList = tasks.where((task) {
                  if (task.status is TaskStatusStatus) {
                    final statusTask = task.status as TaskStatusStatus;
                    return statusTask.option?.id == optionId;
                  }
                  return false;
                }).toList();

                if (taskList.isNotEmpty) {
                  unsortedGroups[optionId] = taskList;
                }
              }

              // 各グループ内のタスクをソート
              for (final entry in unsortedGroups.entries) {
                groupedTasks[entry.key] =
                    _sortTasksInGroup(entry.value, filterType, showCompleted);
              }

              return groupedTasks;
            } catch (e) {
              // エラー発生時は単純な完了/未完了グループに分ける
              return _fallbackGrouping(tasks, filterType);
            }
          case CheckboxCompleteStatusProperty _:
          case null:
            // Checkboxプロパティの場合、フォールバックグループ化を使用
            return _fallbackGrouping(tasks, filterType);
        }
      case GroupType.priority:
        // 優先度ごとにグループ化
        final unsortedGroups = <String, List<Task>>{};

        // すべてのタスクをグループ化
        for (final task in tasks) {
          if (task.priority != null) {
            final priorityKey = task.priority!.id;
            unsortedGroups.putIfAbsent(priorityKey, () => []);
            unsortedGroups[priorityKey]!.add(task);
          } else {
            // 優先度なしのタスク
            unsortedGroups.putIfAbsent('no_priority', () => []);
            unsortedGroups['no_priority']!.add(task);
          }
        }

        // 優先度名でソート
        if (taskDatabaseViewModel?.priority != null) {
          try {
            final priorityProperty = taskDatabaseViewModel!.priority!;
            final priorityOptions = priorityProperty.select.options;

            // 優先度IDから名前へのマッピングを作成
            final priorityNameMap = {
              for (var option in priorityOptions) option.id: option.name
            };

            // グループエントリをソート
            final entries = unsortedGroups.entries.toList();
            entries.sort((a, b) {
              // no_priorityは最後に
              if (a.key == 'no_priority') return 1;
              if (b.key == 'no_priority') return -1;

              // 優先度名で比較
              final nameA = priorityNameMap[a.key] ?? '';
              final nameB = priorityNameMap[b.key] ?? '';
              return nameA.toLowerCase().compareTo(nameB.toLowerCase());
            });

            // ソートされた順序で追加
            for (final entry in entries) {
              groupedTasks[entry.key] =
                  _sortTasksInGroup(entry.value, filterType, showCompleted);
            }

            return groupedTasks;
          } catch (e) {
            // エラー時は通常の処理を続行
          }
        }

        // 各グループ内のタスクをソート（通常処理）
        for (final entry in unsortedGroups.entries) {
          groupedTasks[entry.key] =
              _sortTasksInGroup(entry.value, filterType, showCompleted);
        }

        return groupedTasks;

      case GroupType.project:
        // プロジェクトごとにグループ化
        final unsortedGroups = <String, List<Task>>{};

        // すべてのタスクをグループ化
        for (final task in tasks) {
          if (task.projects != null && task.projects!.isNotEmpty) {
            // 複数のプロジェクトを持つ場合、それぞれのプロジェクトグループに追加
            for (final project in task.projects!) {
              final projectKey = project.id;
              unsortedGroups.putIfAbsent(projectKey, () => []);
              unsortedGroups[projectKey]!.add(task);
            }
          } else {
            // プロジェクトなしのタスク
            unsortedGroups.putIfAbsent('no_project', () => []);
            unsortedGroups['no_project']!.add(task);
          }
        }

        // プロジェクト名でソート
        if (taskDatabaseViewModel?.project != null) {
          try {
            // プロジェクト情報を取得
            final projectsAsync = ref.read(projectSelectionViewModelProvider);
            final projects = projectsAsync.valueOrNull ?? [];

            // プロジェクトIDから名前へのマップを作成
            final projectNameMap = <String, String>{};
            for (final project in projects) {
              if (project.title != null) {
                projectNameMap[project.id] = project.title!;
              }
            }

            // グループエントリをソート
            final entries = unsortedGroups.entries.toList();
            entries.sort((a, b) {
              // no_projectは最後に
              if (a.key == 'no_project') return 1;
              if (b.key == 'no_project') return -1;

              // プロジェクト名で比較
              final nameA = projectNameMap[a.key] ?? '';
              final nameB = projectNameMap[b.key] ?? '';
              return nameA.toLowerCase().compareTo(nameB.toLowerCase());
            });

            // ソートされた順序で追加
            for (final entry in entries) {
              groupedTasks[entry.key] =
                  _sortTasksInGroup(entry.value, filterType, showCompleted);
            }

            return groupedTasks;
          } catch (e) {
            // エラー時は通常の処理を続行
          }
        }

        // 各グループ内のタスクをソート（通常処理）
        for (final entry in unsortedGroups.entries) {
          groupedTasks[entry.key] =
              _sortTasksInGroup(entry.value, filterType, showCompleted);
        }

        return groupedTasks;

      default:
        return _fallbackGrouping(tasks, filterType);
    }
  }

  // グループ内のタスクをソートする
  List<Task> _sortTasksInGroup(
      List<Task> tasks, FilterType filterType, bool showCompleted) {
    if (tasks.isEmpty) return tasks;

    // タスクを完了/未完了で分ける
    final notCompletedTasks = tasks.where((t) => !t.isCompleted).toList();
    final completedTasks = tasks.where((t) => t.isCompleted).toList();

    // 未完了タスクがない場合は空リストを返す
    if (notCompletedTasks.isEmpty && !showCompleted) return [];

    // 現在のソートタイプを取得
    final taskSortNotifier = ref.read(taskSortProvider.notifier);

    // それぞれのグループをソート
    final sortedNotCompletedTasks =
        taskSortNotifier.sortTasks(notCompletedTasks, filterType);
    final sortedCompletedTasks =
        taskSortNotifier.sortTasks(completedTasks, filterType);

    // 未完了→完了の順で結合
    return [...sortedNotCompletedTasks, ...sortedCompletedTasks];
  }

  // フォールバックグループ化（エラー時や特殊な場合のフォールバック）
  Map<String, List<Task>> _fallbackGrouping(
      List<Task> tasks, FilterType filterType) {
    final notCompletedTasks = tasks.where((task) => !task.isCompleted).toList();
    final completedTasks = tasks.where((task) => task.isCompleted).toList();

    final taskSortNotifier = ref.read(taskSortProvider.notifier);

    final Map<String, List<Task>> result = {};
    if (notCompletedTasks.isNotEmpty) {
      // 未完了タスクと完了タスクを結合（「未完了」グループには完了タスクは含めない）
      result['not_completed'] =
          taskSortNotifier.sortTasks(notCompletedTasks, filterType);
    }
    if (completedTasks.isNotEmpty) {
      // 「完了」専用グループ
      result['completed'] =
          taskSortNotifier.sortTasks(completedTasks, filterType);
    }

    return result;
  }
}

// 現在選択されているグループタイプを取得するProvider
@riverpod
GroupType currentGroupType(Ref ref, FilterType filterType) {
  final groupState = ref.watch(taskGroupProvider);
  return groupState.valueOrNull?[filterType] ?? GroupType.none;
}

/// グループの展開状態を管理するプロバイダー
final expandedGroupsProvider = StateNotifierProvider.family<
    ExpandedGroupsNotifier, Map<String, bool>, String>(
  (ref, key) => ExpandedGroupsNotifier(key),
);

/// 「完了タスク」セクションの展開状態を管理するプロバイダー
final completedTasksSectionExpandedProvider = StateNotifierProvider.family<
    CompletedTasksExpandedNotifier, bool, FilterType>(
  (ref, filterType) => CompletedTasksExpandedNotifier(filterType.name),
);

/// グループの展開状態を管理するStateNotifier
class ExpandedGroupsNotifier extends StateNotifier<Map<String, bool>> {
  final String _storageKey;
  bool _isInitialized = false;

  ExpandedGroupsNotifier(this._storageKey) : super({}) {
    _loadState();
  }

  Future<void> _loadState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedState = prefs.getString('expanded_groups_$_storageKey');

      if (savedState != null) {
        try {
          final Map<String, dynamic> decoded = jsonDecode(savedState);
          final Map<String, bool> typedState =
              decoded.map((key, value) => MapEntry(key, value as bool));
          state = typedState;
        } catch (e) {
          debugPrint('Failed to parse expanded groups state: $e');
          state = {};
        }
      }
      _isInitialized = true;
    } catch (e) {
      debugPrint('Failed to load expanded groups state: $e');
      _isInitialized = true;
      state = {};
    }
  }

  Future<void> _saveState() async {
    if (!_isInitialized) {
      debugPrint('Skipping save because state is not initialized yet');
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('expanded_groups_$_storageKey', jsonEncode(state));
    } catch (e) {
      debugPrint('Failed to save expanded groups state: $e');
    }
  }

  // グループの展開状態を取得（存在しない場合はデフォルトでtrue）
  bool isExpanded(String groupId) {
    return state[groupId] ?? true;
  }

  void toggleGroup(String groupId) {
    if (!_isInitialized) {
      debugPrint('Skipping toggle because state is not initialized yet');
      return;
    }

    try {
      final isExpanded = state[groupId] ?? true;
      final newState = Map<String, bool>.from(state);
      newState[groupId] = !isExpanded;
      state = newState;
      _saveState();
    } catch (e) {
      debugPrint('Error toggling group: $e');
    }
  }

  void setGroupExpanded(String groupId, bool expanded) {
    if (!_isInitialized) {
      debugPrint(
          'Skipping setGroupExpanded because state is not initialized yet');
      return;
    }

    try {
      // 現在の値と同じなら何もしない
      if ((state[groupId] ?? true) == expanded) {
        return;
      }

      final newState = Map<String, bool>.from(state);
      newState[groupId] = expanded;
      state = newState;
      _saveState();
    } catch (e) {
      debugPrint('Error setting group expanded: $e');
    }
  }

  void updateGroups(Map<String, bool> updatedGroups) {
    if (!_isInitialized) {
      debugPrint('Skipping updateGroups because state is not initialized yet');
      return;
    }

    try {
      // 変更がなければ何もしない
      if (mapEquals(state, updatedGroups)) {
        return;
      }

      state = Map<String, bool>.from(updatedGroups);
      _saveState();
    } catch (e) {
      debugPrint('Error updating groups: $e');
    }
  }
}

/// 完了タスクセクションの展開状態を管理するStateNotifier
class CompletedTasksExpandedNotifier extends StateNotifier<bool> {
  final String _filterType;
  bool _isInitialized = false;

  CompletedTasksExpandedNotifier(this._filterType) : super(true) {
    _loadState();
  }

  Future<void> _loadState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedState = prefs.getBool('completed_tasks_expanded_$_filterType');

      if (savedState != null) {
        state = savedState;
      }
      _isInitialized = true;
    } catch (e) {
      debugPrint('Failed to load completed tasks expanded state: $e');
      _isInitialized = true;
    }
  }

  Future<void> _saveState() async {
    if (!_isInitialized) {
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('completed_tasks_expanded_$_filterType', state);
    } catch (e) {
      debugPrint('Failed to save completed tasks expanded state: $e');
    }
  }

  void toggle() {
    if (!_isInitialized) {
      return;
    }

    state = !state;
    _saveState();
  }
}
