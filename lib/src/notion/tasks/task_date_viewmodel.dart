import 'package:flutter/foundation.dart';

import '../model/task.dart';

class TaskDateViewModel extends ChangeNotifier {
  final TaskDate? initialDateTime;

  TaskDateViewModel({
    required this.initialDateTime,
  }) : _focusedDay = initialDateTime?.start.datetime ?? DateTime.now() {
    _selectedDateTime = initialDateTime;
  }

  TaskDate? _selectedDateTime;
  TaskDate? get selectedDateTime => _selectedDateTime;
  DateTime? get selectedStartDateTime =>
      _selectedDateTime?.start.datetime.toLocal();
  DateTime? get selectedEndDateTime =>
      _selectedDateTime?.end?.datetime.toLocal();

  DateTime _focusedDay;
  DateTime get focusedDay => _focusedDay;

  void handleSegmentChanged(Set<Object?> selectedSet) {
    TaskDate? date;
    print(selectedSet);
    final first = selectedSet.first;
    if (first == null) {
      date = null;
    }
    if (first is String) {
      date = TaskDate(
        start: NotionDateTime.fromString(first),
        end: null,
      );
    }
    _selectedDateTime = date;
    _focusedDay = date?.start.datetime ?? DateTime.now();
    notifyListeners();
  }

  void handleCalendarSelected(DateTime date, DateTime focusedDate) {
    _selectedDateTime = TaskDate(
      start: NotionDateTime(
        datetime: date,
        isAllDay: true,
      ),
      end: null,
    );
    _focusedDay = focusedDate;
    notifyListeners();
  }

  DateTime getFirstDay() {
    final now = DateTime.now();
    return initialDateTime == null
        ? now
        : initialDateTime!.start.datetime.isBefore(now)
            ? initialDateTime!.start.datetime
            : now;
  }
}
