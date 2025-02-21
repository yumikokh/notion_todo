import 'package:intl/intl.dart';

import '../common/locale.dart';
import '../notion/model/task.dart';

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

  /// @param dateTime NotionDateTime(UTC)
  String? formatDateTime(NotionDateTime dateTime, {bool showToday = false}) {
    final parsed = dateTime.datetime.toLocal(); // ローカルタイムに変換
    final date = DateTime(parsed.year, parsed.month, parsed.day);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    String? formatText() {
      if (date == today) {
        if (!showToday) {
          return dateTime.isAllDay ? null : "HH:mm";
        }
        return dateTime.isAllDay ? "'$todayString'" : "'$todayString' HH:mm";
      }
      if (date == yesterday) {
        return dateTime.isAllDay
            ? "'$yesterdayString'"
            : "'$yesterdayString' HH:mm";
      }
      if (date == tomorrow) {
        return dateTime.isAllDay
            ? "'$tomorrowString'"
            : "'$tomorrowString' HH:mm";
      }
      if (date.year == today.year) {
        if (date.month == today.month) {
          return dateTime.isAllDay ? "dd E" : "dd E HH:mm";
        }
        return dateTime.isAllDay ? "MM/dd" : "MM/dd HH:mm";
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
