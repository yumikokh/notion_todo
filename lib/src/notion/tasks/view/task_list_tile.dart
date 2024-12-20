import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../helpers/date.dart';
import '../../model/task.dart';
import '../task_viewmodel.dart';
import 'task_sheet/task_sheet.dart';

class TaskListTile extends HookWidget {
  const TaskListTile({
    super.key,
    required this.task,
    required this.loading,
    required this.taskViewModel,
  });

  final Task task;
  final ValueNotifier<bool> loading;
  final TaskViewModel taskViewModel;

  @override
  Widget build(BuildContext context) {
    final d = taskViewModel.getDisplayDate(task, context);

    final checked = useState(task.isCompleted);

    return ListTile(
      onTap: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          context: context,
          builder: (context) {
            return TaskSheet(
              initialDueDate: task.dueDate?.start == null
                  ? null
                  : DateTime.parse(task.dueDate!.start).toLocal(),
              initialTitle: task.title,
              onSubmitted: (title, dueDate) {
                final d = dueDate == null
                    ? null
                    : TaskDate(start: dateString(dueDate));
                taskViewModel.updateTask(task.copyWith(
                  title: title,
                  dueDate: d,
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
          if (loading.value) return;
          if (willComplete == null) return;
          checked.value = willComplete;
          loading.value = true;
          await taskViewModel.updateStatus(task, willComplete);
          loading.value = false;
        },
      ),
      title: Text(task.title,
          style: TextStyle(
            color: checked.value
                ? Theme.of(context).colorScheme.outline
                : Theme.of(context).colorScheme.onSurface,
            decoration: checked.value ? TextDecoration.lineThrough : null,
            decorationColor: Theme.of(context).colorScheme.outline,
          )),
      subtitle: d != null && d.dateStrings.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: project表示
                  Row(
                    children: [
                      Icon(d.icon, size: d.size, color: d.color),
                      const SizedBox(width: 4),
                      d.dateStrings.length == 1
                          ? Text(d.dateStrings[0],
                              style:
                                  TextStyle(fontSize: d.size, color: d.color))
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(d.dateStrings[0],
                                    style: TextStyle(
                                        fontSize: d.size, color: d.color)),
                                Icon(Icons.arrow_right_alt_rounded,
                                    size: d.size, color: d.color),
                                Text(d.dateStrings[1],
                                    style: TextStyle(
                                        fontSize: d.size, color: d.color)),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
