import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/task.dart';
import '../../../model/property.dart';
import '../../../../helpers/haptic_helper.dart';
import '../../../../settings/task_database/task_database_viewmodel.dart';
import 'date_chip.dart';
import 'priority_chip.dart';
import 'project_chip.dart';
import 'task_date_sheet.dart';
import 'task_priority_sheet.dart';
import 'task_project_sheet.dart';
import '../../../../settings/settings_viewmodel.dart';

class TaskSheet extends HookConsumerWidget {
  final Task initialTask;
  final Function(Task task, {bool? needSnackbarFloating}) onSubmitted;
  final Function()? onDeleted;

  const TaskSheet({
    super.key,
    required this.initialTask,
    required this.onSubmitted,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController(text: initialTask.title);
    final focusNode = useFocusNode();
    final selectedDueDate = useState<TaskDate?>(initialTask.dueDate);
    final selectedPriority = useState<SelectOption?>(initialTask.priority);
    final selectedProjects = useState<List<RelationOption>?>(initialTask.project);
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

    final changeSelectedProjects = useCallback(
      (List<RelationOption>? newProjects) {
        selectedProjects.value = newProjects;
      },
      [selectedProjects],
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
          project: selectedProjects.value,
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
          padding: const EdgeInsets.fromLTRB(24, 14, 24, 30),
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
                  fontSize: 20,
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
                            onSelected: (selected) async {
                              final taskDatabase = await ref
                                  .read(taskDatabaseViewModelProvider.future);
                              if (taskDatabase?.priority == null) {
                                if (context.mounted) {
                                  await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(l.task_priority_dialog_title,
                                          style: const TextStyle(fontSize: 18)),
                                      content:
                                          Text(l.task_priority_dialog_content),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                              l.task_priority_dialog_cancel),
                                        ),
                                        FilledButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.pushNamed(context,
                                                '/settings/task_database');
                                          },
                                          child: Text(
                                              l.task_priority_dialog_settings),
                                        ),
                                      ],
                                    ),
                                  );
                                  return;
                                }
                              } else if (context.mounted) {
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
                              }
                            },
                            onDeleted: () {
                              changeSelectedPriority(null);
                            },
                          ),
                          const SizedBox(width: 8),
                          ProjectChip(
                            projects: selectedProjects.value,
                            context: context,
                            onSelected: (selected) async {
                              final taskDatabase = await ref
                                  .read(taskDatabaseViewModelProvider.future);
                              if (taskDatabase?.project == null) {
                                if (context.mounted) {
                                  await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(l.not_found_property,
                                          style: const TextStyle(fontSize: 18)),
                                      content: Text(l.project_property_description),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(l.cancel),
                                        ),
                                        FilledButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.pushNamed(context,
                                                '/settings/task_database');
                                          },
                                          child: Text(l.go_to_settings),
                                        ),
                                      ],
                                    ),
                                  );
                                  return;
                                }
                              } else if (context.mounted) {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  context: context,
                                  builder: (context) => TaskProjectSheet(
                                    selectedProjects: selectedProjects.value,
                                    onSelected: (List<RelationOption>? projects) {
                                      changeSelectedProjects(projects);
                                    },
                                  ),
                                );
                              }
                            },
                            onDeleted: () {
                              changeSelectedProjects(null);
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
