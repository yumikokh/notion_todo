import 'package:intl/intl.dart';

class DateHelper {
  static final DateHelper _instance = DateHelper._();
  late String languageCode;

  DateHelper._() : languageCode = 'en';
  factory DateHelper() => _instance;

  setup(String ln) {
    languageCode = ln;
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
    return date.toIso8601String().split('T').first;
  }

  bool hasTime(String dateTime) {
    return dateTime.contains('T');
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
        return hasTime(dateTime) ? "'Today' HH:mm" : "'Today'";
      }
      if (date == yesterday) {
        return hasTime(dateTime) ? "'Yesterday' HH:mm" : "'Yesterday'";
      }
      if (date == tomorrow) {
        return hasTime(dateTime) ? "'Tomorrow' HH:mm" : "'Tomorrow'";
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
        ? DateFormat(format, languageCode).format(parsed.toLocal())
        : null;
  }

  String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format, languageCode).format(date);
  }
}
