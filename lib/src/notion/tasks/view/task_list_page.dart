import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../settings/settings_view.dart';
import '../task_viewmodel.dart';

class TodayListPage extends HookConsumerWidget {
  const TodayListPage({Key? key}) : super(key: key);

  static const routeName = '/tasks/today';

  @override
  Widget build(BuildContext context, ref) {
    // final taskService = ref.watch(taskServiceProvider);
    // final tasks = ref.watch(taskService).fetchTasks();
    // final tasks = [const Task(id: 'hoge', title: 'title')];

    final tasks = ref.watch(taskViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        actions: [
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
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  trailing: Checkbox(
                    value: true,
                    // value: task.isCompleted,
                    onChanged: (value) {
                      // taskService.updateTask(task.id, isCompleted: value!);
                    },
                  ),
                );
              },
            ),
    );
  }
}
