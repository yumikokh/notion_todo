import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../settings/settings_view.dart';
import '../../model/task.dart';
import '../../task_database/task_database_viewmodel.dart';
import '../task_viewmodel.dart';

final dateFormat = DateFormat('yyyy-MM-dd');

class TodayListPage extends HookConsumerWidget {
  const TodayListPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, ref) {
    final tasks = ref.watch(taskViewModelProvider);
    final taskViewModel = ref.watch(taskViewModelProvider.notifier);
    final database = ref.watch(taskDatabaseViewModelProvider).taskDatabase;

    final uiTasks = useState<List<Task>>(tasks);
    final waiting = useState(false);

    useEffect(() {
      uiTasks.value = tasks;
      return null;
    }, [tasks]);

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
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
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
                return CheckboxListTile(
                  value: task.isCompleted,
                  title: Text(task.title),
                  // 曜日を表示
                  subtitle: Text(task.dueDate == null
                      ? ''
                      : dateFormat.format(task.dueDate!)),
                  onChanged: (bool? value) async {
                    if (waiting.value) return;
                    waiting.value = true;
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
                      uiTasks.value =
                          uiTasks.value.where((t) => t.id != task.id).toList();
                    }
                    waiting.value = false;
                  },
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
              taskViewModel.addTask(titleController.text, today);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
