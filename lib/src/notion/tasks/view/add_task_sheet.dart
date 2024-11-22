import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../repository/notion_database_repository.dart';
import '../task_viewmodel.dart';
import 'task_date_sheet.dart';

class AddTaskSheet extends HookWidget {
  final TaskViewModel taskViewModel;

  const AddTaskSheet({Key? key, required this.taskViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final initialDueDate =
        taskViewModel.filterType == FilterType.today ? DateTime.now() : null;
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
            onPressed: () async {
              Navigator.pop(context);
              await taskViewModel.addTask(
                  titleController.text, selectedDueDate.value);
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );
  }
}
