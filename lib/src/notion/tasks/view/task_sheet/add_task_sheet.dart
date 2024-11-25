import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../repository/notion_task_repository.dart';
import '../../task_viewmodel.dart';
import 'date_chip.dart';
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
    final changeDueDate = useCallback(
      (DateTime? newDueDate) {
        selectedDueDate.value = newDueDate;
      },
      [selectedDueDate],
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 30, 40, 60),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            autofocus: true, // 起動時にフォーカスを設定
            decoration: const InputDecoration(hintText: 'タスク名を入力'),
            onSubmitted: (value) async {
              Navigator.pop(context);
              await taskViewModel.addTask(value, selectedDueDate.value);
            },
          ),
          const SizedBox(height: 16), // 余白を追加
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateChip(
                date: selectedDueDate.value,
                context: context,
                onSelected: (selected) {
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
                              changeDueDate(date);
                            },
                          ),
                        ],
                      )));
                    },
                  );
                },
                onDeleted: () => changeDueDate(null),
              ),
              IconButton.filled(
                onPressed: () async {
                  Navigator.pop(context);
                  await taskViewModel.addTask(
                      titleController.text, selectedDueDate.value);
                },
                icon: const Icon(Icons.arrow_forward_rounded),
              ),
            ],
          ),
          const SizedBox(height: 16), // 余白を追加
        ],
      ),
    );
  }
}
