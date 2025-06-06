import 'package:freezed_annotation/freezed_annotation.dart';

import 'property.dart';

part 'task_database.freezed.dart';
part 'task_database.g.dart';

// 決定されたタスクDB情報
@freezed
class TaskDatabase with _$TaskDatabase {
  @JsonSerializable(explicitToJson: true)
  const factory TaskDatabase({
    required String id,
    required String name,
    required TitleProperty title,
    required CompleteStatusProperty status,
    required DateProperty date,
    SelectProperty? priority,
  }) = _TaskDatabase;

  factory TaskDatabase.fromJson(Map<String, dynamic> json) =>
      _$TaskDatabaseFromJson(json);
}
