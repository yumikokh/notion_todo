import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../notion/common/filter_type.dart';
import '../../notion/api/notion_task_api.dart';
import '../../widget/widget_service.dart';
import '../utils/notion_converter.dart';

/// バックグラウンドフェッチ処理を管理するサービスクラス
class BackgroundFetchService {
  /// BackgroundFetchの初期化
  static Future<void> initialize() async {
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
    } catch (e, stackTrace) {
      print("[BackgroundFetch] configure error: $e");
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  /// バックグラウンドフェッチのコールバック
  static void _onBackgroundFetch(String taskId) async {
    print("[BackgroundFetch] Event received: $taskId");
    try {
      await _refreshTodayTasks();
    } catch (e, stackTrace) {
      print("[BackgroundFetch] Error refreshing tasks: $e");
      Sentry.captureException(e, stackTrace: stackTrace);
    }
    BackgroundFetch.finish(taskId);
  }

  /// タイムアウト時のコールバック
  static void _onBackgroundFetchTimeout(String taskId) {
    print("[BackgroundFetch] TIMEOUT: $taskId");
    BackgroundFetch.finish(taskId);
  }

  /// ウィジェットはアプリとは別プロセスで動作するため、Riverpodを使わずに直接データを取得する
  static Future<void> _refreshTodayTasks() async {
    // ウィジェットの更新
    final widgetValue = await WidgetService.value;
    final accessToken = widgetValue.accessToken;
    final taskDatabase = widgetValue.taskDatabase;
    if (accessToken == null || taskDatabase == null) return;
    final repository = NotionTaskApi(accessToken, taskDatabase);
    final result = await repository.fetchPages(FilterType.today, true);
    final tasks = NotionConverter.convertToTasks(result, taskDatabase);
    await WidgetService.applyTasks(tasks);

    // バッジを更新
    final prefs = await SharedPreferences.getInstance();
    final showBadge = prefs.getBool('show_notification_badge') ?? true;
    if (showBadge) {
      final notCompletedCount = tasks.where((task) => !task.isCompleted).length;
      await FlutterAppBadger.updateBadgeCount(notCompletedCount);
    } else {
      await FlutterAppBadger.removeBadge();
    }

    print(
        "[BackgroundFetch] Tasks refreshed successfully: ${tasks.length} tasks");
  }
}
