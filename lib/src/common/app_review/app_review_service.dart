import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppReviewService {
  AppReviewService._();
  static final instance = AppReviewService._();

  final _inAppReview = InAppReview.instance;
  late final Future<SharedPreferences> _prefsFuture =
      SharedPreferences.getInstance();

  static const _keyLastReviewRequestDate = 'last_review_request_date';
  static const _keyCompletedDaysCount = 'completed_days_count';
  static const _minDaysBetweenRequests = 60; // 次のレビュー要求までの最小日数
  static const _requiredCompletedDays = 3; // レビュー要求に必要な達成回数

  Future<void> incrementCompletedDaysCount() async {
    final prefs = await _prefsFuture;
    final currentCount = prefs.getInt(_keyCompletedDaysCount) ?? 0;
    await prefs.setInt(_keyCompletedDaysCount, currentCount + 1);
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

    final completedDays = prefs.getInt(_keyCompletedDaysCount) ?? 0;
    return completedDays >= _requiredCompletedDays;
  }

  Future<void> requestReview() async {
    final prefs = await _prefsFuture;
    await prefs.setInt(
        _keyLastReviewRequestDate, DateTime.now().millisecondsSinceEpoch);
    await prefs.setInt(_keyCompletedDaysCount, 0); // カウントをリセット
    await _inAppReview.requestReview();
  }

  Future<void> clearLastReviewRequestDate() async {
    final prefs = await _prefsFuture;
    await prefs.remove(_keyLastReviewRequestDate);
    await prefs.remove(_keyCompletedDaysCount);
  }
}
