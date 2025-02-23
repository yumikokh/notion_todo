import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/date.dart';
import '../../../settings/font/font_constants.dart';
import '../../../settings/font/font_settings_viewmodel.dart';
import '../../../settings/theme/theme.dart';
import '../../model/task.dart';
import '../task_viewmodel.dart';
import 'task_sheet/task_date_sheet.dart';
import 'task_list_tile.dart';

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

  Widget _buildDismissibleTask(Task task, BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.horizontal,
      dismissThresholds: const {
        DismissDirection.endToStart: 0.5, // delete
        DismissDirection.startToEnd: 0.2, // edit
      },
      resizeDuration: null,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          taskViewModel.deleteTask(task);
        }
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            context: context,
            builder: (context) => TaskDateSheet(
              selectedDate: task.dueDate,
              confirmable: true,
              onSelected: (TaskDate? date) async {
                final newTask = task.copyWith(dueDate: date);
                await taskViewModel.updateTask(newTask);
              },
            ),
          );
          return false;
        }
        if (direction == DismissDirection.endToStart) {
          return true;
        }
        return false;
      },
      secondaryBackground: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      background: Container(
        color: MaterialTheme(Theme.of(context).textTheme)
            .extendedColors[0]
            .light
            .colorContainer,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(
          Icons.edit_calendar,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      child: Column(
        children: [
          const Divider(height: 0),
          TaskListTile(
            key: Key(
                '${task.id}${task.isCompleted ? "completed" : "notCompleted"}'),
            task: task,
            taskViewModel: taskViewModel,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notCompletedTasks = list.where((task) => !task.isCompleted).toList();
    final completedTasks = list.where((task) => task.isCompleted).toList();
    final fontSettings = ref.watch(fontSettingsViewModelProvider);

    final l = AppLocalizations.of(context)!;

    return ListView(
      key: key,
      children: [
        if (notCompletedTasks.isEmpty && completedTasks.isEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.8, // NOTE: pullできるようにサイズ指定
            child: Center(child: Text(l.no_task)),
          )
        else if (notCompletedTasks.isEmpty &&
            completedTasks.isNotEmpty &&
            !showCompleted)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(child: Text(l.no_task_description)),
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
              .map((task) => _buildDismissibleTask(task, context))
              .toList(),
          if (showCompleted && completedTasks.isNotEmpty)
            ...completedTasks
                .map((task) => _buildDismissibleTask(task, context))
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
