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
    required this.uiTasks,
    required this.taskViewModel,
  });

  // HACK: あとでリファクタ
  final Task task;
  final ValueNotifier<bool> loading; // けす
  final ValueNotifier<List<Task>> uiTasks; // けす
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
        onChanged: (bool? value) async {
          if (loading.value) return;
          loading.value = true;
          // UI更新
          uiTasks.value = uiTasks.value
              .map((t) =>
                  t.id == task.id ? task.copyWith(isCompleted: value!) : t)
              .toList();
          taskViewModel.updateStatus(task.id, value!);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('「${task.title}」を完了しました 🎉'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  taskViewModel.updateStatus(task.id, false);
                  uiTasks.value = [...uiTasks.value, task];
                },
              ),
            ),
          );
          // 時間を置く
          await Future.delayed(const Duration(milliseconds: 460));
          // リストから削除
          if (value == true) {
            uiTasks.value =
                uiTasks.value.where((t) => t.id != task.id).toList();
          }

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
