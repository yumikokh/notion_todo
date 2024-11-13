import 'package:freezed_annotation/freezed_annotation.dart';

part 'property.freezed.dart';
part 'property.g.dart';

enum PropertyType {
  title,
  date,
  checkbox,
  status,
}

/// Property
@freezed
class Property with _$Property {
  const factory Property.title({
    required String id,
    required String name,
    required PropertyType type, // 省略したい: title固定
    required String title,
  }) = TitleProperty;

  const factory Property.date({
    required String id,
    required String name,
    required PropertyType type, // 省略したい: date固定
    required DateTime? date,
  }) = DateProperty;

  const factory Property.checkbox({
    required String id,
    required String name,
    required PropertyType type, // checkbox固定
    required bool checked,
  }) = CheckboxProperty;

  const factory Property.status({
    required String id,
    required String name,
    required PropertyType type, // status固定
    required ({List<StatusOption> options, List<StatusGroup> groups}) status,
    required StatusOption? todoOption,
    required StatusOption? completeOption,
  }) = StatusProperty;

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
}

@freezed
class TaskTitleProperty with _$TaskTitleProperty {
  const factory TaskTitleProperty({
    required String id,
    required String name,
    required PropertyType type, // 省略したい: title固定
    required String title,
  }) = _TaskTitleProperty;

  factory TaskTitleProperty.initial() => const TaskTitleProperty(
        id: '',
        name: '',
        type: PropertyType.checkbox,
        title: '',
      );

  factory TaskTitleProperty.fromJson(Map<String, dynamic> json) =>
      _$TaskTitlePropertyFromJson(json);
}

@freezed
class TaskDateProperty with _$TaskDateProperty {
  const factory TaskDateProperty({
    required String id,
    required String name,
    required PropertyType type, // date固定
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
    required PropertyType type, // checkbox固定
    required bool checked,
  }) = CheckboxTaskStatusProperty;

  const factory TaskStatusProperty.status({
    required String id,
    required String name,
    required PropertyType type, // status固定
    required ({List<StatusOption> options, List<StatusGroup> groups}) status,
    required StatusOption? todoOption, // ほんとはnon-nullにしたい
    required StatusOption? completeOption,
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
      // ignore: non_constant_identifier_names
      required List<String> option_ids}) = _StatusGroup;

  factory StatusGroup.fromJson(Map<String, dynamic> json) =>
      _$StatusGroupFromJson(json);
}
