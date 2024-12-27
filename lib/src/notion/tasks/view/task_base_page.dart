import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../settings/view/settings_view.dart';
import '../../repository/notion_task_repository.dart';
import '../task_viewmodel.dart';
import 'task_sheet/task_sheet.dart';

class TaskBasePage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: currentIndex == 1 ? Text(l.navigation_index) : null,
          actions: [
            IconButton(
              icon: Icon(
                showCompletedTasks
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_outlined,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                setShowCompletedTasks(!showCompletedTasks);
              },
            ),
            Stack(
              children: [
                IconButton(
                  icon: syncedNotion
                      ? Icon(Icons.settings_outlined,
                          color: Theme.of(context).colorScheme.onSurface)
                      : Badge(
                          child: Icon(Icons.settings_outlined,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                  onPressed: () {
                    Navigator.restorablePushNamed(
                        context, SettingsView.routeName);
                  },
                ),
              ],
            ),
          ],
        ),
        body: body,
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: onIndexChanged,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.today_outlined),
              selectedIcon: const Icon(Icons.today_rounded),
              label: l.navigation_today,
            ),
            NavigationDestination(
              icon: const Icon(Icons.inbox_outlined),
              selectedIcon: const Icon(Icons.inbox_rounded),
              label: l.navigation_index,
            ),
          ],
        ),
        floatingActionButton: !syncedNotion
            ? null
            : FloatingActionButton(
                onPressed: () {
                  // モーダルを開く
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    context: context,
                    builder: (context) => TaskSheet(
                      initialDueDate:
                          taskViewModel.filterType == FilterType.today
                              ? DateTime.now()
                              : null,
                      initialTitle: null,
                      onSubmitted: (title, dueDate) {
                        taskViewModel.addTask(title, dueDate);
                      },
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(Icons.add, size: 28),
              ));
  }
}
