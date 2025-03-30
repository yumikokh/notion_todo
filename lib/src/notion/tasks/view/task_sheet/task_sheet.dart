import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/task.dart';
import '../../../model/property.dart';
import '../../../../helpers/haptic_helper.dart';
import 'date_chip.dart';
import 'priority_chip.dart';
import 'task_date_sheet.dart';
import 'task_priority_sheet.dart';
import '../../../../settings/settings_viewmodel.dart';

class TaskSheet extends HookConsumerWidget {
  final Task initialTask;
  final Function(Task task, {bool? needSnackbarFloating}) onSubmitted;
  final Function()? onDeleted;

  const TaskSheet({
    Key? key,
    required this.initialTask,
    required this.onSubmitted,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController(text: initialTask.title);
    final focusNode = useFocusNode();
    final selectedDueDate = useState<TaskDate?>(initialTask.dueDate);
    final selectedPriority = useState<SelectOption?>(initialTask.priority);
    final isValidTitle = useState<bool>(initialTask.title.isNotEmpty);
    final l = AppLocalizations.of(context)!;
    final isNewTask = initialTask.isTemp;
    final continuousTaskAddition =
        ref.watch(settingsViewModelProvider).continuousTaskAddition;

    useEffect(() {
      void listener() {
        isValidTitle.value = titleController.text.isNotEmpty;
      }

      titleController.addListener(listener);
      return () => titleController.removeListener(listener);
    }, [titleController]);

    final changeSelectedDueDate = useCallback(
      (TaskDate? newDueDate) {
        selectedDueDate.value = newDueDate;
      },
      [selectedDueDate],
    );

    final changeSelectedPriority = useCallback(
      (SelectOption? newPriority) {
        selectedPriority.value = newPriority;
      },
      [selectedPriority],
    );

    final submitHandler = useCallback(() {
      final willClose = !isNewTask || !continuousTaskAddition;
      final titleValue = titleController.text;

      if (titleValue.trim().isNotEmpty) {
        HapticHelper.selection();
        final updatedTask = initialTask.copyWith(
          title: titleValue,
          dueDate: selectedDueDate.value,
          priority: selectedPriority.value,
        );
        onSubmitted(updatedTask, needSnackbarFloating: !willClose);
      }

      if (willClose) {
        Navigator.pop(context);
      } else {
        titleController.clear();
        Future.microtask(() => focusNode.requestFocus());
      }
    }, [
      isNewTask,
      continuousTaskAddition,
      context,
      focusNode,
      titleController,
      selectedDueDate,
      selectedPriority,
      onSubmitted,
      initialTask,
    ]);

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                focusNode: focusNode,
                autofocus: isNewTask,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: l.task_sheet_title_hint,
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
                onEditingComplete: submitHandler,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
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
                                  onSelected: (TaskDate? date) {
                                    changeSelectedDueDate(date);
                                  },
                                ),
                              );
                            },
                            onDeleted: () {
                              changeSelectedDueDate(null);
                            },
                          ),
                          const SizedBox(width: 8),
                          PriorityChip(
                            priority: selectedPriority.value,
                            context: context,
                            onSelected: (selected) {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                context: context,
                                builder: (context) => TaskPrioritySheet(
                                  selectedPriority: selectedPriority.value,
                                  onSelected: (SelectOption? priority) {
                                    changeSelectedPriority(priority);
                                  },
                                ),
                              );
                            },
                            onDeleted: () {
                              changeSelectedPriority(null);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton.filled(
                    onPressed: isValidTitle.value ? submitHandler : null,
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
