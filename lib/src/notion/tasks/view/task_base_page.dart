import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../settings/settings_view.dart';
import '../task_viewmodel.dart';
import 'add_task_sheet.dart';

class TaskBasePage extends HookConsumerWidget {
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onIndexChanged;
  final bool showCompletedTasks;
  final Function(bool) setShowCompletedTasks;
  final bool syncedNotion;
  final Function() onRefresh;
  final TaskViewModel taskViewModel;

  const TaskBasePage(
      {Key? key,
      required this.body,
      required this.currentIndex,
      required this.onIndexChanged,
      required this.showCompletedTasks,
      required this.setShowCompletedTasks,
      required this.syncedNotion,
      required this.onRefresh,
      required this.taskViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentIndex == 0 ? 'Today' : 'Index'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onRefresh,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onIndexChanged,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Index',
          ),
        ],
      ),
      floatingActionButton: syncedNotion
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setShowCompletedTasks(!showCompletedTasks);
                  },
                  backgroundColor: Colors.blue,
                  child: Icon(showCompletedTasks
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {
                    // モーダルを開く
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        // テキスト表示
                        return SizedBox.expand(
                            child: Center(
                                child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            AddTaskSheet(
                              taskViewModel: taskViewModel,
                            ),
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
            )
          : null,
    );
  }
}
