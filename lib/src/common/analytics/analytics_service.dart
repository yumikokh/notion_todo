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
  Future<void> logTask(String action,
      {bool? isCompleted,
      bool? hasDueDate,
      int? pageSize,
      bool? fromUndo}) async {
    final Map<String, Object> parameters = {};
    if (isCompleted != null) parameters['is_completed'] = isCompleted;
    if (hasDueDate != null) parameters['has_due_date'] = hasDueDate;
    if (pageSize != null) parameters['page_size'] = pageSize;
    if (fromUndo != null) parameters['from_undo'] = fromUndo;
    
    await _logEvent(action, parameters: parameters.isNotEmpty ? parameters : null);
  }

  Future<void> logSubscription(String action,
      {Map<String, Object>? parameters}) async {
    await _logEvent(action, parameters: parameters);
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
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(
      name: 'error',
      parameters: {
        'error_name': errorName,
        if (error != null) 'error_message': error.toString(),
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

  Future<void> logNotionAuth({
    required String action,
  }) async {
    await _analytics.logEvent(
      name: 'notion_auth',
      parameters: {'action': action},
    );
  }

  Future<void> _logEvent(String name,
      {Map<String, Object>? parameters}) async {
    await _analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}
