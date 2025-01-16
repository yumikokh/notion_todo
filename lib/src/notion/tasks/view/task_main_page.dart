import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/analytics/analytics_service.dart';
import '../../../helpers/date.dart';
import '../../../settings/settings_viewmodel.dart';
import '../../../settings/view/notion_settings_view.dart';
import '../../repository/notion_task_repository.dart';
import '../../../settings/task_database/task_database_viewmodel.dart';
import '../task_viewmodel.dart';
import 'task_list_view.dart';
import 'task_base_page.dart';

const int updateIntervalSec = 60;

class TaskMainPage extends HookConsumerWidget {
  const TaskMainPage({Key? key}) : super(key: key);

  static const routeName = '/';
  static final DateHelper d = DateHelper();

  @override
  Widget build(BuildContext context, ref) {
    final currentIndex = useState(0);
    final todayProvider = taskViewModelProvider(filterType: FilterType.today);
    final allProvider = taskViewModelProvider(filterType: FilterType.all);
    final todayTasks = ref.watch(todayProvider);
    final allTasks = ref.watch(allProvider);
    final todayViewModel = ref.watch(todayProvider.notifier);
    final allViewModel = ref.watch(allProvider.notifier);
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider);
    final wakelock = ref.watch(settingsViewModelProvider).wakelock;

    final isToday = currentIndex.value == 0;

    final l = AppLocalizations.of(context)!;

    useEffect(() {
      final analytics = ref.read(analyticsServiceProvider);
      final screenName = isToday ? 'Today' : 'All';
      analytics.logScreenView(screenName: screenName);
      return null;
    }, [isToday]);

    // ポーリングする
    // TODO: 前回の実行時間を記録して、余分にリクエストしないようにする
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

    return TaskBasePage(
      key: Key('taskMainPage/${isToday ? 'Today' : 'All'}'),
      currentIndex: currentIndex.value,
      showCompleted: isToday ? todayViewModel.showCompleted : null,
      showSettingBadge: taskDatabase.valueOrNull != null,
      onIndexChanged: (index) {
        currentIndex.value = index;
      },
      onShowCompletedChanged: (value) async {
        todayViewModel.toggleShowCompleted();
      },
      onAddTask: (title, dueDate) {
        switch (isToday) {
          case true:
            todayViewModel.addTask(title, dueDate);
          case false:
            allViewModel.addTask(title, dueDate);
        }
      },
      body: taskDatabase.when(
        data: (db) => db != null
            ? IndexedStack(
                index: currentIndex.value,
                children: [
                  // Today Tasks
                  RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(todayProvider);
                    },
                    color: Theme.of(context).colorScheme.inversePrimary,
                    child: todayTasks.when(
                      data: (tasks) => TaskListView(
                        list: tasks,
                        taskViewModel: todayViewModel,
                        showCompleted: todayViewModel.showCompleted,
                        title: d.formatDateForTitle(DateTime.now()),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) =>
                          Center(child: Text(error.toString())),
                    ),
                  ),
                  // All Tasks
                  RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(allProvider);
                    },
                    color: Theme.of(context).colorScheme.inversePrimary,
                    child: allTasks.when(
                      data: (tasks) => TaskListView(
                        list: tasks,
                        taskViewModel: allViewModel,
                        showCompleted: false, // NOTE: Indexページでは常に未完了のみ表示対応
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) =>
                          Center(child: Text(error.toString())),
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
                            context, NotionSettingsView.routeName);
                      },
                      child: Text(l.go_to_settings),
                    ),
                  ],
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}
