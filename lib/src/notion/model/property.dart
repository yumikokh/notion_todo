import 'package:freezed_annotation/freezed_annotation.dart';

part 'property.freezed.dart';
part 'property.g.dart';

enum PropertyType {
  date,
  checkbox,
  status,
}

/// Property
@freezed
class Property with _$Property {
  const factory Property.date({
    required String id,
    required String name,
    required PropertyType type, // 省略したい
    required DateTime? date,
  }) = DateProperty;

  const factory Property.checkbox({
    required String id,
    required String name,
    required PropertyType type,
    required bool checked,
  }) = CheckboxProperty;

  const factory Property.status({
    required String id,
    required String name,
    required PropertyType type,
    required ({List<StatusOption> options, List<StatusGroup> groups}) status,
  }) = StatusProperty;

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
}

@freezed
class TaskDateProperty with _$TaskDateProperty {
  const factory TaskDateProperty({
    required String id,
    required String name,
    required PropertyType type,
    required DateTime? date,
  }) = _TaskDateProperty;

  factory TaskDateProperty.initial() => const TaskDateProperty(
        id: '',
        name: '',
        type: PropertyType.date,
        date: null,
      );

  factory TaskDateProperty.fromJson(Map<String, dynamic> json) =>
      _$TaskDatePropertyFromJson(json);
}

@freezed
class TaskStatusProperty with _$TaskStatusProperty {
  const factory TaskStatusProperty.checkbox({
    required String id,
    required String name,
    required PropertyType type,
    required bool checked,
  }) = CheckboxTaskStatusProperty;

  const factory TaskStatusProperty.status({
    required String id,
    required String name,
    required PropertyType type,
    required ({List<StatusOption> options, List<StatusGroup> groups}) status,
  }) = StatusTaskStatusProperty;

  factory TaskStatusProperty.initial() => const CheckboxTaskStatusProperty(
        id: '',
        name: '',
        type: PropertyType.checkbox,
        checked: false,
      );

  factory TaskStatusProperty.fromJson(Map<String, dynamic> json) =>
      _$TaskStatusPropertyFromJson(json);
}

@freezed
class StatusOption with _$StatusOption {
  const factory StatusOption({
    required String id,
    required String name,
    required String? color,
  }) = _StatusOption;

  factory StatusOption.fromJson(Map<String, dynamic> json) =>
      _$StatusOptionFromJson(json);
}

@freezed
class StatusGroup with _$StatusGroup {
  const factory StatusGroup(
      {required String id,
      required String name,
      required String? color,
      required List<String> option_ids}) = _StatusGroup;

  factory StatusGroup.fromJson(Map<String, dynamic> json) =>
      _$StatusGroupFromJson(json);
}
