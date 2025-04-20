import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../settings/task_database/task_database_viewmodel.dart';
import '../common/filter_type.dart';
import '../model/property.dart';
import '../model/task.dart';

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

    switch (groupType) {
      case GroupType.date:
        // 日付ごとにグループ化
        final Map<String, List<Task>> groupedTasks = {};
        final noDateTasks = <Task>[];

        for (final task in tasks) {
          if (task.dueDate != null) {
            final dateKey =
                task.dueDate!.start.datetime.toIso8601String().split('T')[0];
            groupedTasks.putIfAbsent(dateKey, () => []);
            groupedTasks[dateKey]!.add(task);
          } else {
            noDateTasks.add(task);
          }
        }

        // 日付なしのタスクは「未設定」グループに
        if (noDateTasks.isNotEmpty) {
          groupedTasks['no_date'] = noDateTasks;
        }

        return groupedTasks;

      case GroupType.status:
        // ステータスごとにグループ化
        final Map<String, List<Task>> groupedTasks = {};

        if (taskDatabaseViewModel?.status is StatusProperty) {
          try {
            final statusProperty =
                taskDatabaseViewModel!.status as StatusProperty;
            final options = statusProperty.status.options;

            // 各オプション（ステータス）ごとにグループ化
            for (final option in options) {
              groupedTasks[option.id] = tasks.where((task) {
                if (task.status is TaskStatusStatus) {
                  final statusTask = task.status as TaskStatusStatus;
                  return statusTask.option?.id == option.id;
                }
                return false;
              }).toList();
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
              groupedTasks['no_status'] = noStatusTasks;
            }
          } catch (e) {
            // エラー発生時はデフォルトの完了/未完了グループに分ける
            groupedTasks['not_completed'] =
                tasks.where((task) => !task.isCompleted).toList();
            groupedTasks['completed'] =
                tasks.where((task) => task.isCompleted).toList();
          }
        } else {
          // チェックボックスの場合、完了/未完了でグループ化
          groupedTasks['not_completed'] =
              tasks.where((task) => !task.isCompleted).toList();
          groupedTasks['completed'] =
              tasks.where((task) => task.isCompleted).toList();
        }

        return groupedTasks;

      case GroupType.priority:
        // 優先度ごとにグループ化
        final Map<String, List<Task>> groupedTasks = {};
        final noPriorityTasks = <Task>[];

        for (final task in tasks) {
          if (task.priority != null) {
            final priorityKey = task.priority!.id;
            groupedTasks.putIfAbsent(priorityKey, () => []);
            groupedTasks[priorityKey]!.add(task);
          } else {
            noPriorityTasks.add(task);
          }
        }

        // 優先度なしのタスクは「未設定」グループに
        if (noPriorityTasks.isNotEmpty) {
          groupedTasks['no_priority'] = noPriorityTasks;
        }

        return groupedTasks;

      case GroupType.none:
        // グループ化なし（完了/未完了のみ分ける）
        return {
          'not_completed': tasks.where((task) => !task.isCompleted).toList(),
          'completed': tasks.where((task) => task.isCompleted).toList(),
        };
    }
  }
}

// 現在選択されているグループタイプを取得するProvider
@riverpod
GroupType currentGroupType(Ref ref, FilterType filterType) {
  final groupState = ref.watch(taskGroupProvider);
  return groupState.valueOrNull?[filterType] ?? GroupType.none;
}
