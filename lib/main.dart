import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/common/utils/notion_converter.dart';
import 'src/app.dart';
import 'src/env/env.dart';
import 'src/notion/repository/notion_task_repository.dart';
import 'src/widget/widget_service.dart';
import 'firebase_options.dart';

// バックグラウンドコールバック関数（iOS 17のインタラクティブウィジェット用）
@pragma('vm:entry-point')
Future<void> interactivityCallback(Uri? uri) async {
  await WidgetService.interactivityCallback(uri);
}

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

  // ウィジェットの初期化
  await WidgetService.initialize(interactivityCallback);

  // BackgroundFetchの初期化
  await initBackgroundFetch();

  final app = ProviderScope(
    observers: trackingEnabled ? [SentryProviderObserver()] : [],
    child: const MyApp(),
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

// BackgroundFetchの初期化
Future<void> initBackgroundFetch() async {
  try {
    // バックグラウンドフェッチの設定
    var status = await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15, // 15分間隔
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        startOnBoot: true,
      ),
      _onBackgroundFetch,
      _onBackgroundFetchTimeout,
    );
    print("[BackgroundFetch] configure success: $status");

    // バックグラウンドフェッチの開始
    BackgroundFetch.start();
  } catch (e) {
    print("[BackgroundFetch] configure error: $e");
  }
}

// バックグラウンドフェッチのコールバック
void _onBackgroundFetch(String taskId) async {
  print("[BackgroundFetch] Event received: $taskId");
  await _refreshTodayTasks();
  BackgroundFetch.finish(taskId);
}

// タイムアウト時のコールバック
void _onBackgroundFetchTimeout(String taskId) {
  print("[BackgroundFetch] TIMEOUT: $taskId");
  BackgroundFetch.finish(taskId);
}

// ウィジェットはアプリとは別プロセスで動作するため、Riverpodを使わずに直接データを取得する
Future<void> _refreshTodayTasks() async {
  // ウィジェットの更新
  final widgetValue = await WidgetService.value;
  final accessToken = widgetValue.accessToken;
  final taskDatabase = widgetValue.taskDatabase;
  if (accessToken != null && taskDatabase != null) {
    try {
      final repository = NotionTaskRepository(accessToken, taskDatabase);
      final result = await repository.fetchPages(FilterType.today, true);
      final tasks = NotionConverter.convertToTasks(result, taskDatabase);
      await WidgetService.applyTasks(tasks);

      // バッジを更新
      final prefs = await SharedPreferences.getInstance();
      final showBadge = prefs.getBool('show_notification_badge') ?? true;
      if (showBadge) {
        final notCompletedCount =
            tasks.where((task) => !task.isCompleted).length;
        await FlutterAppBadger.updateBadgeCount(notCompletedCount);
      } else {
        await FlutterAppBadger.removeBadge();
      }

      print(
          "[BackgroundFetch] Tasks refreshed successfully: ${tasks.length} tasks");
    } catch (e) {
      print("[BackgroundFetch] Error refreshing tasks: $e");
    }
  }
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
