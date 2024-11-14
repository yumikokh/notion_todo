import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'dart:async';

import '../../../settings/settings_view.dart';
import '../../model/task.dart';
import '../../task_database/task_database_viewmodel.dart';
import '../task_viewmodel.dart';

final dateFormat = DateFormat('yyyy-MM-dd');

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
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (bool? value) async {
                        if (loading.value) return;
                        loading.value = true;
                        // UI更新
                        uiTasks.value = uiTasks.value
                            .map((t) => t.id == task.id
                                ? task.copyWith(isCompleted: value!)
                                : t)
                            .toList();
                        taskViewModel.updateStatus(task.id, value!);
                        // 時間を置く
                        await Future.delayed(const Duration(milliseconds: 460));
                        // リストから削除
                        if (value == true) {
                          uiTasks.value = uiTasks.value
                              .where((t) => t.id != task.id)
                              .toList();
                        }
                        loading.value = false;
                      },
                    ),
                    title: Text(task.title),
                    // 曜日を表示
                    subtitle: Text(task.dueDate == null
                        ? ''
                        : dateFormat.format(task.dueDate!)),
                  ),
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
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(Icons.add, size: 28),
            )
          : null,
    );
  }
}

class AddTaskSheet extends HookConsumerWidget {
  const AddTaskSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final taskViewModel = ref.watch(taskViewModelProvider.notifier);
    final titleController = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          ElevatedButton(
            onPressed: () {
              final today = DateTime.now();
              final title = titleController.text;
              taskViewModel.addTask(title, today);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('「$title」が追加されました')),
              );
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );
  }
}
