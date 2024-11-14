import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../task_viewmodel.dart';

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
