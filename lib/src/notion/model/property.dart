import 'package:freezed_annotation/freezed_annotation.dart';

part 'property.g.dart';

enum PropertyType {
  title,
  date,
  checkbox,
  status,
}

sealed class Property {
  String get id;
  String get name;
  PropertyType get type;

  Map<String, dynamic> toJson();

  static Property fromJson(Map<String, dynamic> json) {
    final type = json['type'] as PropertyType;
    switch (type) {
      case PropertyType.title:
        return TitleProperty.fromJson(json);
      case PropertyType.date:
        return DateProperty.fromJson(json);
      case PropertyType.checkbox:
        return CheckboxCompleteStatusProperty.fromJson(json);
      case PropertyType.status:
        return StatusCompleteStatusProperty.fromJson(json);
    }
  }
}

@JsonSerializable()
class TitleProperty implements Property {
  @override
  final String id;
  @override
  final String name;
  @override
  final PropertyType type = PropertyType.title;

  final String title;

  TitleProperty({
    required this.id,
    required this.name,
    required this.title,
  });

  factory TitleProperty.fromJson(Map<String, dynamic> json) =>
      _$TitlePropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TitlePropertyToJson(this);
}

@JsonSerializable()
class DateProperty implements Property {
  @override
  final String id;
  @override
  final String name;
  @override
  final PropertyType type = PropertyType.date;

  final DateTime? date;

  DateProperty({
    required this.id,
    required this.name,
    required this.date,
  });

  factory DateProperty.fromJson(Map<String, dynamic> json) =>
      _$DatePropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DatePropertyToJson(this);
}

sealed class CompleteStatusProperty implements Property {
  static CompleteStatusProperty fromJson(Map<String, dynamic> json) {
    final type = json['type'] as PropertyType;
    switch (type) {
      case PropertyType.checkbox:
        return CheckboxCompleteStatusProperty.fromJson(json);
      case PropertyType.status:
        return StatusCompleteStatusProperty.fromJson(json);
      default:
        throw ArgumentError('Unknown type: $type');
    }
  }
}

@JsonSerializable()
class CheckboxCompleteStatusProperty implements CompleteStatusProperty {
  @override
  final String id;
  @override
  final String name;
  @override
  final PropertyType type = PropertyType.checkbox;
  final bool checked;

  CheckboxCompleteStatusProperty({
    required this.id,
    required this.name,
    required this.checked,
  });

  factory CheckboxCompleteStatusProperty.fromJson(Map<String, dynamic> json) =>
      _$CheckboxCompleteStatusPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CheckboxCompleteStatusPropertyToJson(this);
}

@JsonSerializable()
class StatusCompleteStatusProperty implements CompleteStatusProperty {
  @override
  final String id;
  @override
  final String name;
  @override
  final PropertyType type = PropertyType.status;
  final ({List<StatusOption> options, List<StatusGroup> groups}) status;
  final StatusOption? todoOption;
  final StatusOption? completeOption;

  StatusCompleteStatusProperty({
    required this.id,
    required this.name,
    required this.status,
    required this.todoOption,
    required this.completeOption,
  });

  StatusCompleteStatusProperty copyWith({
    StatusOption? todoOption,
    StatusOption? completeOption,
  }) {
    return StatusCompleteStatusProperty(
      id: id,
      name: name,
      status: status,
      todoOption: todoOption ?? this.todoOption,
      completeOption: completeOption ?? this.completeOption,
    );
  }

  factory StatusCompleteStatusProperty.fromJson(Map<String, dynamic> json) =>
      _$StatusCompleteStatusPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StatusCompleteStatusPropertyToJson(this);
}

abstract interface class StatusPropertyBase {
  String get id;
  String get name;
  String? get color;
}

@JsonSerializable()
class StatusOption implements StatusPropertyBase {
  @override
  final String id;
  @override
  final String name;
  @override
  final String? color;

  StatusOption({
    required this.id,
    required this.name,
    required this.color,
  });

  factory StatusOption.fromJson(Map<String, dynamic> json) =>
      _$StatusOptionFromJson(json);

  Map<String, dynamic> toJson() => _$StatusOptionToJson(this);
}

@JsonSerializable()
class StatusGroup implements StatusPropertyBase {
  @override
  final String id;
  @override
  final String name;
  @override
  final String? color;

  @JsonKey(name: 'option_ids')
  final List<String> optionIds;

  StatusGroup({
    required this.id,
    required this.name,
    required this.color,
    required this.optionIds,
  });

  factory StatusGroup.fromJson(Map<String, dynamic> json) =>
      _$StatusGroupFromJson(json);

  Map<String, dynamic> toJson() => _$StatusGroupToJson(this);
}
