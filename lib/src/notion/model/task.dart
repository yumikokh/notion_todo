import 'package:freezed_annotation/freezed_annotation.dart';

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

  String get submitFormat => isAllDay
      ? datetime.toLocal().toIso8601String().split('T')[0]
      : datetime.toUtc().toIso8601String();

  factory NotionDateTime.fromJson(Map<String, dynamic> json) =>
      _$NotionDateTimeFromJson(json);
}

@freezed
class TaskDate with _$TaskDate {
  const factory TaskDate({
    required NotionDateTime start,
    NotionDateTime? end,
  }) = _TaskDate;

  factory TaskDate.fromJson(Map<String, dynamic> json) =>
      _$TaskDateFromJson(json);
}

@freezed
sealed class TaskStatus with _$TaskStatus {
  const factory TaskStatus.checkbox({
    required bool checked,
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
    // required String createdTime,
    // required String updatedTime,
  }) = _Task;

  bool get isCompleted => switch (status) {
        TaskStatusCheckbox(checked: var checked) => checked,
        TaskStatusStatus(group: var group) =>
          group?.name == StatusGroupType.complete.value,
      };

  bool isInProgress(StatusOption inProgressOption) => switch (status) {
        TaskStatusCheckbox() => false,
        TaskStatusStatus(option: var option) =>
          option?.id == inProgressOption.id,
      };

  bool get isTemp => id.startsWith("temp_");

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
