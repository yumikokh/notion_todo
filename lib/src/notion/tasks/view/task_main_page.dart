import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/date.dart';
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
    final showCompletedTasks = useState(false);

    final todayProvider = taskViewModelProvider(filterType: FilterType.today);
    final allProvider = taskViewModelProvider(filterType: FilterType.all);
    final todayTasks = ref.watch(todayProvider);
    final allTasks = ref.watch(allProvider);
    final syncedNotion =
        ref.watch(taskDatabaseViewModelProvider).valueOrNull != null;

    final taskViewModel = useMemoized(() {
      return currentIndex.value == 0
          ? ref.read(todayProvider.notifier)
          : ref.read(allProvider.notifier);
    }, [currentIndex.value]);

    final notTodaysCompletedCount = useMemoized(
        () =>
            todayTasks.valueOrNull?.where((task) => !task.isCompleted).length ??
            0,
        [todayTasks.valueOrNull]);

    final provider = useMemoized(
        () => currentIndex.value == 0 ? todayProvider : allProvider,
        [currentIndex.value]);

    // ポーリングする
    // TODO: 前回の実行時間を記録して、余分にリクエストしないようにする
    useEffect(() {
      ref.invalidate(provider);
      final timer = Timer.periodic(const Duration(seconds: updateIntervalSec),
          (timer) => ref.invalidate(provider));
      return () => timer.cancel();
    }, [currentIndex.value, provider]);

    // バッジの更新
    useEffect(() {
      FlutterAppBadger.updateBadgeCount(notTodaysCompletedCount);
      return null;
    }, [notTodaysCompletedCount]);

    return TaskBasePage(
      taskViewModel: taskViewModel,
      showCompletedTasks: showCompletedTasks.value,
      setShowCompletedTasks: (value) {
        showCompletedTasks.value = value;
      },
      syncedNotion: syncedNotion,
      currentIndex: currentIndex.value,
      onIndexChanged: (index) {
        currentIndex.value = index;
      },
      body: syncedNotion
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
                      taskViewModel: taskViewModel,
                      showCompletedTasks: showCompletedTasks.value,
                      title: d.formatDateForTitle(DateTime.now()),
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
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
                      taskViewModel: taskViewModel,
                      showCompletedTasks: showCompletedTasks.value,
                      title: null,
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
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
                      const Text('Notionのデータベース設定が必要です'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      Navigator.restorablePushNamed(
                          context, NotionSettingsView.routeName);
                    },
                    child: const Text('設定ページへ'),
                  ),
                ],
              ),
            ),
    );
  }
}
