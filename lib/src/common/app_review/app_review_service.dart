import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppReviewService {
  AppReviewService._();
  static final instance = AppReviewService._();

  final _inAppReview = InAppReview.instance;
  late final Future<SharedPreferences> _prefsFuture =
      SharedPreferences.getInstance();

  static const _keyLastReviewRequestDate = 'last_review_request_date';
  static const _keyCompletedTaskCount = 'completed_task_count';
  static const _minDaysBetweenRequests = 60; // 次のレビュー要求までの最小日数
  static const _minCompletedTasksForRequest = 15; // レビュー要求に必要な最小タスク完了数

  Future<void> incrementCompletedTaskCount() async {
    final prefs = await _prefsFuture;
    final currentCount = prefs.getInt(_keyCompletedTaskCount) ?? 0;
    await prefs.setInt(_keyCompletedTaskCount, currentCount + 1);
  }

  Future<bool> shouldRequestReview() async {
    if (!await _inAppReview.isAvailable()) {
      return false;
    }

    final prefs = await _prefsFuture;
    final lastRequestDate = DateTime.fromMillisecondsSinceEpoch(
      prefs.getInt(_keyLastReviewRequestDate) ?? 0,
    );
    final daysSinceLastRequest =
        DateTime.now().difference(lastRequestDate).inDays;

    if (daysSinceLastRequest < _minDaysBetweenRequests) {
      return false;
    }

    final completedTasks = prefs.getInt(_keyCompletedTaskCount) ?? 0;
    return completedTasks >= _minCompletedTasksForRequest;
  }

  Future<void> requestReview() async {
    final prefs = await _prefsFuture;
    await prefs.setInt(
        _keyLastReviewRequestDate, DateTime.now().millisecondsSinceEpoch);
    await prefs.setInt(_keyCompletedTaskCount, 0); // カウントをリセット
    await _inAppReview.requestReview();
  }
}
