import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  final void Function(String, TaskDate?, bool) onAddTask;

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
        appBar: AppBar(
            title: !isToday
                ? Text(l.navigation_index, style: const TextStyle(fontSize: 20))
                : null,
            actions: [
              if (showCompleted != null) ...[
                IconButton(
                  icon: Icon(
                    showCompleted
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_outlined,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {
                    onShowCompletedChanged(!showCompleted);
                  },
                )
              ],
              Stack(
                children: [
                  IconButton(
                    icon: showSettingBadge
                        ? Icon(Icons.settings_outlined,
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
                ],
              ),
            ]),
        body: body,
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: onIndexChanged,
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
                    builder: (context) => TaskSheet(
                      initialDueDate: isToday
                          ? TaskDate(
                              start: NotionDateTime(
                                datetime: DateTime.now(),
                                isAllDay: true,
                              ),
                            )
                          : null,
                      initialTitle: null,
                      onSubmitted: (title, dueDate,
                          {bool? needSnackbarFloating}) {
                        onAddTask(
                            title, dueDate, needSnackbarFloating ?? false);
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
