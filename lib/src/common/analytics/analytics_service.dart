import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  final analytics = FirebaseAnalytics.instance;
  return AnalyticsService(analytics);
});

class AnalyticsService {
  final FirebaseAnalytics _analytics;

  AnalyticsService(this._analytics);

  // タスク関連のイベント
  Future<void> logTask(String eventName,
      {bool? hasDueDate,
      bool? isCompleted,
      int? pageSize,
      bool? fromUndo}) async {
    final params = {
      if (hasDueDate != null) 'has_due_date': hasDueDate ? 'true' : 'false',
      if (isCompleted != null) 'is_completed': isCompleted ? 'true' : 'false',
      if (pageSize != null) 'page_size': pageSize,
      if (fromUndo != null) 'is_undo': fromUndo ? 'true' : 'false',
    };
    await _analytics.logEvent(
      name: eventName,
      parameters: params,
    );
  }

  // 画面遷移のイベント
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
    String? value,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
      parameters: {
        if (value != null) 'value': value,
      },
    );
  }

  // 設定関連のイベント
  Future<void> logSettingsChanged({
    required String settingName,
    required String value,
  }) async {
    await _analytics.logEvent(
      name: 'settings_changed',
      parameters: {
        'setting_name': settingName,
        'value': value,
      },
    );
  }

  Future<void> logError(
    String errorName, {
    dynamic error,
    Map<String, dynamic>? parameters,
  }) async {
    await _analytics.logEvent(
      name: 'error',
      parameters: {
        'error_name': errorName,
        'error_message': error?.toString(),
        ...?parameters,
      },
    );
  }

  Future<void> logDatabaseOperation({
    required String action,
    String? statusType,
  }) async {
    final params = {
      'action': action,
      if (statusType != null) 'status_type': statusType,
    };
    await _analytics.logEvent(
      name: 'database_operation',
      parameters: params,
    );
  }

  // 完了済みタスクの表示切り替え
  Future<void> logCompletedTasksToggle({
    required bool isVisible,
    required String screenName,
  }) async {
    final params = {
      'is_visible': isVisible ? 'true' : 'false',
      'screen_name': screenName,
    };
    await _analytics.logEvent(
      name: 'completed_tasks_toggle',
      parameters: params,
    );
  }
}
