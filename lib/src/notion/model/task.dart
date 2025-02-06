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

  factory NotionDateTime.fromString(String date) => NotionDateTime(
        datetime: DateTime.parse(date),
        isAllDay: !date.contains('T'),
      );

  String get formattedDate => isAllDay
      ? datetime.toLocal().toString().split(' ')[0]
      : datetime.toLocal().toIso8601String();

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

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
