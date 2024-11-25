import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'date_chip.dart';
import 'task_date_sheet.dart';

class TaskSheet extends HookWidget {
  final DateTime? initialDueDate;
  final String? initialTitle;
  final Function(String title, DateTime? dueDate) onSubmitted;
  final Function()? onDeleted;

  const TaskSheet({
    Key? key,
    required this.initialDueDate,
    required this.initialTitle,
    required this.onSubmitted,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController(text: initialTitle);
    final selectedDueDate = useState<DateTime?>(initialDueDate);
    final changeDueDate = useCallback(
      (DateTime? newDueDate) {
        selectedDueDate.value = newDueDate;
      },
      [selectedDueDate],
    );

    return Wrap(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(40, 30, 40, 60),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              autofocus: true, // 起動時にフォーカスを設定
              decoration: const InputDecoration(hintText: 'タスク名を入力'),
              onSubmitted: (value) async {
                Navigator.pop(context);
                onSubmitted(value, selectedDueDate.value);
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
                Row(
                  children: [
                    // いったん削除ボタンは非表示
                    // if (onDeleted != null)
                    //   IconButton(
                    //     onPressed: () async {
                    //       Navigator.pop(context);
                    //       onDeleted!();
                    //     },
                    //     icon: const Icon(Icons.delete),
                    //   ),
                    IconButton.filled(
                      onPressed: () async {
                        Navigator.pop(context);
                        onSubmitted(
                            titleController.text, selectedDueDate.value);
                      },
                      icon: const Icon(Icons.arrow_forward_rounded),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16), // 余白を追加
          ],
        ),
      ),
    ]);
  }
}
