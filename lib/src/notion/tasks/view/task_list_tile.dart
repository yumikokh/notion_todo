import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

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

  // TODO: あとでリファクタ
  final Task task;
  final ValueNotifier<bool> loading;
  final ValueNotifier<List<Task>> uiTasks;
  final TaskViewModel taskViewModel;

  get displayDate {
    final dateFormat = DateFormat('yyyy-MM-dd');
    const defaultColor = Colors.black;
    if (task.dueDate == null) {
      return null;
    }
    // 今日だったら表示しない
    final today = DateTime.now();
    if (task.dueDate!.year == today.year &&
        task.dueDate!.month == today.month &&
        task.dueDate!.day == today.day) {
      return null;
    }
    return (text: dateFormat.format(task.dueDate!), color: defaultColor);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
      // 右側に日付表示
      subtitle: displayDate != null
          ? Padding(
              padding: const EdgeInsets.only(top: 6), // 余白を追加
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: project表示
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 13, color: displayDate.color),
                      const SizedBox(width: 4),
                      Text(displayDate.text,
                          style: TextStyle(
                              fontSize: 13, color: displayDate.color)),
                    ],
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
