import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'dart:async';

import '../../../settings/settings_view.dart';
import '../../model/task.dart';
import '../../task_database/task_database_viewmodel.dart';
import '../task_viewmodel.dart';
import 'task_list_tile.dart';
import 'task_sheet.dart';

const int updateIntervalSec = 30;

class TodayListPage extends HookConsumerWidget {
  const TodayListPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, ref) {
    final tasks = ref.watch(taskViewModelProvider);
    final taskViewModel = ref.watch(taskViewModelProvider.notifier);
    final database = ref.watch(taskDatabaseViewModelProvider).taskDatabase;

    final uiTasks = useState<List<Task>>(tasks);
    final loading = useState(false);

    // ポーリングする
    useEffect(() {
      taskViewModel.fetchTasks();
      final timer = Timer.periodic(const Duration(seconds: updateIntervalSec),
          (timer) => taskViewModel.fetchTasks());
      return () => timer.cancel();
    }, []);

    // 即時反映のための表示用のstateを更新
    useEffect(() {
      uiTasks.value = tasks;
      return null;
    }, [tasks]);

    // バッジの更新
    useEffect(() {
      FlutterAppBadger.updateBadgeCount(uiTasks.value.length);
      return null;
    }, [uiTasks.value.length]);

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
      body: uiTasks.value.isEmpty
          ? const Center(child: Text('No tasks'))
          : ListView.builder(
              itemCount: uiTasks.value.length,
              itemBuilder: (context, index) {
                final task = uiTasks.value[index];
                return Dismissible(
                  key: Key(task.id),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    taskViewModel.deleteTask(task.id);
                    uiTasks.value =
                        uiTasks.value.where((t) => t.id != task.id).toList();
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
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: TaskListTile(
                      task: task,
                      loading: loading,
                      uiTasks: uiTasks,
                      taskViewModel: taskViewModel),
                );
              },
            ),
      // FloatingActionButtonはaccessTokenがあるときだけ表示
      floatingActionButton: database?.id != null
          ? FloatingActionButton(
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
            )
          : null,
    );
  }
}
