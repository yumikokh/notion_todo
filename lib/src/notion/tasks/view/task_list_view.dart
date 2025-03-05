import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/date.dart';
import '../../../settings/font/font_constants.dart';
import '../../../settings/font/font_settings_viewmodel.dart';
import '../../../settings/settings_viewmodel.dart';
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

    final l = AppLocalizations.of(context)!;

    return ListView(
      key: key,
      children: [
        if (notCompletedTasks.isEmpty && completedTasks.isEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.8, // NOTE: pullできるようにサイズ指定
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l.no_task,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12), // テキストと画像の間隔
                Image.asset(
                  'assets/images/illust_standup.png',
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ],
            ),
          )
        else if (notCompletedTasks.isEmpty &&
            completedTasks.isNotEmpty &&
            !showCompleted)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l.no_task_description,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12), // テキストと画像の間隔
                Image.asset(
                  'assets/images/illust_complete.png',
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ],
            ),
          )
        else ...[
          if (title != null)
            fontSettings.when(
              data: (settings) => Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 20),
                child: Text(
                  title!,
                  style: FontConstants.getFont(settings.fontFamily).copyWith(
                    fontSize: settings.fontSize,
                    fontStyle:
                        settings.isItalic ? FontStyle.italic : FontStyle.normal,
                    letterSpacing: settings.letterSpacing,
                    fontWeight: settings.isBold ? FontWeight.bold : null,
                  ),
                ),
              ),
              loading: () => const SizedBox(),
              error: (_, __) => const SizedBox(),
            ),
          ...notCompletedTasks
              .map((task) => TaskDismissible(
                  taskViewModel: taskViewModel,
                  task: task,
                  themeMode: themeMode))
              .toList(),
          if (showCompleted && completedTasks.isNotEmpty)
            ...completedTasks
                .map((task) => TaskDismissible(
                    taskViewModel: taskViewModel,
                    task: task,
                    themeMode: themeMode))
                .toList(),
          const Divider(height: 0),
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
          if (taskViewModel.isLoading)
            const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator.adaptive())),
          const SizedBox(height: 100) // ボタンとかぶらないように
        ],
      ],
    );
  }
}
