bool isThisDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return a == b;
  }
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

DateTime endTimeOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day, 23, 59, 59);
}
