import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notion_todo/src/helpers/date.dart';

import '../../model/task.dart';
import '../task_viewmodel.dart';
import 'task_date_sheet.dart';

class EditTaskSheet extends HookConsumerWidget {
  final Task task;
  const EditTaskSheet({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final taskViewModel = ref.watch(taskViewModelProvider.notifier);
    final titleController = useTextEditingController(text: task.title);
    final initialDueDate = task.dueDate?.start == null
        ? null
        : DateTime.parse(task.dueDate!.start).toLocal();
    final selectedDueDate = useState<DateTime?>(initialDueDate);
    final dueDateChangeHandler = useCallback(
      (DateTime? newDueDate) {
        selectedDueDate.value = newDueDate;
      },
      [selectedDueDate],
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          ElevatedButton(
            child: selectedDueDate.value == null
                ? const Text('日付を選択')
                : Text(
                    '${selectedDueDate.value!.toLocal()}',
                  ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  // テキスト表示
                  return SizedBox.expand(
                      child: Center(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TaskDateSheet(
                        selectedDate: selectedDueDate.value,
                        onSelected: (DateTime? date) {
                          dueDateChangeHandler(date);
                        },
                      ),
                    ],
                  )));
                },
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              final title = titleController.text;
              final dueDate = selectedDueDate.value == null
                  ? null
                  : TaskDate(start: dateString(selectedDueDate.value!));
              taskViewModel
                  .updateTask(task.copyWith(title: title, dueDate: dueDate));
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('「$title」が変更されました'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      taskViewModel.updateTask(task);
                    },
                  ),
                ),
              );
            },
            child: const Text('変更'),
          ),
          // 削除ボタン
          ElevatedButton(
            onPressed: () {
              taskViewModel.deleteTask(task.id);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('「${task.title}」が削除されました'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      taskViewModel.undoDeleteTask(task);
                    },
                  ),
                ),
              );
            },
            child: const Text('削除'),
          ),
        ],
      ),
    );
  }
}
