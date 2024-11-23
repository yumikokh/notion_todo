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
  final TaskViewModel taskViewModel;

  const TaskBasePage(
      {Key? key,
      required this.body,
      required this.currentIndex,
      required this.onIndexChanged,
      required this.showCompletedTasks,
      required this.setShowCompletedTasks,
      required this.syncedNotion,
      required this.taskViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: currentIndex == 1
              ? const Text('Index',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                      fontSize: 20))
              : null,
          actions: [
            IconButton(
              icon: Icon(
                  showCompletedTasks
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_outlined,
                  color: Colors.black45),
              onPressed: () {
                setShowCompletedTasks(!showCompletedTasks);
              },
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.settings_outlined,
                      color: Colors.black45),
                  onPressed: () {
                    Navigator.restorablePushNamed(
                        context, SettingsView.routeName);
                  },
                ),
                if (!syncedNotion)
                  const Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.red,
                    ),
                  ),
              ],
            ),
          ],
        ),
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onIndexChanged,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.today_rounded),
              label: 'Today',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inbox_rounded),
              label: 'Index',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
        ),
        floatingActionButton: !syncedNotion
            ? null
            : FloatingActionButton(
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
              ));
  }
}
