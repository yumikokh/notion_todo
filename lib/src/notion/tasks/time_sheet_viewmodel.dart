import 'package:flutter/foundation.dart';

import '../../../../l10n/app_localizations.dart';
import '../../helpers/date.dart';
import '../model/task.dart';

class TimeSheetViewModel extends ChangeNotifier {
  final TaskDate? initialDateTime;
  final AppLocalizations l10n;

  TimeSheetViewModel({
    required this.initialDateTime,
    required this.l10n,
  }) : _selectedDateTime = initialDateTime;

  static final dateHelper = DateHelper();

  static const _durations = [
    Duration(minutes: 15),
    Duration(minutes: 30),
    Duration(minutes: 45),
    Duration(minutes: 60),
    Duration(minutes: 90),
    Duration(minutes: 120),
    Duration(minutes: 240),
    Duration(minutes: 480),
  ];

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

  List<Duration> get durations => _durations;
  List<String> get durationLabels => _durations.map((e) {
        if (e.inHours == 0) {
          return l10n.duration_format_minutes(e.inMinutes);
        } else {
          return e.inMinutes % 60 == 0
              ? l10n.duration_format_hours(e.inHours)
              : l10n.duration_format_hours_minutes(
                  e.inHours, (e.inMinutes % 60));
        }
      }).toList();

  String get startTimeLabel => selectedDateTime != null &&
          selectedDateTime?.start.isAllDay != true
      ? '${selectedStartDateTime!.hour}:${selectedStartDateTime!.minute.toString().padLeft(2, '0')}'
      : l10n.no_time;

  String get durationLabel => (_selectedDateTime?.end != null &&
          _selectedDateTime?.end?.isAllDay != true)
      ? '${currentDuration!.inHours}:${(currentDuration!.inMinutes % 60).toString().padLeft(2, '0')}'
      : l10n.no_time;

  // 次に15分単位になる時間
  DateTime get currentRoundTime {
    final now = DateTime.now();
    final minute = now.minute;
    if (minute <= 15) {
      return DateTime(now.year, now.month, now.day, now.hour, 15);
    } else if (minute <= 30) {
      return DateTime(now.year, now.month, now.day, now.hour, 30);
    } else if (minute <= 45) {
      return DateTime(now.year, now.month, now.day, now.hour, 45);
    } else {
      return DateTime(now.year, now.month, now.day, now.hour + 1, 0);
    }
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
      end: currentDuration != null && currentDuration!.inMinutes > 0
          ? NotionDateTime(
              datetime: start.add(currentDuration!),
              isAllDay: false,
            )
          : null,
    );

    notifyListeners();
  }

  void handleDurationSelected(Duration duration) {
    final start = _selectedDateTime?.start;
    if (start == null || start.isAllDay) return;
    final end = start.datetime.add(duration);

    if (duration.inMinutes == 0) {
      _selectedDateTime = _selectedDateTime?.copyWith(end: null);
    } else {
      _selectedDateTime = _selectedDateTime?.copyWith(
        end: NotionDateTime(
          datetime: end,
          isAllDay: false,
        ),
      );
    }

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
