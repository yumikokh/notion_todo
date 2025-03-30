import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helpers/haptic_helper.dart';
import '../../../common/sound/sound_viewmodel.dart';
import '../../../settings/task_database/task_database_viewmodel.dart';
import '../../model/property.dart';
import '../../model/task.dart';
import '../../repository/notion_task_repository.dart';
import '../task_viewmodel.dart';
import 'date_label.dart';
import 'task_sheet/task_sheet.dart';
import 'task_star_button.dart';

class TaskListTile extends HookConsumerWidget {
  const TaskListTile({
    super.key,
    required this.task,
    required this.taskViewModel,
  });

  final Task task;
  final TaskViewModel taskViewModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checked = useState(task.isCompleted);

    return ListTile(
      visualDensity: VisualDensity.comfortable,
      enabled: !task.isTemp,
      onLongPress: () async {
        // TODO: メニューを表示
        final taskUrl = task.url;
        if (taskUrl == null) return;
        final url = Uri.parse(taskUrl);
        if (await canLaunchUrl(url)) {
          await HapticHelper.medium();
          await Future.delayed(
              const Duration(milliseconds: 100)); // 確実にvibrateするために少し待つ
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      },
      onTap: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return TaskSheet(
              initialTask: task,
              onSubmitted: (task, {bool? needSnackbarFloating}) {
                taskViewModel.updateTask(task);
              },
              onDeleted: () {
                taskViewModel.deleteTask(task);
              },
            );
          },
        );
      },
      leading: Checkbox(
        value: checked.value,
        activeColor:
            task.priority?.color ?? Theme.of(context).colorScheme.onSurface,
        side: BorderSide(
            width: 1,
            color:
                task.priority?.color ?? Theme.of(context).colorScheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        onChanged: (bool? willComplete) async {
          if (task.isTemp) return;
          if (willComplete == null) return;
          if (willComplete) {
            HapticHelper.success();
            // タスク完了時に音を鳴らす
            final soundSettings = ref.read(soundViewModelProvider);
            await soundSettings.playSound();
          }
          checked.value = willComplete;
          await taskViewModel.updateCompleteStatus(task, willComplete);
        },
      ),
      trailing: taskViewModel.showStarButton(task)
          ? TaskStarButton(
              task: task,
              onInProgressChanged: (task) async {
                final statusProperty =
                    ref.read(taskDatabaseViewModelProvider).valueOrNull?.status;
                if (statusProperty is! StatusCompleteStatusProperty) {
                  return;
                }
                final inProgressOption = statusProperty.inProgressOption;
                if (inProgressOption == null) {
                  return;
                }
                taskViewModel.updateInProgressStatus(
                    task, !task.isInProgress(inProgressOption));
              },
            )
          : null,
      title: Text(task.title,
          style: TextStyle(
            color: task.isCompleted || task.isTemp
                ? Theme.of(context).colorScheme.outline
                : Theme.of(context).colorScheme.onSurface,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            decorationColor: Theme.of(context).colorScheme.outline,
            fontSize: 15,
          )),
      subtitle: taskViewModel.showDueDate(task)
          ? SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  spacing: 6,
                  children: [
                    if (taskViewModel.showDueDate(task))
                      DateLabel(
                        date: task.dueDate,
                        showToday: taskViewModel.filterType != FilterType.today,
                        context: context,
                        showColor: !task.isCompleted,
                        showIcon: true,
                      ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
