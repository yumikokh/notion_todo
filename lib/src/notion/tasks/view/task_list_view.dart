import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/date.dart';
import '../../../settings/font/font_constants.dart';
import '../../../settings/font/font_settings_viewmodel.dart';
import '../../../settings/settings_viewmodel.dart';
import '../../common/filter_type.dart';
import '../../model/task.dart';
import '../task_viewmodel.dart';
import './task_dismissible.dart';

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

            // 未完了タスク
            ...notCompletedTasks
                .map((task) => TaskDismissible(
                    taskViewModel: taskViewModel,
                    task: task,
                    themeMode: themeMode))
                .toList(),

            // 完了タスク
            if (showCompleted && completedTasks.isNotEmpty) ...[
              // 完了タスクのヘッダー
              Padding(
                padding: EdgeInsets.fromLTRB(
                    32, notCompletedTasks.isEmpty ? 0 : 24, 32, 8),
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
            ],

            if (centerOverlay == null) const Divider(height: 0),

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
