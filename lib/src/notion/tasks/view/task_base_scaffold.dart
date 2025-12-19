import 'package:flutter/material.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../common/analytics/analytics_service.dart';
import '../../../common/ui/custom_popup_menu.dart';
import '../../../helpers/haptic_helper.dart';
import '../../../settings/theme/theme.dart';
import '../../../settings/view/settings_page.dart';
import '../../../subscription/subscription_viewmodel.dart';
import '../../../subscription/view/paywall_sheet.dart';
import '../../common/filter_type.dart';
import '../../model/task.dart';
import '../task_group_provider.dart';
import '../task_sort_provider.dart';
import 'group_options_bottom_sheet.dart';
import 'sort_options_bottom_sheet.dart';
import 'task_sheet/task_sheet.dart';
import 'today_calendar_icon.dart';

class TaskBaseScaffold extends HookConsumerWidget {
  final Widget body;
  final int currentIndex;
  final bool? showCompleted;
  final bool showSettingBadge;
  final bool hideNavigationLabel;
  final void Function(int) onIndexChanged;
  final void Function(bool) onShowCompletedChanged;
  final void Function(Task, {bool? needSnackbarFloating}) onAddTask;

  const TaskBaseScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.showCompleted,
    required this.showSettingBadge,
    required this.hideNavigationLabel,
    required this.onIndexChanged,
    required this.onShowCompletedChanged,
    required this.onAddTask,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final isToday = currentIndex == 0;
    final filterType = isToday ? FilterType.today : FilterType.all;
    final subscriptionStatus =
        ref.watch(subscriptionViewModelProvider).value;
    final analytics = ref.read(analyticsServiceProvider);

    // カスタムメニューの設定
    final customMenu = useCustomPopupMenu(
      items: [
        if (showCompleted != null)
          CustomPopupMenuItem(
            id: 'toggle_completed',
            title: Text(l.show_completed_tasks),
            trailing: showCompleted!
                ? Icon(
                    Icons.check,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
            onTap: () {
              HapticHelper.selection();
              onShowCompletedChanged(!showCompleted!);
            },
          ),
        // 並び替えメニュー
        CustomPopupMenuItem(
          id: 'sort_options',
          title: Text(l.sort_by),
          leading: Icon(
            Icons.sort,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          trailing: Text(
            ref.watch(currentSortTypeProvider(filterType)).getLocalizedName(l),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          onTap: () async {
            HapticHelper.selection();
            await showSortOptionsBottomSheet(context, filterType);
          },
        ),
        // グループメニュー
        CustomPopupMenuItem(
          id: 'group_options',
          title: Text(l.group_by),
          leading: Icon(
            Icons.workspaces_outline,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          trailing: Text(
            ref.watch(currentGroupTypeProvider(filterType)).getLocalizedName(l),
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          onTap: () async {
            HapticHelper.selection();
            await showGroupOptionsBottomSheet(context, filterType);
          },
        ),
      ],
      animationDuration: const Duration(milliseconds: 30),
      animationCurve: Curves.easeOut,
    );

    return Scaffold(
        key: key,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: !isToday
                ? Text(l.navigation_index, style: const TextStyle(fontSize: 20))
                : null,
            actions: [
              if (subscriptionStatus?.isActive == false)
                IconButton(
                  icon: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.warmBeige.color,
                        Theme.of(context)
                            .colorScheme
                            .warmBeige
                            .color
                            .withValues(alpha: 0.4),
                        Theme.of(context).colorScheme.orange.color,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Icon(
                      Icons.diamond,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    analytics.logScreenView(
                        screenName: 'Paywall', value: 'TaskMainPage');
                    PaywallSheet.show(context);
                  },
                ),
              IconButton(
                key: customMenu.buttonKey,
                icon: Icon(
                  Icons.more_horiz_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: customMenu.toggle,
              ),
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
            ]),
        body: body,
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            HapticHelper.selection();
            onIndexChanged(index);
          },
          backgroundColor: Theme.of(context).colorScheme.surface,
          labelBehavior: hideNavigationLabel
              ? NavigationDestinationLabelBehavior.alwaysHide
              : NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: const TodayCalendarIcon(isSelected: false),
              selectedIcon: const TodayCalendarIcon(isSelected: true),
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
