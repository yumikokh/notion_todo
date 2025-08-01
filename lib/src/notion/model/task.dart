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
      return Theme.of(context).colorScheme.tertiaryContainer; // 今日だったら青
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
    List<RelationOption>? projects,
    // 動的なプロパティ値（固定フィールド以外の追加プロパティ）
    // key: プロパティID, value: プロパティ値（dynamic）
    @JsonKey(defaultValue: {}) Map<String, dynamic>? additionalFields,
    // required String createdTime,
    // required String updatedTime,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.temp({
    String? title,
    TaskDate? dueDate,
    SelectOption? priority,
    List<RelationOption>? projects,
    Map<String, dynamic>? additionalFields,
  }) =>
      Task(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        title: title ?? '',
        status: const TaskStatus.checkbox(checkbox: false),
        dueDate: dueDate,
        url: null,
        priority: priority,
        projects: projects,
        additionalFields: additionalFields,
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

  bool get isOverdueToday {
    final now = DateTime.now();
    final startOfToday = d.startTimeOfDay(now);
    final dueDateStart = dueDate?.start.datetime;
    final dueDateEnd = dueDate?.end?.datetime;

    // 終了日時がある場合
    if (dueDateEnd != null) {
      // 終了日時が今日より前の日付なら期限切れ
      if (dueDateEnd.isBefore(startOfToday)) {
        return true;
      }
      // 終了日時が今日で、かつ現在時刻を過ぎている場合は期限切れ
      if (d.isToday(dueDateEnd) && dueDateEnd.isBefore(now)) {
        return true;
      }
      return false;
    }

    // 開始日時のみの場合
    if (dueDateStart != null) {
      // 終日タスクで今日の場合は期限切れではない
      if (dueDate?.start.isAllDay == true && d.isToday(dueDateStart)) {
        return false;
      }
      // 今日の始まりより前なら期限切れ
      if (dueDateStart.isBefore(startOfToday)) {
        return true;
      }
    }

    return false;
  }

  bool get isTemp => id.startsWith("temp_");
}
