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
    final isValidTitle = useState<bool>(initialTitle?.isNotEmpty ?? false);

    useEffect(() {
      void listener() {
        isValidTitle.value = titleController.text.isNotEmpty;
      }

      titleController.addListener(listener);
      return () => titleController.removeListener(listener);
    }, [titleController]);

    final changeDueDate = useCallback(
      (DateTime? newDueDate) {
        selectedDueDate.value = newDueDate;
      },
      [selectedDueDate],
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Wrap(children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
          // padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                autofocus: true,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(hintText: 'タスク名を入力'),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    Navigator.pop(context);
                    onSubmitted(value, selectedDueDate.value);
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                DateChip(
                  date: selectedDueDate.value,
                  context: context,
                  onSelected: (selected) {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      context: context,
                      builder: (context) => TaskDateSheet(
                        selectedDate: selectedDueDate.value,
                        onSelected: (DateTime? date) {
                          changeDueDate(date);
                        },
                      ),
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
                      onPressed: isValidTitle.value
                          ? () {
                              Navigator.pop(context);
                              onSubmitted(
                                  titleController.text, selectedDueDate.value);
                            }
                          : null,
                      icon: const Icon(Icons.arrow_forward_rounded),
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ),
      ]),
    );
  }
}
