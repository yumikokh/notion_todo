import 'package:flutter/material.dart';
import 'dart:async';

import './edit_task_sheet.dart';
import '../../model/task.dart';
import '../task_viewmodel.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
    required this.task,
    required this.loading,
    required this.updateUITasks,
    required this.taskViewModel,
  });

  // HACK: あとでリファクタ
  final Task task;
  final ValueNotifier<bool> loading; // けす
  final Function(Task task, bool isComplete) updateUITasks;
  final TaskViewModel taskViewModel;

  @override
  Widget build(BuildContext context) {
    final d = taskViewModel.getDisplayDate(task);
    return ListTile(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return EditTaskSheet(task: task);
          },
        );
      },
      leading: Checkbox(
        value: task.isCompleted,
        activeColor: Colors.black,
        side: const BorderSide(color: Colors.black, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        onChanged: (bool? willComplete) async {
          if (loading.value) return;
          if (willComplete == null) return;
          loading.value = true;
          // UI更新
          updateUITasks(task, willComplete);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: willComplete
                  ? Text('「${task.title}」を完了しました 🎉')
                  : Text('「${task.title}」を未完了に戻しました'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  taskViewModel.updateStatus(task.id, !willComplete);
                  updateUITasks(task, !willComplete);
                },
              ),
            ),
          );
          await taskViewModel.updateStatus(task.id, willComplete);
          // // 時間を置く
          // await Future.delayed(const Duration(milliseconds: 460));
          // // リストから削除
          // if (willComplete == true) {
          //   uiTasks.value =
          //       uiTasks.value.where((t) => t.id != task.id).toList();
          // }

          loading.value = false;
        },
      ),
      title: Text(task.title,
          style: TextStyle(
            color: task.isCompleted ? Colors.grey : Colors.black,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
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
