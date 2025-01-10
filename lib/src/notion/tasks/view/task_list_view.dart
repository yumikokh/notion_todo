import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/date.dart';
import '../../../settings/theme/theme.dart';
import '../../model/task.dart';
import '../task_viewmodel.dart';
import 'task_sheet/task_date_sheet.dart';
import 'task_list_tile.dart';

class TaskListView extends HookWidget {
  final List<Task> list;
  final TaskViewModel taskViewModel;
  final bool showCompleted;
  final String? title;

  static final DateHelper d = DateHelper();

  const TaskListView({
    required super.key,
    required this.list,
    required this.taskViewModel,
    required this.showCompleted,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final notCompletedTasks = list.where((task) => !task.isCompleted).toList();
    final completedTasks = list.where((task) => task.isCompleted).toList();
    final loading = taskViewModel.isLoading;

    final l = AppLocalizations.of(context)!;

    return ListView(
      key: key,
      children: [
        if (notCompletedTasks.isEmpty && completedTasks.isEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(child: Text(l.no_task)),
          )
        else if (notCompletedTasks.isEmpty &&
            completedTasks.isNotEmpty &&
            !showCompleted)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(child: Text(l.no_task_description)),
          )
        else ...[
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 20),
              child: Text(
                title!,
                style: GoogleFonts.bodoniModa(
                  fontSize: 28,
                  fontStyle: FontStyle.italic,
                  letterSpacing: -.8,
                ),
              ),
            ),
          ...notCompletedTasks.map((task) {
            return Dismissible(
              key: Key(task.id),
              direction: DismissDirection.horizontal,
              dismissThresholds: const {
                DismissDirection.endToStart: 0.5, // delete
                DismissDirection.startToEnd: 0.2, // edit
              },
              resizeDuration: null,
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  taskViewModel.deleteTask(task);
                }
              },
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  // 日時編集の処理を追加
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    context: context,
                    builder: (context) {
                      return TaskDateSheet(
                        selectedDate: task.dueDate?.start == null
                            ? null
                            : DateTime.parse(task.dueDate!.start).toLocal(),
                        onSelected: (DateTime? date) async {
                          final newTask = task.copyWith(
                              dueDate: date == null
                                  ? null
                                  : TaskDate(start: d.dateString(date)));
                          await taskViewModel.updateTask(newTask);
                        },
                      );
                    },
                  );
                  return false;
                }
                if (direction == DismissDirection.endToStart) {
                  return true;
                }
                return false;
              },
              secondaryBackground: Container(
                color: Theme.of(context).colorScheme.error,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
              background: Container(
                color: MaterialTheme(Theme.of(context).textTheme)
                    .extendedColors[0]
                    .light
                    .colorContainer,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Icons.edit_calendar,
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
              child: Column(
                children: [
                  const Divider(height: 0),
                  TaskListTile(
                    key: Key('${task.id}notCompleted'),
                    task: task,
                    loading: loading,
                    taskViewModel: taskViewModel,
                  ),
                ],
              ),
            );
          }).toList(),
          if (showCompleted && completedTasks.isNotEmpty)
            ...completedTasks.map((task) {
              return Column(
                children: [
                  const Divider(height: 0),
                  TaskListTile(
                    key: Key('${task.id}completed'),
                    task: task,
                    loading: loading,
                    taskViewModel: taskViewModel,
                  ),
                ],
              );
            }).toList(),
          const Divider(height: 0),
          if (taskViewModel.hasMore)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: FilledButton.tonal(
                  onPressed: () async {
                    await taskViewModel.loadMore();
                  },
                  child: Text(l.load_more),
                ),
              ),
            ),
          if (loading)
            const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator.adaptive())),
        ],
      ],
    );
  }
}
