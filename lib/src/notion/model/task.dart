import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../helpers/date.dart';
import 'property.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class NotionDateTime with _$NotionDateTime {
  const NotionDateTime._();

  const factory NotionDateTime({
    required DateTime datetime,
    required bool isAllDay,
  }) = _NotionDateTime;

  factory NotionDateTime.fromString(String date) {
    final dt = DateTime.parse(date);
    final isAllDay = !date.contains('T');
    return NotionDateTime(
      datetime: isAllDay ? dt.toLocal() : dt.toUtc(),
      isAllDay: isAllDay,
    );
  }

  factory NotionDateTime.todayAllDay() => NotionDateTime(
        datetime: DateTime.now().toLocal(),
        isAllDay: true,
      );

  factory NotionDateTime.fromJson(Map<String, dynamic> json) =>
      _$NotionDateTimeFromJson(json);

  String get submitFormat => isAllDay
      ? datetime.toLocal().toIso8601String().split('T')[0]
      : datetime.toUtc().toIso8601String();
}

@freezed
class TaskDate with _$TaskDate {
  static final DateHelper d = DateHelper();

  const factory TaskDate({
    required NotionDateTime start,
    NotionDateTime? end,
  }) = _TaskDate;

  factory TaskDate.todayAllDay() => TaskDate(
        start: NotionDateTime.todayAllDay(),
        end: null,
      );

  factory TaskDate.fromJson(Map<String, dynamic> json) =>
      _$TaskDateFromJson(json);

  static Color? getColor(BuildContext context, TaskDate? dueDate) {
    if (dueDate == null) return null;
    final now = DateTime.now();
    final dueDateStart = dueDate.start.datetime;
    final dueDateEnd = dueDate.end?.datetime;

    // 終日かつ今日
    if (dueDateEnd == null &&
        d.isToday(dueDateStart) &&
        dueDate.start.isAllDay == true) {
      return Theme.of(context).colorScheme.tertiary; // 今日だったら青
    }

    // 時間があり、すぎている
    if ((dueDateEnd != null && dueDateEnd.isBefore(now)) ||
        (dueDateEnd == null && dueDateStart.isBefore(now))) {
      return Theme.of(context).colorScheme.error; // 過ぎてたら赤
    }

    return Theme.of(context).colorScheme.secondary;
  }
}

@freezed
sealed class TaskStatus with _$TaskStatus {
  const factory TaskStatus.checkbox({
    required bool checkbox,
  }) = TaskStatusCheckbox;

  const factory TaskStatus.status({
    required StatusGroup? group,
    required StatusOption? option,
  }) = TaskStatusStatus;

  factory TaskStatus.fromJson(Map<String, dynamic> json) =>
      _$TaskStatusFromJson(json);
}

@freezed
class Task with _$Task {
  const Task._();

  const factory Task({
    required String id,
    required String title,
    required TaskStatus status,
    required TaskDate? dueDate,
    required String? url,
    SelectOption? priority,
    // required String createdTime,
    // required String updatedTime,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.temp({
    String? title,
    TaskDate? dueDate,
    SelectOption? priority,
  }) =>
      Task(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        title: title ?? '',
        status: const TaskStatus.checkbox(checkbox: false),
        dueDate: dueDate,
        url: null,
        priority: priority,
      );

  static final DateHelper d = DateHelper();

  bool get isCompleted => switch (status) {
        TaskStatusCheckbox(checkbox: var checkbox) => checkbox,
        TaskStatusStatus(group: var group) =>
          group?.name == StatusGroupType.complete.value,
      };

  bool isInProgress(StatusOption inProgressOption) => switch (status) {
        TaskStatusCheckbox() => false,
        TaskStatusStatus(option: var option) =>
          option?.id == inProgressOption.id,
      };

  bool get isOverdue {
    final now = DateTime.now();
    final dueDateStart = dueDate?.start.datetime;
    final dueDateEnd = dueDate?.end?.datetime;

    // 終日かつ今日
    if (dueDateEnd == null &&
        d.isToday(dueDateStart) &&
        dueDate?.start.isAllDay == true) {
      return false;
    }

    // 時間があり、すぎている
    if ((dueDateEnd != null && dueDateEnd.isBefore(now)) ||
        (dueDateEnd == null &&
            dueDateStart != null &&
            dueDateStart.isBefore(now))) {
      return true;
    }

    return false;
  }

  bool get isTemp => id.startsWith("temp_");
}
