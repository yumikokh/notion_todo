import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/haptic_helper.dart';
import '../../../common/sound/sound_viewmodel.dart';
import '../../../settings/task_database/task_database_viewmodel.dart';
import '../../common/filter_type.dart';
import '../../model/property.dart';
import '../../model/task.dart';
import '../task_group_provider.dart';
import '../task_viewmodel.dart';
import 'date_label.dart';
import 'project_label.dart';
import 'task_sheet/task_sheet.dart';
import 'task_star_button.dart';
import 'use_task_actions_menu.dart';

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
    final groupType =
        ref.watch(taskGroupProvider).value?[taskViewModel.filterType] ??
            GroupType.none;

    final fillColor = switch (checked.value) {
      true =>
        (task.priority?.mColor ?? Theme.of(context).colorScheme.onSurface),
      false => task.priority?.mColor.withAlpha(60)
    };

    // 長押しメニューの設定
    final popupMenu = useTaskActionsMenu(
      task: task,
      taskViewModel: taskViewModel,
      context: context,
    );

    return ListTile(
      key: popupMenu.buttonKey,
      visualDensity: VisualDensity.comfortable,
      enabled: !task.isTemp,
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
      onLongPress: !task.isTemp
          ? () {
              HapticHelper.medium();
              popupMenu.show();
            }
          : null,
      leading: Checkbox(
        value: checked.value,
        fillColor: WidgetStateProperty.all(fillColor),
        activeColor: task.priority?.mColor,
        side: BorderSide(
            width: 1.2,
            color:
                task.priority?.mColor ?? Theme.of(context).colorScheme.outline),
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
          try {
            checked.value = willComplete;
            await taskViewModel.updateCompleteStatus(task, willComplete);
          } catch (e) {
            checked.value = !willComplete;
          }
        },
      ),
      trailing: taskViewModel.showStarButton(task)
          ? TaskStarButton(
              task: task,
              onInProgressChanged: (task) async {
                final statusProperty =
                    ref.read(taskDatabaseViewModelProvider).value?.status;
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
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 4,
        children: [
          Expanded(
            child: Text(
              task.title,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: task.isCompleted || task.isTemp
                    ? Theme.of(context).colorScheme.outline
                    : Theme.of(context).colorScheme.onSurface,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
                decorationColor: Theme.of(context).colorScheme.outline,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      subtitle: (!taskViewModel.showDueDate(task) &&
              (task.projects == null ||
                  (task.projects != null && task.projects!.isEmpty) ||
                  groupType == GroupType.project))
          ? null
          : SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  spacing: 6,
                  children: [
                    // 日付
                    if (taskViewModel.showDueDate(task))
                      DateLabel(
                        date: task.dueDate,
                        showToday: taskViewModel.filterType != FilterType.today,
                        context: context,
                        showColor: !task.isCompleted,
                        showIcon: true,
                      ),
                    // プロジェクト（Projectグルーピング時は非表示）
                    if (groupType != GroupType.project)
                      ProjectLabel(projects: task.projects),
                  ],
                ),
              ),
            ),
    );
  }
}
