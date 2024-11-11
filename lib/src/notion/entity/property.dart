import 'package:freezed_annotation/freezed_annotation.dart';

part 'property.freezed.dart';
part 'property.g.dart';

/// Property
@freezed
class Property with _$Property {
  const factory Property.date({
    required String id,
    required String name,
    required String type,
    required DateTime? date,
  }) = DateProperty;

  const factory Property.checkbox({
    required String id,
    required String name,
    required String type,
    required bool checked,
  }) = CheckboxProperty;

  const factory Property.status({
    required String id,
    required String name,
    required String type,
    required ({List<StatusOption> options, List<StatusGroup> groups}) status,
  }) = StatusProperty;

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
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
