import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import './edit_task_sheet.dart';
import '../../model/task.dart';
import '../task_viewmodel.dart';

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
    final d = taskViewModel.getDisplayDate(task);

    final checked = useState(task.isCompleted);

    return ListTile(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return EditTaskSheet(task: task, taskViewModel: taskViewModel);
          },
        );
      },
      leading: Checkbox(
        value: checked.value,
        activeColor: Colors.black,
        side: const BorderSide(color: Colors.black, width: 1),
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
            color: checked.value ? Colors.grey : Colors.black,
            decoration: checked.value ? TextDecoration.lineThrough : null,
            decorationColor: Colors.grey,
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
