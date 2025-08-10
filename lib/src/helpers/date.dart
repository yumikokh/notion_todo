import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/locale.dart';
import '../../generated/app_localizations.dart';

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

  String todayString(BuildContext context) {
    return AppLocalizations.of(context)!.today;
  }

  String yesterdayString(BuildContext context) {
    return AppLocalizations.of(context)!.yesterday;
  }

  String tomorrowString(BuildContext context) {
    return AppLocalizations.of(context)!.tomorrow;
  }

  /// @param dateTime NotionDateTime(UTC)
  String? formatDateTime(DateTime dateTime, bool isAllDay, BuildContext context,
      {bool showToday = false, bool showOnlyTime = false}) {
    final parsed = dateTime.toLocal(); // ローカルタイムに変換
    final date = DateTime(parsed.year, parsed.month, parsed.day);
    final now = _now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final currentLocale = locale.name;

    String? formatText() {
      if (showOnlyTime && !isAllDay) {
        return "H:mm";
      }
      if (date == today) {
        if (!showToday) {
          return isAllDay ? null : "H:mm";
        }
        return isAllDay
            ? "'${todayString(context)}'"
            : "'${todayString(context)}' H:mm";
      }
      if (date == yesterday) {
        return isAllDay
            ? "'${yesterdayString(context)}'"
            : "'${yesterdayString(context)}' H:mm";
      }
      if (date == tomorrow) {
        return isAllDay
            ? "'${tomorrowString(context)}'"
            : "'${tomorrowString(context)}' H:mm";
      }
      // これから1週間以内の日付（曜日のみ）
      final daysDifference = date.difference(today).inDays;
      if (daysDifference >= 0 && daysDifference <= 6) {
        // ドイツ語の場合、"E H:mm"フォーマットで自動的にピリオドが付くのでそのまま使用
        return isAllDay ? "E" : "E H:mm";
      }
      if (date.year == today.year) {
        // 同じ年の異なる月
        if (currentLocale.startsWith('ko')) {
          return isAllDay ? "M월d일" : "M월d일 H:mm";
        } else if (currentLocale.startsWith('zh')) {
          return isAllDay ? "M月d日" : "M月d日 H:mm";
        } else if (currentLocale == 'es' || currentLocale == 'fr') {
          return isAllDay ? "d MMM" : "d MMM H:mm";
        } else if (currentLocale == 'de') {
          return isAllDay ? "d. MMM" : "d. MMM H:mm";
        } else if (currentLocale == 'ja') {
          return isAllDay ? "M月d日" : "M月d日 H:mm";
        } else {
          return isAllDay ? "MMM d" : "MMM d H:mm";
        }
      }
      // 異なる年
      if (currentLocale.startsWith('ko')) {
        return isAllDay ? "yyyy. M. d." : "yyyy. M. d. H:mm";
      } else if (currentLocale.startsWith('zh') || currentLocale == 'ja') {
        return isAllDay ? "yyyy年M月d日" : "yyyy年M月d日 H:mm";
      } else if (currentLocale == 'es' || currentLocale == 'fr') {
        return isAllDay ? "d/M/yyyy" : "d/M/yyyy H:mm";
      } else if (currentLocale == 'de') {
        return isAllDay ? "d.M.yyyy" : "d.M.yyyy H:mm";
      } else {
        return isAllDay ? "M/d/yyyy" : "M/d/yyyy H:mm";
      }
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
    final localeStr = locale ?? this.locale.name;
    final day = DateFormat.E(localeStr).format(date);

    if (localeStr == 'ja') {
      final dateStr = DateFormat.MMMd(localeStr).format(date);
      return '$dateStr ($day)';
    } else if (localeStr.startsWith('ko')) {
      final dateStr = DateFormat('M월 d일', localeStr).format(date);
      final fullDay = DateFormat.EEEE(localeStr).format(date);
      return '$dateStr ($fullDay)';
    } else if (localeStr.startsWith('zh')) {
      final dateStr = DateFormat('M月d日', localeStr).format(date);
      final fullDay = DateFormat.EEEE(localeStr).format(date);
      return '$dateStr $fullDay';
    } else if (localeStr == 'es') {
      final dateStr = DateFormat('d \'de\' MMMM', localeStr).format(date);
      final fullDay = DateFormat.EEEE(localeStr).format(date);
      return '${fullDay.substring(0, 1).toUpperCase()}${fullDay.substring(1)}, $dateStr';
    } else if (localeStr == 'fr') {
      final dateStr = DateFormat('d MMMM', localeStr).format(date);
      final fullDay = DateFormat.EEEE(localeStr).format(date);
      return '${fullDay.substring(0, 1).toUpperCase()}${fullDay.substring(1)} $dateStr';
    } else if (localeStr == 'de') {
      final dateStr = DateFormat('d. MMMM', localeStr).format(date);
      final fullDay = DateFormat.EEEE(localeStr).format(date);
      return '${fullDay.substring(0, 1).toUpperCase()}${fullDay.substring(1)}, $dateStr';
    } else {
      final dateStr = DateFormat.MMMd(localeStr).format(date);
      return '$day, $dateStr';
    }
  }
}
