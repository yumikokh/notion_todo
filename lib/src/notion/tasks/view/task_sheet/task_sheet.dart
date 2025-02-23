import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../model/task.dart';
import 'date_chip.dart';
import 'task_date_sheet.dart';

class TaskSheet extends HookWidget {
  final TaskDate? initialDueDate;
  final String? initialTitle;
  final Function(String title, TaskDate? dueDate) onSubmitted;
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
    final selectedDueDate = useState<TaskDate?>(initialDueDate);
    final isValidTitle = useState<bool>(initialTitle?.isNotEmpty ?? false);
    final l = AppLocalizations.of(context)!;
    final isNewTask = initialTitle == null;

    useEffect(() {
      void listener() {
        isValidTitle.value = titleController.text.isNotEmpty;
      }

      titleController.addListener(listener);
      return () => titleController.removeListener(listener);
    }, [titleController]);

    final changeSelectedDueDate = useCallback(
      (TaskDate? newDueDate) {
        if (newDueDate == null) {
          selectedDueDate.value = null;
          return;
        }
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
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                autofocus: isNewTask,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: l.task_sheet_title_hint,
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    onSubmitted(value, selectedDueDate.value);
                  }
                  if (!isNewTask) {
                    Navigator.pop(context);
                  }
                  titleController.clear();
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DateChip(
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
                              onSelected: (TaskDate? date) {
                                changeSelectedDueDate(date);
                              },
                            ),
                          );
                        },
                        onDeleted: () => changeSelectedDueDate(null),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton.filled(
                    onPressed: isValidTitle.value
                        ? () {
                            onSubmitted(
                                titleController.text, selectedDueDate.value);
                            if (!isNewTask) {
                              Navigator.pop(context);
                            }
                            titleController.clear();
                          }
                        : null,
                    icon: const Icon(Icons.arrow_forward_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
