import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/date.dart';
import '../../../helpers/haptic_helper.dart';
import '../../../settings/font/font_constants.dart';
import '../../../settings/font/font_settings_viewmodel.dart';
import '../../../settings/settings_viewmodel.dart';
import '../../common/filter_type.dart';
import '../../model/task.dart';
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
          selectedDate: null,
          confirmable: true,
          onSelected: (TaskDate? date) async {
            if (date == null) return;

            // 期限切れタスクすべてを更新
            for (final task in overdueTasks) {
              final newTask = task.copyWith(dueDate: date);
              await taskViewModel.updateTask(newTask);
            }

            // ハプティックフィードバック
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
                        l.overdue_tasks,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.error),
                      ),
                      const SizedBox(width: 2),
                      Icon(Icons.refresh,
                          size: 18, color: Theme.of(context).colorScheme.error),
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
