import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../helpers/haptic_helper.dart';
import '../../../notion/model/task.dart';
import '../../../notion/tasks/task_viewmodel.dart';
import '../../../notion/tasks/view/task_list_tile.dart';
import '../../../notion/tasks/view/task_sheet/task_date_sheet.dart';
import '../../../settings/theme/theme.dart';

class TaskDismissible extends HookWidget {
  const TaskDismissible({
    super.key,
    required this.taskViewModel,
    required this.task,
    required this.themeMode,
  });

  final TaskViewModel taskViewModel;
  final Task task;
  final ThemeMode themeMode;

  static const double deleteThreshold = 0.4;
  static const double dateThreshold = 0.25;

  @override
  Widget build(BuildContext context) {
    final reachType = useState<DismissDirection?>(null);
    final deleteColor = Theme.of(context).colorScheme.error;
    final editColor = switch (themeMode) {
      ThemeMode.light => MaterialTheme(Theme.of(context).textTheme)
          .extendedColors[0]
          .light
          .colorContainer,
      ThemeMode.dark =>
        MaterialTheme(Theme.of(context).textTheme).extendedColors[0].dark.color,
      ThemeMode.system =>
        MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? MaterialTheme(Theme.of(context).textTheme)
                .extendedColors[0]
                .light
                .colorContainer
            : MaterialTheme(Theme.of(context).textTheme)
                .extendedColors[0]
                .dark
                .color
    };

    final inactiveColor = Theme.of(context).colorScheme.secondaryFixedDim;

    if (task.isTemp) {
      return Column(
        children: [
          const Divider(height: 0),
          TaskListTile(
            key: Key(task.id),
            task: task,
            taskViewModel: taskViewModel,
          ),
        ],
      );
    }

    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.horizontal,
      dismissThresholds: const {
        DismissDirection.endToStart: deleteThreshold, // delete
        DismissDirection.startToEnd: dateThreshold, // edit
      },
      resizeDuration: null,
      onUpdate: (details) {
        if (details.reached && !details.previousReached) {
          HapticHelper.light();
        }
        if (details.reached) {
          reachType.value = details.direction;
        }

        if (details.progress < dateThreshold &&
            details.direction == DismissDirection.startToEnd) {
          reachType.value = null;
        }
        if (details.progress < deleteThreshold &&
            details.direction == DismissDirection.endToStart) {
          reachType.value = null;
        }
      },
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
          // 削除のトリガー
          return true;
        }
        return false;
      },
      secondaryBackground: Container(
        color: reachType.value == DismissDirection.endToStart
            ? deleteColor
            : inactiveColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      background: Container(
        color: reachType.value == DismissDirection.startToEnd
            ? editColor
            : inactiveColor,
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
}
