import 'package:freezed_annotation/freezed_annotation.dart';

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
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required bool isCompleted,
    required TaskDate? dueDate,
    // required String createdTime,
    // required String updatedTime,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.initial() =>
      const Task(id: '', title: '', isCompleted: false, dueDate: null);
}
