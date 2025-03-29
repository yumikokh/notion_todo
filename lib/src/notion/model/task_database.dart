import 'package:freezed_annotation/freezed_annotation.dart';

import 'property.dart';

part 'task_database.freezed.dart';
part 'task_database.g.dart';

CompleteStatusProperty _fromJson(Map<String, dynamic> json) =>
    CompleteStatusProperty.fromJson(json);
Map<String, dynamic> _toJson(CompleteStatusProperty status) => status.toJson();

// 決定されたタスクDB情報
@freezed
class TaskDatabase with _$TaskDatabase {
  @JsonSerializable(explicitToJson: true)
  const factory TaskDatabase({
    required String id,
    required String name,
    required TitleProperty title,
    @JsonKey(
      fromJson: _fromJson,
      toJson: _toJson,
    )
    required CompleteStatusProperty status,
    required DateProperty date,
    StatusCompleteStatusProperty? priority,
  }) = _TaskDatabase;

  factory TaskDatabase.fromJson(Map<String, dynamic> json) =>
      _$TaskDatabaseFromJson(json);
}
