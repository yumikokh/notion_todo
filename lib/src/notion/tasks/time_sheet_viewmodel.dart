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

  Duration? get currentDuration {
    final start = selectedStartDateTime;
    final end = selectedEndDateTime;
    if (start == null || end == null) return null;
    return end.difference(start);
  }

  void handleStartTimeSelected(DateTime time) {
    final currentStart = _selectedDateTime?.start;
    if (currentStart == null) return;

    final localCurrentStart = currentStart.datetime.toLocal();
    final start = DateTime(
      localCurrentStart.year,
      localCurrentStart.month,
      localCurrentStart.day,
      time.hour,
      time.minute,
    );

    _selectedDateTime = _selectedDateTime?.copyWith(
      start: NotionDateTime(
        datetime: start,
        isAllDay: false,
      ),
      end: currentDuration != null
          ? NotionDateTime(
              datetime: start.add(currentDuration!),
              isAllDay: false,
            )
          : null,
    );

    notifyListeners();
  }

  void handleDurationSelected(Duration duration) {
    final end = _selectedDateTime?.start.datetime.add(duration);
    if (end == null) return;

    _selectedDateTime = _selectedDateTime?.copyWith(
      end: NotionDateTime(
        datetime: end,
        isAllDay: false,
      ),
    );

    notifyListeners();
  }

  void clearStartTime() {
    final start = _selectedDateTime?.start;
    if (start == null) return;

    final localStart = start.datetime.toLocal();
    _selectedDateTime = TaskDate(
      start: NotionDateTime(
        datetime: DateTime(
          localStart.year,
          localStart.month,
          localStart.day,
        ),
        isAllDay: true,
      ),
      end: null,
    );

    notifyListeners();
  }

  void clearDuration() {
    if (_selectedDateTime == null) return;
    _selectedDateTime = _selectedDateTime?.copyWith(end: null);

    notifyListeners();
  }
}
