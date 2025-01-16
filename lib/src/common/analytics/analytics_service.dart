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
      {bool? hasDueDate, bool? isCompleted, int? pageSize}) async {
    final params = {
      if (hasDueDate != null) 'has_due_date': hasDueDate ? 'true' : 'false',
      if (isCompleted != null) 'is_completed': isCompleted ? 'true' : 'false',
      if (pageSize != null) 'page_size': pageSize,
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
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  // 設定関連のイベント
  Future<void> logSettingsChanged({
    required String settingName,
    required String value,
  }) async {
    final params = {
      'setting_name': settingName,
      'value': value,
    };
    await _analytics.logEvent(
      name: 'settings_changed',
      parameters: params,
    );
  }
}
