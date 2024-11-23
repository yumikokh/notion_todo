import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/date.dart';
import '../../repository/notion_database_repository.dart';
import '../../task_database/task_database_viewmodel.dart';
import '../task_viewmodel.dart';
import 'task_list_view.dart';
import 'task_base_page.dart';

const int updateIntervalSec = 30;

class TaskMainPage extends HookConsumerWidget {
  const TaskMainPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, ref) {
    final currentIndex = useState(0);
    final showCompletedTasks = useState(false);

    final todayProvider = taskViewModelProvider(filterType: FilterType.today);
    final allProvider = taskViewModelProvider(filterType: FilterType.all);
    final todayTasks = ref.watch(todayProvider);
    final allTasks = ref.watch(allProvider);

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
      syncedNotion:
          ref.watch(taskDatabaseViewModelProvider).taskDatabase?.id != null,
      currentIndex: currentIndex.value,
      onIndexChanged: (index) {
        currentIndex.value = index;
      },
      body: IndexedStack(
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
                title: formatDate(DateTime.now(), format: 'EE, MMM d'),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text(error.toString())),
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text(error.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
