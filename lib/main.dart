import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:workmanager/workmanager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'src/notion/model/task.dart';
import 'src/notion/model/task_database.dart';
import 'src/notion/model/property.dart';

import 'src/app.dart';
import 'src/common/app_lifecycle_observer.dart';
import 'src/env/env.dart';
import 'src/notion/repository/notion_task_repository.dart';
import 'src/notion/tasks/task_viewmodel.dart';
import 'src/widget/widget_service.dart';
import 'firebase_options.dart';

final widgetService = WidgetService();
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  GoogleFonts.config.allowRuntimeFetching = false;

  const trackingEnabled = kReleaseMode;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAnalytics.instance
      .setAnalyticsCollectionEnabled(trackingEnabled);

  await widgetService.initialize(interactivityCallback);

  final app = ProviderScope(
    observers: trackingEnabled ? [SentryProviderObserver()] : [],
    child: const WorkmanagerInitializer(
      child: MyApp(),
    ),
  );

  if (trackingEnabled) {
    await SentryFlutter.init(
      (options) {
        options.dsn = Env.sentryDsn;
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
        // The sampling rate for profiling is relative to tracesSampleRate
        // Setting to 1.0 will profile 100% of sampled transactions:
        options.profilesSampleRate = 1.0;
        // リプレイのサンプリング率を設定
        options.experimental.replay.sessionSampleRate =
            kReleaseMode ? 0.01 : 0.0;
        options.experimental.replay.onErrorSampleRate =
            kReleaseMode ? 1.0 : 0.0;
      },
      appRunner: () => runApp(app),
    );
  } else {
    runApp(app);
  }

  FlutterNativeSplash.remove();
}

class SentryProviderObserver extends ProviderObserver {
  void handleError(
    ProviderBase provider,
    Object error,
    StackTrace? stackTrace,
    ProviderContainer container,
  ) {
    // 特定のエラーを除外
    if (_shouldIgnoreError(error, provider)) return;

    Sentry.captureException(
      error,
      stackTrace: stackTrace,
      withScope: (scope) {
        scope.setTag(
            'provider', provider.name ?? provider.runtimeType.toString());
      },
    );
  }

  bool _shouldIgnoreError(Object error, ProviderBase provider) {
    // Provider破棄時のStateErrorを無視
    if (error is StateError) {
      return true;
    }

    // BackgroundFetchのPlatformExceptionを無視
    if (error is PlatformException && error.code == '1') {
      return true;
    }

    return false;
  }
}

class WorkmanagerInitializer extends HookConsumerWidget {
  final Widget child;
  const WorkmanagerInitializer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      // Workmanagerの初期化
      Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: !kReleaseMode,
      );

      // 15分ごとのタスク更新を登録
      Workmanager().registerPeriodicTask(
        'com.ymkokh.notionTodo.refreshTasks',
        'refreshTasks',
        frequency: const Duration(minutes: 15),
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
      );

      return null;
    }, []);

    // アプリ復帰時にウィジェットでの更新を反映
    useEffect(() {
      Future<void> applyWidgetChanges() async {
        final lastUpdated = await widgetService.getLastUpdatedTask();
        if (lastUpdated == null) return;
        // 今日のタスクとすべてのタスク両方に適用
        ref.invalidate(taskViewModelProvider(filterType: FilterType.today));
        ref.invalidate(taskViewModelProvider(filterType: FilterType.all));
        await widgetService.clearLastUpdatedTask();
      }

      applyWidgetChanges();

      final observer = AppLifecycleObserver(applyWidgetChanges);
      WidgetsBinding.instance.addObserver(observer);
      return () => WidgetsBinding.instance.removeObserver(observer);
    }, []);

    return child;
  }
}

// Workmanagerのコールバック関数（トップレベルで定義する必要がある）
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    print("[Workmanager] Executing task: $taskName");
    try {
      if (taskName == 'refreshTasks') {
        await _refreshTodayTasks();
      }
      return true;
    } catch (e) {
      print("[Workmanager] Error executing task: $e");
      return false;
    }
  });
}

// タスク更新処理を集約したメソッド
Future<void> _refreshTodayTasks() async {
  // WidgetServiceからアクセストークンとデータベース情報を取得
  final widgetValue = await widgetService.value;
  final accessToken = widgetValue.accessToken;
  final taskDatabase = widgetValue.taskDatabase;

  if (accessToken == null || taskDatabase == null) {
    print("[Workmanager] No access token or task database found");
    return;
  }

  try {
    // リポジトリを初期化
    final repository = NotionTaskRepository(accessToken, taskDatabase);

    // 今日のタスクを取得
    final result = await repository.fetchPages(FilterType.today, true);

    // 結果をTaskオブジェクトに変換
    final tasks = _convertToTasks(result, taskDatabase);

    // ウィジェットを更新
    await widgetService.applyTasks(tasks);

    // バッジを更新
    final notCompletedCount = tasks.where((task) => !task.isCompleted).length;
    await FlutterAppBadger.updateBadgeCount(notCompletedCount);

    print("[Workmanager] Tasks refreshed successfully: ${tasks.length} tasks");
  } catch (e) {
    print("[Workmanager] Error refreshing tasks: $e");
  }
}

// APIレスポンスをTaskオブジェクトに変換するヘルパーメソッド
List<Task> _convertToTasks(
    Map<String, dynamic> result, TaskDatabase taskDatabase) {
  return (result['results'] as List)
      .map((page) => Task(
            id: page['id'],
            title: _extractTitle(page, taskDatabase),
            status: _extractStatus(page, taskDatabase),
            dueDate: _extractDate(page, taskDatabase),
            url: page['url'],
          ))
      .toList();
}

// TaskServiceのヘルパーメソッドをコピー
String _extractTitle(Map<String, dynamic> data, TaskDatabase taskDatabase) {
  final titleProperty = data['properties']
      .entries
      .firstWhere((e) => e.value['type'] == 'title')
      .value['title'];
  return titleProperty?.length > 0 ? titleProperty[0]['plain_text'] : '';
}

TaskDate? _extractDate(Map<String, dynamic> data, TaskDatabase taskDatabase) {
  final dateProperty = taskDatabase.date.name;
  final datePropertyData = data['properties'][dateProperty];
  if (datePropertyData == null) {
    return null;
  }
  final date = datePropertyData['date'];
  if (date == null) {
    return null;
  }
  return TaskDate(
    start: NotionDateTime.fromString(date['start']),
    end: date['end'] != null ? NotionDateTime.fromString(date['end']) : null,
  );
}

TaskStatus _extractStatus(
    Map<String, dynamic> data, TaskDatabase taskDatabase) {
  final property = taskDatabase.status;
  switch (property) {
    case CheckboxCompleteStatusProperty():
      return TaskStatus.checkbox(
          checked: data['properties'][property.name]['checkbox']);
    case StatusCompleteStatusProperty(status: var status):
      // statusが未指定の場合がある
      if (data['properties'][property.name]['status'] == null) {
        return const TaskStatus.status(group: null, option: null);
      }

      final optionId = data['properties'][property.name]['status']['id'];
      final group = status.groups
          .where((group) => group.optionIds.contains(optionId))
          .firstOrNull;
      final option =
          status.options.where((option) => option.id == optionId).firstOrNull;

      return TaskStatus.status(group: group, option: option);
  }
}

// バックグラウンドコールバック関数（iOS 17のインタラクティブウィジェット用）
@pragma('vm:entry-point')
Future<void> interactivityCallback(Uri? uri) async {
  await widgetService.interactivityCallback(uri);
}
