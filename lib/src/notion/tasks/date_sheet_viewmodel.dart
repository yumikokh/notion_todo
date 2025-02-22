import 'package:flutter/foundation.dart';

import '../../helpers/date.dart';
import '../model/task.dart';

class DateSheetViewModel extends ChangeNotifier {
  final TaskDate? initialDateTime;

  DateSheetViewModel({
    required this.initialDateTime,
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
  DateTime get focusedDay => _focusedDay;

  DateTime get calenderFirstDay {
    final initial = initialDateTime;
    final now = DateTime.now();
    if (initial == null) {
      return now;
    }
    return initial.start.datetime.isBefore(now) ? initial.start.datetime : now;
  }

  DateTime get calenderLastDay {
    return DateTime.now().add(const Duration(days: 365));
  }

  // セグメントが変更されたときの処理
  void handleSegmentChanged(Set<Object?> selectedSet) {
    TaskDate? date;
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

  // カレンダーが選択されたときの処理
  void handleCalendarSelected(DateTime date, DateTime focusedDate) {
    final selectedDateTime = _selectedDateTime;
    if (selectedDateTime == null) return;

    // 既存の時間を保持したまま日付のみ更新
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

    // 終了日は削除
    _selectedDateTime = TaskDate(start: start);
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
    final end = selectedDateTime.end?.datetime.toLocal();

    _selectedDateTime = TaskDate(
      start: NotionDateTime(
        datetime: DateTime(
          start.year,
          start.month,
          start.day,
        ),
        isAllDay: true,
      ),
      end: end != null
          ? NotionDateTime(
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
