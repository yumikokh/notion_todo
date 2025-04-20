import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/filter_type.dart';
import '../model/property.dart';
import '../model/task.dart';

part 'task_sort_provider.g.dart';

// ソートタイプの列挙型
enum SortType {
  system, // デフォルト（ドラッグで並び替え可能）
  date, // 日付順
  title, // タイトル順
  priority, // 優先度順
}

// SharedPreferences操作用のサービスクラス
class TaskSortService {
  static const String _sortTypeKeyPrefix = 'sort_type_';

  // ソートタイプをSharedPreferencesに保存
  Future<void> saveSortType(FilterType filterType, SortType sortType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$_sortTypeKeyPrefix${filterType.name}', sortType.index);
  }

  // ソートタイプをSharedPreferencesから読み込み
  Future<SortType> loadSortType(FilterType filterType) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt('$_sortTypeKeyPrefix${filterType.name}');
    if (value != null && value < SortType.values.length) {
      return SortType.values[value];
    }
    return _getDefaultSortType(filterType);
  }

  // フィルタータイプごとのデフォルトソートタイプを取得
  SortType _getDefaultSortType(FilterType filterType) {
    switch (filterType) {
      case FilterType.all:
        return SortType.date;
      case FilterType.today:
        return SortType.priority;
      case FilterType.upcoming:
        return SortType.date;
    }
  }
}

// タスクのソート機能を提供するNotifier
@riverpod
class TaskSort extends _$TaskSort {
  final TaskSortService _sortService = TaskSortService();

  @override
  Future<Map<FilterType, SortType>> build() async {
    // 全てのFilterTypeに対するSortTypeを読み込む
    final Map<FilterType, SortType> sortTypes = {};
    for (final type in FilterType.values) {
      sortTypes[type] = await _sortService.loadSortType(type);
    }

    return sortTypes;
  }

  // 指定したFilterTypeのSortTypeを取得
  SortType getSortType(FilterType filterType) {
    return state.valueOrNull?[filterType] ?? SortType.system;
  }

  // 指定したFilterTypeのSortTypeを設定
  Future<void> setSortType(FilterType filterType, SortType sortType) async {
    await _sortService.saveSortType(filterType, sortType);

    // stateを更新
    if (state.hasValue) {
      state = AsyncData({
        ...state.value!,
        filterType: sortType,
      });
    }
  }

  // タスクリストをソートする
  List<Task> sortTasks(
      List<Task> tasks, FilterType filterType, StatusOption? inProgressOption) {
    final sortType = getSortType(filterType);
    final sortedTasks = List<Task>.from(tasks);

    // ステータスの二次ソート関数
    int compareByStatus(Task a, Task b) {
      // 進行中 → 未完了 → 完了 の順
      if (inProgressOption != null) {
        final aInProgress = a.isInProgress(inProgressOption);
        final bInProgress = b.isInProgress(inProgressOption);
        if (aInProgress && !bInProgress) return -1;
        if (!aInProgress && bInProgress) return 1;
      }

      if (!a.isCompleted && b.isCompleted) return -1;
      if (a.isCompleted && !b.isCompleted) return 1;
      return 0;
    }

    switch (sortType) {
      case SortType.date:
        sortedTasks.sort((a, b) {
          // 日付が設定されていない場合は後ろに
          if (a.dueDate == null && b.dueDate != null) return 1;
          if (a.dueDate != null && b.dueDate == null) return -1;
          if (a.dueDate == null && b.dueDate == null) {
            return compareByStatus(a, b);
          }
          return a.dueDate!.start.datetime.compareTo(b.dueDate!.start.datetime);
        });
        break;

      case SortType.title:
        sortedTasks.sort((a, b) {
          final statusCompare = compareByStatus(a, b);
          if (statusCompare != 0) return statusCompare;
          return a.title.compareTo(b.title);
        });
        break;

      case SortType.priority:
        sortedTasks.sort((a, b) {
          // 優先度があれば比較、なければステータス比較
          final aPriority = a.priority;
          final bPriority = b.priority;

          if (aPriority != null && bPriority != null) {
            // 優先度名で比較
            final prioCompare = aPriority.name.compareTo(bPriority.name);
            if (prioCompare != 0) return prioCompare;
          } else if (aPriority != null && bPriority == null) {
            return -1; // 優先度があるタスクを前に
          } else if (aPriority == null && bPriority != null) {
            return 1; // 優先度がないタスクを後ろに
          }

          return compareByStatus(a, b);
        });
        break;

      case SortType.system:
    }

    return sortedTasks;
  }
}

// 現在選択されているソートタイプを取得するProvider
@riverpod
SortType currentSortType(Ref ref, FilterType filterType) {
  final sortState = ref.watch(taskSortProvider);
  return sortState.valueOrNull?[filterType] ?? SortType.system;
}
