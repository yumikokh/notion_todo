import 'package:flutter/foundation.dart';

import '../../helpers/date.dart';
import '../model/task.dart';

class DateSheetViewModel extends ChangeNotifier {
  final TaskDate? initialDateTime;
  final bool isRescheduleMode; // リスケジュールモード（時間情報を保持しない）

  DateSheetViewModel({
    required this.initialDateTime,
    this.isRescheduleMode = false,
  }) : _focusedDay = initialDateTime?.start.datetime ?? DateTime.now() {
    _selectedDateTime = initialDateTime;
  }

  static final dateHelper = DateHelper();

  TaskDate? _selectedDateTime;
  TaskDate? get selectedDateTime => _selectedDateTime;
  DateTime? get selectedStartDateTime =>
      _selectedDateTime?.start.datetime.toLocal();
  DateTime? get selectedEndDateTime =>
      _selectedDateTime?.end?.datetime.toLocal();

  DateTime _focusedDay;
  DateTime get focusedDay => _focusedDay.toLocal();

  DateTime get calenderFirstDay {
    final initial = initialDateTime;
    final now = DateTime.now();
    if (initial == null) {
      return now;
    }
    return initial.start.datetime.isBefore(now)
        ? initial.start.datetime.toLocal()
        : now;
  }

  DateTime get calenderLastDay {
    return DateTime.now().add(const Duration(days: 365));
  }

  String get selectedSegment {
    final selectedDateTime = _selectedDateTime;
    if (selectedDateTime == null) return 'no-date';
    return selectedDateTime.start.datetime
        .toLocal()
        .toIso8601String()
        .split('T')[0];
  }

  TaskDate? get submitDateForSegment {
    final selectedDateTime = _selectedDateTime;
    if (selectedDateTime == null) return null;

    // リスケジュールモードで時間が設定されている場合は、その時間情報を保持
    if (isRescheduleMode && !selectedDateTime.start.isAllDay) {
      return selectedDateTime;
    }

    return TaskDate(
        start: NotionDateTime(
          datetime: DateTime(
            selectedDateTime.start.datetime.year,
            selectedDateTime.start.datetime.month,
            selectedDateTime.start.datetime.day,
          ),
          isAllDay: true,
        ),
        end: null);
  }

  // セグメントが変更されたときの処理
  void handleSegmentChanged(Set<Object?> selectedSet) {
    TaskDate? date;
    if (selectedSet.isEmpty) return;

    final first = selectedSet.first;
    if (first == 'no-date') {
      date = null;
    } else if (first is String) {
      final start = NotionDateTime.fromString(first);
      final selectedDateTime = _selectedDateTime;
      if (selectedDateTime != null && !selectedDateTime.start.isAllDay) {
        // 時間情報が設定されている場合は保持
        // リスケジュールモードでは初期値の時間は無視するが、新しく設定された時間は保持
        final shouldKeepTime = isRescheduleMode ? 
          (selectedDateTime != initialDateTime) : true;
        
        if (shouldKeepTime) {
          final localTime = selectedDateTime.start.datetime.toLocal();
          final end = selectedDateTime.end;
          final duration =
              end?.datetime.difference(selectedDateTime.start.datetime);
          final newStartDateTime = DateTime(
            start.datetime.year,
            start.datetime.month,
            start.datetime.day,
            localTime.hour,
            localTime.minute,
          );
          final newEnd = duration != null && end != null
              ? NotionDateTime(
                  datetime: newStartDateTime.add(duration),
                  isAllDay: end.isAllDay,
                )
              : null;
          date = TaskDate(
            start: NotionDateTime(
              datetime: newStartDateTime,
              isAllDay: false,
            ),
            end: newEnd,
          );
        } else {
          date = TaskDate(
            start: start,
            end: null,
          );
        }
      } else {
        date = TaskDate(
          start: start,
          end: null,
        );
      }
    }

    _selectedDateTime = date;
    _focusedDay = date?.start.datetime ?? DateTime.now();
    notifyListeners();
  }

  // カレンダーが選択されたときの処理
  void handleCalendarSelected(DateTime date, DateTime focusedDate) {
    final selectedDateTime = _selectedDateTime;
    if (selectedDateTime == null) {
      // 新しい選択の場合は終日で作成
      _selectedDateTime = TaskDate(
        start: NotionDateTime(
          datetime: DateTime(date.year, date.month, date.day),
          isAllDay: true,
        ),
        end: null,
      );
    } else if (isRescheduleMode) {
      // リスケジュールモードの場合は現在選択中の時間情報を保持
      final localDate = selectedDateTime.start.datetime.toLocal();
      final start = NotionDateTime(
        datetime: DateTime(
          date.year,
          date.month,
          date.day,
          localDate.hour,
          localDate.minute,
        ),
        isAllDay: selectedDateTime.start.isAllDay,
      );

      // 終了日がある場合は、現在の間隔を保持
      final end = selectedDateTime.end;
      final duration =
          end?.datetime.difference(selectedDateTime.start.datetime);
      final newEnd = duration != null && end != null
          ? NotionDateTime(
              datetime: start.datetime.add(duration),
              isAllDay: end.isAllDay,
            )
          : null;

      _selectedDateTime = TaskDate(start: start, end: newEnd);
    } else {
      // 通常モードの場合は既存の時間を保持したまま日付のみ更新
      final localDate = selectedDateTime.start.datetime.toLocal();
      final start = selectedDateTime.start.copyWith(
        datetime: DateTime(
          date.year,
          date.month,
          date.day,
          localDate.hour,
          localDate.minute,
        ),
      );

      // 終了日がある場合は、もともとの間隔を保持
      final end = selectedDateTime.end;
      final duration =
          end?.datetime.difference(selectedDateTime.start.datetime);
      final newEnd = duration != null && end != null
          ? NotionDateTime(
              datetime: start.datetime.add(duration),
              isAllDay: end.isAllDay,
            )
          : null;

      _selectedDateTime = TaskDate(start: start, end: newEnd);
    }
    _focusedDay = focusedDate;

    notifyListeners();
  }

  // 選択された日時を更新
  void handleSelectedDateTime(TaskDate date) {
    _selectedDateTime = date;
    _focusedDay = date.start.datetime;

    notifyListeners();
  }

  void clearTime() {
    final selectedDateTime = _selectedDateTime;
    if (selectedDateTime == null) return;
    final start = selectedDateTime.start.datetime.toLocal();

    _selectedDateTime = TaskDate(
        start: NotionDateTime(
          datetime: DateTime(
            start.year,
            start.month,
            start.day,
          ),
          isAllDay: true,
        ),
        end: null);

    notifyListeners();
  }
}
