import 'package:freezed_annotation/freezed_annotation.dart';

import 'property.dart';

part 'task_database.freezed.dart';
part 'task_database.g.dart';

@freezed
class TaskDatabase with _$TaskDatabase {
  const factory TaskDatabase({
    required String id,
    required String name,
    required TaskStatusProperty status,
    required TaskDateProperty date,
  }) = _SelectedTaskDatabase;

  factory TaskDatabase.initial() => TaskDatabase(
      id: '',
      name: '',
      status: TaskStatusProperty.initial(),
      date: TaskDateProperty.initial());

  factory TaskDatabase.fromJson(Map<String, dynamic> json) =>
      _$TaskDatabaseFromJson(json);
}
