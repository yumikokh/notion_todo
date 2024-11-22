import 'package:intl/intl.dart';

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

String? formatDateTime(String dateTime, {bool showToday = false}) {
  final parsed = DateTime.parse(dateTime).toLocal();
  final date = DateTime(parsed.year, parsed.month, parsed.day);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  final hasTime = dateTime.contains('T');

  String? formatText() {
    if (date == today) {
      if (!showToday) {
        return hasTime ? "HH:mm" : null;
      }
      return hasTime ? "'Today' HH:mm" : "'Today'";
    }
    if (date == yesterday) {
      return hasTime ? "'Yesterday' HH:mm" : "'Yesterday'";
    }
    if (date == tomorrow) {
      return hasTime ? "'Tomorrow' HH:mm" : "'Tomorrow'";
    }
    if (date.year == today.year) {
      if (date.month == today.month) {
        return hasTime ? "dd E HH:mm" : "dd E";
      }
      return hasTime ? "MM/dd HH:mm" : "MM/dd";
    }
    return 'yyyy/MM/dd';
  }

  final format = formatText();

  return format != null ? DateFormat(format).format(parsed.toLocal()) : null;
}
