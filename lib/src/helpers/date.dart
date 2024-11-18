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
