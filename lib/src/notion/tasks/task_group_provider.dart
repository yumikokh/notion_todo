import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../settings/task_database/task_database_viewmodel.dart';
import '../common/filter_type.dart';
import '../model/property.dart';
import '../model/task.dart';
import 'task_sort_provider.dart';

part 'task_group_provider.g.dart';

// グループタイプの列挙型
enum GroupType {
  none, // グループ化なし（完了済みのみグループ化）
  date, // 日付ごと
  status, // ステータスごと
  priority, // 優先度ごと
}

// グループタイプの名前を取得する拡張メソッド
extension GroupTypeExtension on GroupType {
  String getLocalizedName(AppLocalizations l) {
    switch (this) {
      case GroupType.none:
        return l.group_by_none;
      case GroupType.date:
        return l.date_property;
      case GroupType.status:
        return l.status_property;
      case GroupType.priority:
        return l.priority_property;
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
  Map<String, List<Task>> groupTasks(List<Task> tasks, FilterType filterType) {
    final groupType = getGroupType(filterType);
    final taskDatabaseViewModel =
        ref.read(taskDatabaseViewModelProvider).valueOrNull;

    // 結果を格納するマップ（順序を保持するためLinkedHashMapを使用）
    Map<String, List<Task>> groupedTasks = {};

    switch (groupType) {
      case GroupType.date:
        // 日付ごとにグループ化
        final unsortedGroups = <String, List<Task>>{};
        final noDateTasks = <Task>[];

        for (final task in tasks) {
          if (task.dueDate != null) {
            final dateKey = task.dueDate!.start.datetime
                .toLocal()
                .toIso8601String()
                .split('T')[0];
            unsortedGroups.putIfAbsent(dateKey, () => []);
            unsortedGroups[dateKey]!.add(task);
          } else {
            noDateTasks.add(task);
          }
        }

        // 各グループをソートして追加
        final entries = unsortedGroups.entries.toList();

        // 日付キーで昇順ソート
        entries.sort((a, b) => a.key.compareTo(b.key));

        // 各グループ内のタスクをソート
        for (final entry in entries) {
          groupedTasks[entry.key] = _sortTasksInGroup(entry.value, filterType);
        }

        // 日付なしのタスクは「未設定」グループに (最後に追加)
        if (noDateTasks.isNotEmpty) {
          groupedTasks['no_date'] = _sortTasksInGroup(noDateTasks, filterType);
        }

        return groupedTasks;

      case GroupType.status:
        // ステータスごとにグループ化
        final unsortedGroups = <String, List<Task>>{};

        if (taskDatabaseViewModel?.status is StatusProperty) {
          try {
            final statusProperty =
                taskDatabaseViewModel!.status as StatusProperty;

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

            // ステータスが設定されていないタスク
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

            // 各グループ内のタスクをソート
            for (final entry in unsortedGroups.entries) {
              groupedTasks[entry.key] =
                  _sortTasksInGroup(entry.value, filterType);
            }

            return groupedTasks;
          } catch (e) {
            // エラー発生時はデフォルトの完了/未完了グループに分ける
            final notCompletedTasks =
                tasks.where((task) => !task.isCompleted).toList();
            final completedTasks =
                tasks.where((task) => task.isCompleted).toList();

            groupedTasks['not_completed'] =
                _sortTasksInGroup(notCompletedTasks, filterType);
            if (completedTasks.isNotEmpty) {
              groupedTasks['completed'] =
                  _sortTasksInGroup(completedTasks, filterType);
            }
          }
        } else {
          // チェックボックスの場合、完了/未完了でグループ化
          final notCompletedTasks =
              tasks.where((task) => !task.isCompleted).toList();
          final completedTasks =
              tasks.where((task) => task.isCompleted).toList();

          groupedTasks['not_completed'] =
              _sortTasksInGroup(notCompletedTasks, filterType);
          if (completedTasks.isNotEmpty) {
            groupedTasks['completed'] =
                _sortTasksInGroup(completedTasks, filterType);
          }
        }

        return groupedTasks;

      case GroupType.priority:
        // 優先度ごとにグループ化
        final unsortedGroups = <String, List<Task>>{};
        final noPriorityTasks = <Task>[];

        if (taskDatabaseViewModel?.priority != null) {
          try {
            for (final task in tasks) {
              if (task.priority != null) {
                final priorityKey = task.priority!.id;
                unsortedGroups.putIfAbsent(priorityKey, () => []);
                unsortedGroups[priorityKey]!.add(task);
              } else {
                noPriorityTasks.add(task);
              }
            }
          } catch (e) {
            // エラー時は通常どおり処理
            for (final task in tasks) {
              if (task.priority != null) {
                final priorityKey = task.priority!.id;
                unsortedGroups.putIfAbsent(priorityKey, () => []);
                unsortedGroups[priorityKey]!.add(task);
              } else {
                noPriorityTasks.add(task);
              }
            }
          }
        } else {
          // 通常の処理
          for (final task in tasks) {
            if (task.priority != null) {
              final priorityKey = task.priority!.id;
              unsortedGroups.putIfAbsent(priorityKey, () => []);
              unsortedGroups[priorityKey]!.add(task);
            } else {
              noPriorityTasks.add(task);
            }
          }
        }

        // 各グループ内のタスクをソート
        for (final entry in unsortedGroups.entries) {
          groupedTasks[entry.key] = _sortTasksInGroup(entry.value, filterType);
        }

        // 優先度なしのタスクは「未設定」グループに (最後に追加)
        if (noPriorityTasks.isNotEmpty) {
          groupedTasks['no_priority'] =
              _sortTasksInGroup(noPriorityTasks, filterType);
        }

        return groupedTasks;

      case GroupType.none:
        // グループ化なし（完了/未完了のみ分ける）
        final notCompletedTasks =
            tasks.where((task) => !task.isCompleted).toList();
        final completedTasks = tasks.where((task) => task.isCompleted).toList();

        groupedTasks['not_completed'] =
            _sortTasksInGroup(notCompletedTasks, filterType);
        if (completedTasks.isNotEmpty) {
          groupedTasks['completed'] =
              _sortTasksInGroup(completedTasks, filterType);
        }

        return groupedTasks;
    }
  }

  // グループ内のタスクをソートする
  List<Task> _sortTasksInGroup(List<Task> tasks, FilterType filterType) {
    if (tasks.isEmpty) return tasks;

    // 現在のソートタイプを取得
    final taskSortNotifier = ref.read(taskSortProvider.notifier);

    // タスクを完了/未完了で分ける
    final notCompletedTasks = tasks.where((t) => !t.isCompleted).toList();
    final completedTasks = tasks.where((t) => t.isCompleted).toList();

    // それぞれのグループをソート
    final sortedNotCompletedTasks =
        taskSortNotifier.sortTasks(notCompletedTasks, filterType);
    final sortedCompletedTasks =
        taskSortNotifier.sortTasks(completedTasks, filterType);

    // 未完了→完了の順で結合
    return [...sortedNotCompletedTasks, ...sortedCompletedTasks];
  }
}

// 現在選択されているグループタイプを取得するProvider
@riverpod
GroupType currentGroupType(Ref ref, FilterType filterType) {
  final groupState = ref.watch(taskGroupProvider);
  return groupState.valueOrNull?[filterType] ?? GroupType.none;
}
