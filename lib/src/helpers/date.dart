import 'package:intl/intl.dart';

import '../common/locale.dart';

class DateHelper {
  static final DateHelper _instance = DateHelper._();
  late AppLocale locale;

  DateHelper._() : locale = AppLocale.en;
  factory DateHelper() => _instance;
  setup(String locale) {
    this.locale = AppLocale.values.firstWhere(
      (l) => l.name == locale,
      orElse: () => AppLocale.en,
    );
  }

  bool isThisDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return a == b;
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool isToday(DateTime? date) {
    return isThisDay(date, DateTime.now());
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

  String? formatDateTime(String dateTime, {bool showToday = false}) {
    final parsed = DateTime.parse(dateTime).toLocal();
    final date = DateTime(parsed.year, parsed.month, parsed.day);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    String? formatText() {
      if (date == today) {
        if (!showToday) {
          return hasTime(dateTime) ? "HH:mm" : null;
        }
        return hasTime(dateTime) ? "'$todayString' HH:mm" : "'$todayString'";
      }
      if (date == yesterday) {
        return hasTime(dateTime)
            ? "'$yesterdayString' HH:mm"
            : "'$yesterdayString'";
      }
      if (date == tomorrow) {
        return hasTime(dateTime)
            ? "'$tomorrowString' HH:mm"
            : "'$tomorrowString'";
      }
      if (date.year == today.year) {
        if (date.month == today.month) {
          return hasTime(dateTime) ? "dd E HH:mm" : "dd E";
        }
        return hasTime(dateTime) ? "MM/dd HH:mm" : "MM/dd";
      }
      return 'yyyy/MM/dd';
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
