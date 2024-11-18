import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:notion_todo/src/helpers/date.dart';
import 'dart:async';

import '../../../settings/settings_view.dart';
import '../../model/task.dart';
import '../../task_database/task_database_viewmodel.dart';
import '../task_viewmodel.dart';
import 'task_date_sheet.dart';
import 'task_list_tile.dart';
import 'add_task_sheet.dart';

const int updateIntervalSec = 30;

class TodayListPage extends HookConsumerWidget {
  const TodayListPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, ref) {
    final notCompletedTasks = ref.watch(notCompletedTasksProvider);
    final completedTasks = ref.watch(completedTasksProvider);
    final taskViewModel = ref.watch(taskViewModelProvider.notifier);
    final database = ref.watch(taskDatabaseViewModelProvider).taskDatabase;

    final uiNotCompletedTasks = useState<List<Task>>(notCompletedTasks);
    final uiCompletedTasks = useState<List<Task>>(completedTasks);
    final showCompletedTasks = useState(false);
    final loading = useState(false);

    final updateUIList = useCallback((
      Task task,
      bool willComplete,
    ) {
      uiNotCompletedTasks.value = willComplete
          ? uiNotCompletedTasks.value.where((t) => t.id != task.id).toList()
          : [...uiNotCompletedTasks.value, task.copyWith(isCompleted: false)];

      uiCompletedTasks.value = willComplete
          ? [...uiCompletedTasks.value, task.copyWith(isCompleted: true)]
          : uiCompletedTasks.value.where((t) => t.id != task.id).toList();
    }, [uiNotCompletedTasks]);

    // ポーリングする
    useEffect(() {
      taskViewModel.fetchTasks();
      // final timer = Timer.periodic(const Duration(seconds: updateIntervalSec),
      //     (timer) => taskViewModel.fetchTasks());
      // return () => timer.cancel();
    }, []);

    // 即時反映のための表示用のstateを更新
    useEffect(() {
      uiNotCompletedTasks.value = notCompletedTasks;
      uiCompletedTasks.value = completedTasks;
      return null;
    }, [notCompletedTasks, completedTasks]);

    // バッジの更新
    useEffect(() {
      FlutterAppBadger.updateBadgeCount(uiNotCompletedTasks.value.length);
      return null;
    }, [uiNotCompletedTasks.value.length]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                taskViewModel.fetchTasks();
              }),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: uiNotCompletedTasks.value.isEmpty && uiCompletedTasks.value.isEmpty
          ? const Center(child: Text('No tasks'))
          : ListView(
              children: [
                ...uiNotCompletedTasks.value.map((task) {
                  return Dismissible(
                    key: Key(task.id),
                    direction: DismissDirection.horizontal,
                    dismissThresholds: const {
                      DismissDirection.startToEnd: 0.5, // delete
                      DismissDirection.endToStart: 0.2, // edit
                    },
                    resizeDuration: null,
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        taskViewModel.deleteTask(task.id);
                        uiNotCompletedTasks.value = uiNotCompletedTasks.value
                            .where((t) => t.id != task.id)
                            .toList();
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
                      }
                    },
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        // 日時編集の処理を追加
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox.expand(
                                child: Center(
                                    child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TaskDateSheet(
                                  selectedDate: task.dueDate?.start == null
                                      ? null
                                      : DateTime.parse(task.dueDate!.start)
                                          .toLocal(),
                                  onSelected: (DateTime? date) async {
                                    final newTask = task.copyWith(
                                        dueDate: date == null
                                            ? null
                                            : TaskDate(
                                                start: dateString(date)));
                                    uiNotCompletedTasks.value =
                                        uiNotCompletedTasks.value.where((t) {
                                      if (t.id == task.id) {
                                        return isToday(date);
                                      }
                                      return true;
                                    }).toList();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('「${task.title}」が変更されました'),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            taskViewModel.updateTask(task);
                                          },
                                        ),
                                      ),
                                    );
                                    await taskViewModel.updateTask(newTask);
                                  },
                                ),
                              ],
                            )));
                          },
                        );
                        return false;
                      }
                      if (direction == DismissDirection.startToEnd) {
                        return true;
                      }
                      return false;
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      color: Colors.orange,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:
                          const Icon(Icons.edit_calendar, color: Colors.white),
                    ),
                    child: TaskListTile(
                        task: task,
                        loading: loading,
                        updateUITasks: updateUIList,
                        taskViewModel: taskViewModel),
                  );
                }).toList(),
                if (showCompletedTasks.value &&
                    uiCompletedTasks.value.isNotEmpty)
                  ...uiCompletedTasks.value.map((task) {
                    return TaskListTile(
                        task: task,
                        loading: loading,
                        updateUITasks: updateUIList,
                        taskViewModel: taskViewModel);
                  }).toList(),
              ],
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              showCompletedTasks.value = !showCompletedTasks.value;
            },
            backgroundColor: Colors.blue,
            child: Icon(showCompletedTasks.value
                ? Icons.visibility_off
                : Icons.visibility),
          ),
          const SizedBox(height: 10),
          if (database?.id != null)
            FloatingActionButton(
              onPressed: () {
                // モーダルを開く
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    // テキスト表示
                    return const SizedBox.expand(
                        child: Center(
                            child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AddTaskSheet(),
                      ],
                    )));
                  },
                );
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: const BorderSide(color: Colors.black, width: 3),
              ),
              child: const Icon(Icons.add, size: 28),
            ),
        ],
      ),
    );
  }
}
