import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tanzaku_todo/src/notion/model/property.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class TaskDate with _$TaskDate {
  const factory TaskDate({
    required String start, // TODO: DateTimeにして、時間指定があるかのフラグを追加する
    String? end,
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

  bool get isInProgress => switch (status) {
        TaskStatusCheckbox() => false,
        TaskStatusStatus(group: var group) =>
          group?.name == StatusGroupType.inProgress.value,
      };

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
