import 'package:intl/intl.dart';
import '../common/locale.dart';

class DateHelper {
  static final DateHelper _instance = DateHelper._();
  late AppLocale locale;
  DateTime Function() _now = DateTime.now;

  DateHelper._() : locale = AppLocale.en;
  factory DateHelper() => _instance;

  // テスト用
  void setNow(DateTime now) {
    _now = () => now;
  }

  setup(String locale) {
    this.locale = AppLocale.values.firstWhere(
      (l) => l.name == locale,
      orElse: () => AppLocale.en,
    );
  }

  bool isThisDay(DateTime? a, DateTime? b) {
    final aLocal = a?.toLocal();
    final bLocal = b?.toLocal();
    if (aLocal == null || bLocal == null) {
      return aLocal == bLocal;
    }
    return aLocal.year == bLocal.year &&
        aLocal.month == bLocal.month &&
        aLocal.day == bLocal.day;
  }

  bool isToday(DateTime? date) {
    return isThisDay(date, _now());
  }

  bool isSameDay(DateTime? a, DateTime? b) {
    final aLocal = a?.toLocal();
    final bLocal = b?.toLocal();
    if (aLocal == null || bLocal == null) {
      return aLocal == bLocal;
    }
    return aLocal.year == bLocal.year &&
        aLocal.month == bLocal.month &&
        aLocal.day == bLocal.day;
  }

  DateTime endTimeOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  DateTime startTimeOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 0, 0, 0);
  }

  String dateString(DateTime date) {
    return date.toIso8601String().split('T')[0];
  }

  bool hasTime(String dateTime) {
    return dateTime.contains('T');
  }

  // MEMO: 英語以外対応するときに修正が必要
  String get todayString {
    return locale == AppLocale.ja ? '今日' : 'Today';
  }

  String get yesterdayString {
    return locale == AppLocale.ja ? '昨日' : 'Yesterday';
  }

  String get tomorrowString {
    return locale == AppLocale.ja ? '明日' : 'Tomorrow';
  }

  /// @param dateTime NotionDateTime(UTC)
  String? formatDateTime(DateTime dateTime, bool isAllDay,
      {bool showToday = false, bool showOnlyTime = false}) {
    final parsed = dateTime.toLocal(); // ローカルタイムに変換
    final date = DateTime(parsed.year, parsed.month, parsed.day);
    final now = _now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    String? formatText() {
      if (showOnlyTime && !isAllDay) {
        return "H:mm";
      }
      if (date == today) {
        if (!showToday) {
          return isAllDay ? null : "H:mm";
        }
        return isAllDay ? "'$todayString'" : "'$todayString' H:mm";
      }
      if (date == yesterday) {
        return isAllDay ? "'$yesterdayString'" : "'$yesterdayString' H:mm";
      }
      if (date == tomorrow) {
        return isAllDay ? "'$tomorrowString'" : "'$tomorrowString' H:mm";
      }
      if (date.year == today.year) {
        if (date.month == today.month) {
          return isAllDay ? "d E" : "d E H:mm";
        }
        return isAllDay ? "M/d" : "M/d H:mm";
      }
      return isAllDay ? 'yyyy/M/d' : 'yyyy/M/d H:mm';
    }

    final format = formatText();

    return format != null
        ? DateFormat(format, locale.name).format(parsed.toLocal())
        : null;
  }

  String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format, locale.name).format(date);
  }

  String formatDateForTitle(DateTime date, {String? locale}) {
    final day = DateFormat.E(locale).format(date);
    final dateStr = DateFormat.MMMd(locale).format(date);
    if (locale == 'ja') {
      return '$dateStr ($day)';
    }
    return '$day, $dateStr';
  }
}
