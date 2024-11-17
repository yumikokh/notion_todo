import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../task_viewmodel.dart';
import 'task_date_sheet.dart';

class AddTaskSheet extends HookConsumerWidget {
  const AddTaskSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final taskViewModel = ref.watch(taskViewModelProvider.notifier);
    final titleController = useTextEditingController();
    final selectedDueDate = useState<DateTime?>(DateTime.now());
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
              taskViewModel.addTask(title, selectedDueDate.value);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('「$title」が追加されました')),
              );
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );
  }
}
