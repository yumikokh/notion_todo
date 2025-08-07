import 'package:flutter/material.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../project_selection_viewmodel.dart';

import '../../../helpers/date.dart';
import '../../../helpers/haptic_helper.dart';
import '../../../settings/font/font_constants.dart';
import '../../../settings/font/font_settings_viewmodel.dart';
import '../../../settings/settings_viewmodel.dart';
import '../../../settings/task_database/task_database_viewmodel.dart';
import '../../common/filter_type.dart';
import '../../model/property.dart';
import '../../model/task.dart';
import '../task_group_provider.dart';
import '../task_viewmodel.dart';
import './task_dismissible.dart';
import './task_sheet/task_date_sheet.dart';

class TaskListView extends HookConsumerWidget {
  final List<Task> list;
  final TaskViewModel taskViewModel;
  final bool showCompleted;
  final bool isLoading;
  final String? title;

  static final DateHelper d = DateHelper();

  const TaskListView({
    super.key,
    required this.list,
    required this.taskViewModel,
    required this.showCompleted,
    required this.isLoading,
    this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isToday = taskViewModel.filterType == FilterType.today;
    // グループタイプを取得
    final groupType =
        ref.watch(currentGroupTypeProvider(taskViewModel.filterType));

    // グループの開閉状態を取得（グループタイプごとに分ける）
    final expandedGroupsKey =
        '${taskViewModel.filterType.name}_${groupType.name}';
    final expandedGroups = ref.watch(expandedGroupsProvider(expandedGroupsKey));
    final expandedGroupsNotifier =
        ref.read(expandedGroupsProvider(expandedGroupsKey).notifier);

    // タスクをグループ化
    final groupedTasks = ref
        .watch(taskGroupProvider.notifier)
        .groupTasks(list, taskViewModel.filterType, showCompleted);

    // 未グループ化の場合の通常表示用データ取得
    final notCompletedTasks = list.where((task) => !task.isCompleted).toList();
    final overdueTasks = notCompletedTasks
        .where((task) => task.isOverdueToday && isToday)
        .toList();
    final remainingNotCompletedTasks = notCompletedTasks
        .where((task) => !task.isOverdueToday || !isToday)
        .toList();
    final completedTasks = list.where((task) => task.isCompleted).toList();

    final fontSettings = ref.watch(fontSettingsViewModelProvider);
    final themeMode = ref.watch(settingsViewModelProvider).themeMode;

    final l = AppLocalizations.of(context)!;

    // 時間に応じたメッセージを取得（Todayページの場合）
    String getTimeBasedMessage() {
      final now = DateTime.now();
      final hour = now.hour;

      if (hour < 12) {
        return l.morning_message;
      } else if (hour < 18) {
        return l.afternoon_message;
      } else {
        return l.evening_message;
      }
    }

    // タスクなし/全て完了の場合のイラスト+テキスト
    Widget? centerOverlay;
    if (notCompletedTasks.isEmpty && completedTasks.isEmpty) {
      // タスクがない場合
      centerOverlay = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            alignment: Alignment.bottomCenter,
            child: Text(
              isToday ? getTimeBasedMessage() : l.no_task,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(height: 1.6),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Image.asset(
            'assets/images/illust_standup.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ],
      );
    } else if (notCompletedTasks.isEmpty &&
        completedTasks.isNotEmpty &&
        !showCompleted) {
      // タスクがすべて完了している場合
      centerOverlay = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l.no_task_description,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Image.asset(
            'assets/images/illust_complete.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ],
      );
    }

    // 期限切れタスクを一括リスケジュールするシート
    void showRescheduleSheet() {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        context: context,
        builder: (context) => TaskDateSheet(
          selectedDate: null, // リスケジュール時は既存の日時情報を無視
          confirmable: true,
          isRescheduleMode: true, // リスケジュールモードを有効化
          onSelected: (TaskDate? date) async {
            // 期限切れタスクすべてを更新
            for (final task in overdueTasks) {
              final newTask = task.copyWith(dueDate: date);
              await taskViewModel.updateTask(newTask);
            }
            HapticHelper.selection();
          },
        ),
      );
    }

    return Stack(
      children: [
        // イラスト+テキスト部分（条件に応じて中央に固定表示）
        if (centerOverlay != null)
          Positioned.fill(
            child: Center(
              child: centerOverlay,
            ),
          ),

        // リスト部分（常に表示、スクロール可能）
        ListView(
          key: key,
          children: [
            // MEMO: Indexで上線が隠れるため必要
            const SizedBox(height: 1),

            // タイトル
            if (title != null)
              fontSettings.when(
                data: (settings) => Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 20),
                  child: Text(
                    title!,
                    style: FontConstants.getFont(settings.fontFamily).copyWith(
                      fontSize: settings.fontSize,
                      fontStyle: settings.isItalic
                          ? FontStyle.italic
                          : FontStyle.normal,
                      letterSpacing: settings.letterSpacing,
                      fontWeight: settings.isBold ? FontWeight.bold : null,
                    ),
                  ),
                ),
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
              ),

            // グループ化する場合の表示
            if (groupType != GroupType.none)
              ...buildGroupedTaskList(
                  groupedTasks: groupedTasks,
                  context: context,
                  themeMode: themeMode,
                  expandedGroups: expandedGroups,
                  expandedGroupsNotifier: expandedGroupsNotifier,
                  ref: ref,
                  groupType: groupType),

            // グループ化しない場合の表示
            if (groupType == GroupType.none) ...[
              // 期限切れタスク（Todayページのみで表示）
              if (overdueTasks.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
                  child: InkWell(
                    onTap: showRescheduleSheet,
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          l.reschedule,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.error),
                        ),
                        const SizedBox(width: 2),
                        Icon(Icons.refresh,
                            size: 18,
                            color: Theme.of(context).colorScheme.error),
                      ],
                    ),
                  ),
                ),
                ...overdueTasks.map((task) => TaskDismissible(
                    taskViewModel: taskViewModel,
                    task: task,
                    themeMode: themeMode)),
                const Divider(height: 0),
                const SizedBox(height: 30),
              ],

              // 残りの未完了タスク
              if (remainingNotCompletedTasks.isNotEmpty) ...[
                ...remainingNotCompletedTasks.map((task) => TaskDismissible(
                    taskViewModel: taskViewModel,
                    task: task,
                    themeMode: themeMode)),
                const Divider(height: 0),
              ],

              // 完了タスク
              if (showCompleted && completedTasks.isNotEmpty) ...[
                ...completedTasks.map((task) => TaskDismissible(
                    taskViewModel: taskViewModel,
                    task: task,
                    themeMode: themeMode)),
                const Divider(height: 0),
              ],
            ],

            // ロードボタン
            if (taskViewModel.hasMore)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: FilledButton.tonal(
                    onPressed: () async {
                      await taskViewModel.loadMore();
                    },
                    child: Text(l.load_more),
                  ),
                ),
              ),

            // ローディング中

            if (isLoading && centerOverlay == null)
              const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator.adaptive())),

            // ボタンとかぶらないように
            const SizedBox(height: 100)
          ],
        ),
      ],
    );
  }

  // グループ化されたタスクリストを構築
  List<Widget> buildGroupedTaskList({
    required Map<String, List<Task>> groupedTasks,
    required BuildContext context,
    required ThemeMode themeMode,
    required Map<String, bool> expandedGroups,
    required ExpandedGroupsNotifier expandedGroupsNotifier,
    required WidgetRef ref,
    required GroupType groupType,
  }) {
    final widgets = <Widget>[const SizedBox(height: 12)];
    // グループ処理に使う一時的なMapを作成（完了タスクの処理を確実にするため）
    Map<String, List<Task>> workingGroups = {};

    // 完了済みタスクを含むすべてのグループを処理
    for (final entry in groupedTasks.entries) {
      final groupId = entry.key;
      final tasksInGroup = entry.value;
      // 空のグループはスキップ
      if (tasksInGroup.isEmpty) {
        continue;
      }

      // このグループを作業用Mapに追加
      workingGroups[groupId] = tasksInGroup;
    }

    // 各グループを処理して表示
    for (final entry in workingGroups.entries) {
      final groupId = entry.key;
      final tasksInGroup = entry.value;

      // 完了タスクと未完了タスクに分離
      final nonCompletedTasks =
          tasksInGroup.where((t) => !t.isCompleted).toList();
      final completedTasksInGroup =
          tasksInGroup.where((t) => t.isCompleted).toList();

      // 表示条件の確認
      final hasNonCompletedTasks = nonCompletedTasks.isNotEmpty;
      final hasCompletedTasks = completedTasksInGroup.isNotEmpty;

      // このグループを表示するか判定
      // 未完了タスクがある、または（showCompletedがtrueかつ完了タスクがある）
      final shouldShowGroup =
          hasNonCompletedTasks || (showCompleted && hasCompletedTasks);

      // 表示条件を満たさないグループはスキップ
      if (!shouldShowGroup) {
        continue;
      }

      // グループヘッダーを表示するかどうか
      final showGroupHeader = groupId != 'not_completed';

      // 現在のグループの開閉状態
      final isExpanded = expandedGroupsNotifier.isExpanded(groupId);

      final groupColumn = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // グループヘッダー
          if (showGroupHeader)
            InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              onTap: () {
                HapticHelper.light();
                // グループの開閉状態を切り替え
                expandedGroupsNotifier.toggleGroup(groupId);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildGroupHeader(
                        groupId,
                        context,
                        ref,
                        groupType,
                      ),
                    ),
                    // 矢印アイコン - 開閉状態に応じて回転
                    AnimatedRotation(
                      turns: isExpanded ? 0 : -0.25,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // グループが開いている場合のみタスクを表示
          if (isExpanded) ...[
            // 未完了タスク
            ...nonCompletedTasks.map((task) => TaskDismissible(
                taskViewModel: taskViewModel,
                task: task,
                themeMode: themeMode)),

            // 完了済みタスク（showCompletedがtrueの場合のみ表示）
            if (showCompleted && completedTasksInGroup.isNotEmpty)
              ...completedTasksInGroup.map((task) => TaskDismissible(
                  taskViewModel: taskViewModel,
                  task: task,
                  themeMode: themeMode)),
          ],

          const Divider(height: 0),
          const SizedBox(height: 30),
        ],
      );

      widgets.add(groupColumn);
    }

    return widgets;
  }

  // ステータスやグループの表示名を取得するメソッド
  String _getOptionNameById(String id, BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    
    // ProjectSelectionViewModelからプロジェクト情報を取得
    final projectsAsync = ref.read(projectSelectionViewModelProvider);
    final projects = projectsAsync.valueOrNull ?? [];

    if (id == 'no_date') return l.no_property(l.date_property);
    if (id == 'no_status') return l.no_property(l.status_property);
    if (id == 'no_priority') return l.no_property(l.priority_property);
    if (id == 'no_project') return l.no_property(l.project_property);
    if (id == 'not_completed') return l.no_property(l.completed_tasks);
    if (id == 'completed') return l.completed_tasks;

    final groupType =
        ref.watch(currentGroupTypeProvider(taskViewModel.filterType));

    // データベースのステータス情報からオプション名を取得
    final taskDatabaseViewModel =
        ref.read(taskDatabaseViewModelProvider).valueOrNull;

    try {
      switch (groupType) {
        case GroupType.status:
          if (taskDatabaseViewModel?.status is StatusProperty) {
            final statusProperty =
                taskDatabaseViewModel!.status as StatusProperty;

            final option =
                statusProperty.status.options.firstWhere((o) => o.id == id);
            return option.name;
          }
          break;
        case GroupType.priority:
          if (taskDatabaseViewModel?.priority != null) {
            final priorityProperty = taskDatabaseViewModel!.priority!;
            final option =
                priorityProperty.select.options.firstWhere((o) => o.id == id);
            return option.name;
          }
          break;
        case GroupType.date:
          // 日付グループの場合、ISO形式（2025-07-08）を解析してフォーマット
          try {
            final date = DateTime.parse(id);
            return d.formatDateTime(date, true, context, showToday: true) ?? id;
          } catch (e) {
            return id;
          }
        case GroupType.project:
          // ProjectSelectionViewModelからプロジェクト名を取得
          try {
            final project = projects.firstWhere((p) => p.id == id);
            final title = project.title;
            
            // タイトルがnullまたは空の場合は「名称未設定」を表示
            return (title == null || title.isEmpty)
                ? l.no_property(l.project_property)
                : title;
          } catch (e) {
            return l.no_property(l.project_property);
          }
        default:
          break;
      }
      return id;
    } catch (e) {
      return id;
    }
  }

  Widget _buildGroupHeader(
    String groupId,
    BuildContext context,
    WidgetRef ref,
    GroupType groupType,
  ) {
    final groupName = _getOptionNameById(groupId, context, ref);

    // プロジェクトグループの場合は#記号を追加
    if (groupType == GroupType.project) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '#',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              groupName,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      );
    }

    // その他のグループタイプの場合は通常の表示
    return Text(
      groupName,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
    );
  }
}
