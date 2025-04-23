import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';

import '../../../common/analytics/analytics_service.dart';
import '../../../helpers/date.dart';
import '../../../helpers/haptic_helper.dart';
import '../../../settings/settings_viewmodel.dart';
import '../../../settings/view/notion_settings_page.dart';
import '../../common/filter_type.dart';
import '../../../settings/task_database/task_database_viewmodel.dart';
import '../task_sort_provider.dart';
import '../task_viewmodel.dart';
import 'task_list_view.dart';
import 'task_base_scaffold.dart';
import '../../../settings/font/font_settings_viewmodel.dart';

const int updateIntervalSec = 60;

class TaskMainPage extends HookConsumerWidget {
  const TaskMainPage({
    Key? key,
    this.initialTab,
  }) : super(key: key);

  static const routeName = '/';
  static final DateHelper d = DateHelper();

  // タブの種類を定義
  static const String tabToday = 'today';
  static const String tabAll = 'all';
  final String? initialTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayProvider = taskViewModelProvider(filterType: FilterType.today);
    final allProvider = taskViewModelProvider(filterType: FilterType.all);
    final todayTasks = ref.watch(todayProvider);
    final allTasks = ref.watch(allProvider);
    final todayViewModel = ref.read(todayProvider.notifier);
    final allViewModel = ref.read(allProvider.notifier);
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider);
    final wakelock = ref.watch(settingsViewModelProvider).wakelock;
    final hideNavigationLabel =
        ref.watch(settingsViewModelProvider).hideNavigationLabel;
    final fontSettings = ref.watch(fontSettingsViewModelProvider);
    final taskSort = ref.watch(taskSortProvider.notifier);

    // initialTabがnullまたはtabTodayの場合はtrue（今日タブを表示）
    final isToday = initialTab == null || initialTab == tabToday;
    final currentIndex = useMemoized(() => isToday ? 0 : 1);
    ref.watch(
        currentSortTypeProvider(isToday ? FilterType.today : FilterType.all));

    final l = AppLocalizations.of(context)!;

    // アナリティクス
    useEffect(() {
      final analytics = ref.read(analyticsServiceProvider);
      final screenName = isToday ? 'Today' : 'All';
      analytics.logScreenView(screenName: screenName);
      return null;
    }, [isToday]);

    // ポーリングする
    useEffect(() {
      final provider = switch (isToday) {
        true => todayProvider,
        false => allProvider,
      };
      ref.invalidate(provider);
      final timer = Timer.periodic(const Duration(seconds: updateIntervalSec),
          (timer) => ref.invalidate(provider));
      return timer.cancel;
    }, [isToday]);

    // スリープを防ぐ
    useEffect(() {
      Future<void> initWakelock() async {
        await WakelockPlus.enabled; // 確実に切り替えるために必要
        switch (wakelock) {
          case true:
            await WakelockPlus.enable();
            final enabled = await WakelockPlus.enabled;
            print('Wakelock enabled: $enabled'); // true であることを確認
          case false:
            await WakelockPlus.disable();
            final enabled = await WakelockPlus.enabled;
            print('Wakelock disabled: $enabled'); // false であることを確認
        }
      }

      initWakelock();
      return WakelockPlus.disable;
    }, [wakelock]);

    return TaskBaseScaffold(
      key: Key('taskMainPage/${isToday ? 'Today' : 'All'}'),
      currentIndex: currentIndex,
      showCompleted: isToday ? todayViewModel.showCompleted : null,
      showSettingBadge: taskDatabase.valueOrNull != null,
      hideNavigationLabel: hideNavigationLabel,
      onIndexChanged: (index) {
        final nextTab = index == 0 ? tabToday : tabAll;
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 0),
            child: TaskMainPage(initialTab: nextTab),
          ),
        );
      },
      onShowCompletedChanged: (value) async {
        todayViewModel.toggleShowCompleted();
      },
      onAddTask: (task, {bool? needSnackbarFloating}) {
        switch (isToday) {
          case true:
            todayViewModel.addTask(
              task,
              needSnackbarFloating: needSnackbarFloating,
            );
          case false:
            allViewModel.addTask(
              task,
              needSnackbarFloating: needSnackbarFloating,
            );
        }
      },
      body: taskDatabase.when(
        data: (db) => db != null
            ? IndexedStack(
                index: currentIndex,
                children: [
                  // Today Tasks
                  TaskRefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(todayProvider);
                    },
                    child: todayTasks.when(
                      data: (tasks) => TaskListView(
                        title: d.formatDateForTitle(DateTime.now(),
                            locale: fontSettings.value?.languageCode),
                        list: taskSort.sortTasks(tasks, FilterType.today),
                        taskViewModel: todayViewModel,
                        showCompleted: todayViewModel.showCompleted,
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) =>
                          Center(child: Text(l.loading_failed)),
                    ),
                  ),
                  // All Tasks
                  TaskRefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(allProvider);
                    },
                    child: allTasks.when(
                      data: (tasks) => TaskListView(
                        list: taskSort.sortTasks(tasks, FilterType.all),
                        taskViewModel: allViewModel,
                        showCompleted: false, // NOTE: Indexページでは常に未完了のみ表示対応
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) =>
                          Center(child: Text(l.loading_failed)),
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.warning_rounded,
                            color: Theme.of(context).colorScheme.secondary),
                        const SizedBox(width: 8),
                        Text(l.notion_database_settings_required),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        Navigator.restorablePushNamed(
                            context, NotionSettingsPage.routeName);
                      },
                      child: Text(l.go_to_settings),
                    ),
                  ],
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(l.loading_failed)),
      ),
    );
  }
}

class TaskRefreshIndicator extends HookWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const TaskRefreshIndicator({
    Key? key,
    required this.child,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasHapticFeedback = useState(false);

    return RefreshIndicator(
      onRefresh: () async {
        await onRefresh();
      },
      color: Theme.of(context).colorScheme.inversePrimary,
      notificationPredicate: (notification) {
        final threshold = notification.metrics.minScrollExtent - 100;
        final isOverThreshold = notification.metrics.pixels <= threshold;

        if (isOverThreshold && !hasHapticFeedback.value) {
          HapticHelper.medium();
          hasHapticFeedback.value = true;
        } else if (!isOverThreshold) {
          hasHapticFeedback.value = false;
        }

        return notification.depth == 0;
      },
      child: child,
    );
  }
}
