import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  final String? title;

  static final DateHelper d = DateHelper();

  const TaskListView({
    super.key,
    required this.list,
    required this.taskViewModel,
    required this.showCompleted,
    this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // グループタイプを取得
    final groupType =
        ref.watch(currentGroupTypeProvider(taskViewModel.filterType));

    // タスクをグループ化
    final groupedTasks = ref
        .watch(taskGroupProvider.notifier)
        .groupTasks(list, taskViewModel.filterType);

    // 未グループ化の場合の通常表示用データ取得
    final notCompletedTasks = list.where((task) => !task.isCompleted).toList();
    final overdueTasks =
        notCompletedTasks.where((task) => task.isOverdue).toList();
    final remainingNotCompletedTasks =
        notCompletedTasks.where((task) => !task.isOverdue).toList();
    final completedTasks = list.where((task) => task.isCompleted).toList();

    final fontSettings = ref.watch(fontSettingsViewModelProvider);
    final themeMode = ref.watch(settingsViewModelProvider).themeMode;
    final isToday = taskViewModel.filterType == FilterType.today;
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
          selectedDate: TaskDate.todayAllDay(),
          confirmable: true,
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

    // ステータスやグループの表示名を取得
    String getOptionNameById(String id) {
      if (id == 'no_date') return l.no_property(l.date_property);
      if (id == 'no_status') return l.no_property(l.status_property);
      if (id == 'no_priority') return l.no_property(l.priority_property);
      if (id == 'not_completed') return l.no_property(l.completed_tasks);
      if (id == 'completed') return l.completed_tasks;

      // データベースのステータス情報からオプション名を取得
      final taskDatabaseViewModel =
          ref.read(taskDatabaseViewModelProvider).valueOrNull;

      if (groupType == GroupType.status &&
          taskDatabaseViewModel?.status is StatusProperty) {
        final statusProperty = taskDatabaseViewModel!.status as StatusProperty;
        try {
          final option =
              statusProperty.status.options.firstWhere((o) => o.id == id);
          return option.name;
        } catch (e) {
          return id;
        }
      } else if (groupType == GroupType.priority &&
          taskDatabaseViewModel?.priority != null) {
        try {
          final priorityProperty = taskDatabaseViewModel!.priority!;
          final option =
              priorityProperty.select.options.firstWhere((o) => o.id == id);
          return option.name;
        } catch (e) {
          return id;
        }
      }

      return id;
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

            // グループ化しない場合の通常表示
            if (groupType == GroupType.none) ...[
              // 期限切れタスク
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
                ...overdueTasks
                    .map((task) => TaskDismissible(
                        taskViewModel: taskViewModel,
                        task: task,
                        themeMode: themeMode))
                    .toList(),
                const Divider(height: 0),
                const SizedBox(height: 30),
              ],

              // 残りの未完了タスク
              if (remainingNotCompletedTasks.isNotEmpty) ...[
                ...remainingNotCompletedTasks
                    .map((task) => TaskDismissible(
                        taskViewModel: taskViewModel,
                        task: task,
                        themeMode: themeMode))
                    .toList(),
                const Divider(height: 0),
                const SizedBox(height: 30),
              ],

              // 完了タスク
              if (showCompleted && completedTasks.isNotEmpty) ...[
                // 完了タスクのヘッダー
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
                  child: Text(
                    l.completed_tasks,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ),
                // 完了タスク一覧
                ...completedTasks
                    .map((task) => TaskDismissible(
                        taskViewModel: taskViewModel,
                        task: task,
                        themeMode: themeMode))
                    .toList(),
                const Divider(height: 0),
              ],
            ],

            // グループ化する場合の表示
            if (groupType != GroupType.none) ...[
              // 各グループごとに表示
              ...groupedTasks.entries.map((entry) {
                final groupId = entry.key;
                final tasksInGroup = entry.value;

                // 完了タスクグループで、showCompletedがfalseの場合は表示しない
                if (groupId == 'completed' && !showCompleted) {
                  return const SizedBox.shrink();
                }

                // 空のグループは表示しない
                if (tasksInGroup.isEmpty) {
                  return const SizedBox.shrink();
                }

                // グループが「completed」以外は、完了タスクと未完了タスクを分ける
                final List<Task> nonCompletedTasks;
                final List<Task> completedTasksInGroup;

                if (groupId != 'completed' && groupId != 'not_completed') {
                  nonCompletedTasks =
                      tasksInGroup.where((t) => !t.isCompleted).toList();
                  completedTasksInGroup =
                      tasksInGroup.where((t) => t.isCompleted).toList();
                } else {
                  nonCompletedTasks = tasksInGroup;
                  completedTasksInGroup = [];
                }

                final showGroupHeader =
                    groupId != 'not_completed' && nonCompletedTasks.isNotEmpty;
                final showCompletedHeader =
                    showCompleted && completedTasksInGroup.isNotEmpty;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // グループヘッダー
                    if (showGroupHeader) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
                        child: Text(
                          getOptionNameById(groupId),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ),
                    ],

                    // 未完了タスク
                    ...nonCompletedTasks
                        .map((task) => TaskDismissible(
                            taskViewModel: taskViewModel,
                            task: task,
                            themeMode: themeMode))
                        .toList(),

                    // 完了タスク
                    if (showCompletedHeader) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 16, 32, 8),
                        child: Text(
                          l.completed_tasks,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 13,
                              ),
                        ),
                      ),
                    ],

                    if (showCompleted) ...[
                      ...completedTasksInGroup
                          .map((task) => TaskDismissible(
                              taskViewModel: taskViewModel,
                              task: task,
                              themeMode: themeMode))
                          .toList(),
                    ],

                    const Divider(height: 0),
                    const SizedBox(height: 30),
                  ],
                );
              }).toList(),
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
            if (taskViewModel.isLoading)
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
}
