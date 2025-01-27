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
sealed class Property with _$Property {
  @Assert('type == PropertyType.title')
  const factory Property.title({
    required String id,
    required String name,
    required String title,
    @protected @Default(PropertyType.title) PropertyType type,
  }) = TitleProperty;

  @Assert('type == PropertyType.date')
  const factory Property.date({
    required String id,
    required String name,
    required DateTime? date,
    @protected @Default(PropertyType.date) PropertyType type,
  }) = DateProperty;

  @Assert('type == PropertyType.checkbox')
  const factory Property.checkbox({
    required String id,
    required String name,
    required bool checked,
    @protected @Default(PropertyType.checkbox) PropertyType type,
  }) = CheckboxProperty;

  @Assert('type == PropertyType.status')
  const factory Property.status({
    required String id,
    required String name,
    required ({List<StatusOption> options, List<StatusGroup> groups}) status,
    required StatusOption? todoOption,
    required StatusOption? completeOption,
    @protected @Default(PropertyType.status) PropertyType type,
  }) = StatusProperty;

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
}

// MEMO: StatusのUnion型、理想は↑でサブクラス化したい
@freezed
sealed class CompleteStatusProperty with _$CompleteStatusProperty {
  const factory CompleteStatusProperty.checkbox({
    required String id,
    required String name,
    required bool checked,
    @protected @Default(PropertyType.checkbox) PropertyType type,
  }) = CheckboxCompleteStatusProperty;

  const factory CompleteStatusProperty.status({
    required String id,
    required String name,
    required ({List<StatusOption> options, List<StatusGroup> groups}) status,
    required StatusOption? todoOption,
    required StatusOption? completeOption,
    @protected @Default(PropertyType.status) PropertyType type,
  }) = StatusCompleteStatusProperty;

  factory CompleteStatusProperty.fromJson(Map<String, dynamic> json) =>
      _$CompleteStatusPropertyFromJson(json);
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
  const factory StatusGroup({
    required String id,
    required String name,
    required String? color,
    // ignore: non_constant_identifier_names
    required List<String> option_ids,
  }) = _StatusGroup;

  factory StatusGroup.fromJson(Map<String, dynamic> json) =>
      _$StatusGroupFromJson(json);
}
