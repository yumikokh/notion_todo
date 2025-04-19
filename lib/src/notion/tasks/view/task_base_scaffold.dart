import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../helpers/haptic_helper.dart';
import '../../../settings/view/settings_page.dart';
import '../../model/task.dart';
import 'task_sheet/task_sheet.dart';

class TaskBaseScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final bool? showCompleted;
  final bool showSettingBadge;
  final bool hideNavigationLabel;
  final void Function(int) onIndexChanged;
  final void Function(bool) onShowCompletedChanged;
  final void Function(Task, {bool? needSnackbarFloating}) onAddTask;

  const TaskBaseScaffold({
    Key? key,
    required this.body,
    required this.currentIndex,
    required this.showCompleted,
    required this.showSettingBadge,
    required this.hideNavigationLabel,
    required this.onIndexChanged,
    required this.onShowCompletedChanged,
    required this.onAddTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final isToday = currentIndex == 0;
    final showCompleted = this.showCompleted;

    return Scaffold(
        key: key,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: !isToday
                ? Text(l.navigation_index, style: const TextStyle(fontSize: 20))
                : null,
            actions: [
              // TODO: サイドバーができたら移動する
              IconButton(
                icon: showSettingBadge
                    ? Icon(Icons.settings_rounded,
                        color: Theme.of(context).colorScheme.onSurface)
                    : Badge(
                        child: Icon(Icons.settings_outlined,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                onPressed: () {
                  Navigator.restorablePushNamed(
                      context, SettingsPage.routeName);
                },
              ),

              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_horiz_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onSelected: (value) {
                  if (value == 'toggle_completed' && showCompleted != null) {
                    HapticHelper.selection();
                    onShowCompletedChanged(!showCompleted);
                  }
                },
                itemBuilder: (context) => [
                  if (showCompleted != null)
                    PopupMenuItem<String>(
                      value: 'toggle_completed',
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(l.show_completed_tasks),
                          ),
                          if (showCompleted) const Icon(Icons.check, size: 18)
                        ],
                      ),
                    ),
                ],
              ),
            ]),
        body: body,
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            HapticHelper.selection();
            onIndexChanged(index);
          },
          labelBehavior: hideNavigationLabel
              ? NavigationDestinationLabelBehavior.alwaysHide
              : NavigationDestinationLabelBehavior.alwaysShow,
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
        floatingActionButton: !showSettingBadge
            ? null
            : FloatingActionButton(
                onPressed: () {
                  // モーダルを開く
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => TaskSheet(
                      initialTask: Task.temp(
                        dueDate: isToday ? TaskDate.todayAllDay() : null,
                      ),
                      onSubmitted: (task, {bool? needSnackbarFloating}) {
                        onAddTask(task,
                            needSnackbarFloating: needSnackbarFloating);
                      },
                    ),
                  );
                  HapticHelper.light();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(Icons.add, size: 28),
              ));
  }
}
