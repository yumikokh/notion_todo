import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helpers/date.dart';
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
  static final DateHelper d = DateHelper();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checked = useState(task.isCompleted);

    return ListTile(
      onLongPress: () async {
        final taskUrl = task.url;
        if (taskUrl == null) return;
        final url = Uri.parse(taskUrl);
        if (await canLaunchUrl(url)) {
          if (await Haptics.canVibrate()) {
            await Haptics.vibrate(HapticsType.medium);
            await Future.delayed(
                const Duration(milliseconds: 100)); // 確実にvibrateするために少し待つ
          }
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      },
      onTap: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          context: context,
          builder: (context) {
            return TaskSheet(
              initialDueDate: task.dueDate,
              initialTitle: task.title,
              onSubmitted: (title, dueDate) {
                final due = dueDate == null
                    ? null
                    : TaskDate(start: dueDate.start, end: dueDate.end);
                taskViewModel.updateTask(task.copyWith(
                  title: title,
                  dueDate: due,
                ));
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
        activeColor: Theme.of(context).colorScheme.onSurface,
        side:
            BorderSide(width: 1, color: Theme.of(context).colorScheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        onChanged: (bool? willComplete) async {
          if (willComplete == null) return;
          checked.value = willComplete;
          await taskViewModel.updateCompleteStatus(task, willComplete);
        },
      ),
      trailing: TaskStarButton(
        task: task,
        onInProgressChanged: (task) =>
            taskViewModel.updateInProgressStatus(task),
      ),
      title: Text(task.title,
          style: TextStyle(
            color: task.isCompleted
                ? Theme.of(context).colorScheme.outline
                : Theme.of(context).colorScheme.onSurface,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            decorationColor: Theme.of(context).colorScheme.outline,
            fontSize: 15,
          )),
      subtitle: task.dueDate == null
          ? null
          : DateLabel(
              date: task.dueDate,
              showToday: taskViewModel.filterType != FilterType.today,
              context: context,
              showColor: true),
    );
  }
}
