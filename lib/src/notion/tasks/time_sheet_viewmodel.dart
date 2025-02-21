import 'package:flutter/foundation.dart';

import '../../helpers/date.dart';
import '../model/task.dart';

class TimeSheetViewModel extends ChangeNotifier {
  final TaskDate? initialDateTime;

  TimeSheetViewModel({
    required this.initialDateTime,
  }) : _selectedDateTime = initialDateTime;

  static final dateHelper = DateHelper();

  TaskDate? _selectedDateTime;
  TaskDate? get selectedDateTime => _selectedDateTime;
  DateTime? get selectedStartDateTime =>
      _selectedDateTime?.start.datetime.toLocal();
  DateTime? get selectedEndDateTime =>
      _selectedDateTime?.end?.datetime.toLocal();

  void handleStartTimeSelected(DateTime time) {
    final currentStart = _selectedDateTime?.start;
    if (currentStart == null) return;

    _selectedDateTime = _selectedDateTime?.copyWith(
      start: currentStart.copyWith(
        datetime: DateTime(
          currentStart.datetime.year,
          currentStart.datetime.month,
          currentStart.datetime.day,
          time.hour,
          time.minute,
        ),
      ),
    );
    notifyListeners();
  }

  void handleEndTimeSelected(DateTime time) {
    final selectedDateTime = _selectedDateTime;
    final currentEnd = selectedDateTime?.end;
    if (selectedDateTime == null || currentEnd == null) return;

    _selectedDateTime = selectedDateTime.copyWith(
      end: currentEnd.copyWith(
        datetime: DateTime(
          currentEnd.datetime.year,
          currentEnd.datetime.month,
          currentEnd.datetime.day,
          time.hour,
          time.minute,
        ),
      ),
    );
    notifyListeners();
  }

  void handleDurationSelected(Duration duration) {
    final end = _selectedDateTime?.start.datetime.add(duration);
    if (end == null) return;

    _selectedDateTime = _selectedDateTime?.copyWith(
      end: _selectedDateTime?.end?.copyWith(
        datetime: end,
      ),
    );

    notifyListeners();
  }

  void clearTime() {
    final selectedDateTime = _selectedDateTime;
    if (selectedDateTime == null) return;

    final start = selectedDateTime.start.datetime.toLocal();
    final end = selectedDateTime.end?.datetime.toLocal();

    _selectedDateTime = selectedDateTime.copyWith(
      start: selectedDateTime.start.copyWith(
        datetime: DateTime(
          start.year,
          start.month,
          start.day,
        ),
        isAllDay: true,
      ),
      end: end != null
          ? selectedDateTime.end?.copyWith(
              datetime: DateTime(
                end.year,
                end.month,
                end.day,
              ),
              isAllDay: true,
            )
          : null,
    );

    notifyListeners();
  }
}
