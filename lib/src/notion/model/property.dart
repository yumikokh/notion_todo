import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'property.g.dart';

enum PropertyType {
  title,
  date,
  checkbox,
  status,
  select,
}

/// プロパティの基底クラス
sealed class Property {
  String id;
  String name;
  PropertyType type;

  Property({
    required this.id,
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toJson() => switch (this) {
        TitleProperty title => title.toJson(),
        DateProperty date => date.toJson(),
        CheckboxCompleteStatusProperty checkbox => checkbox.toJson(),
        StatusCompleteStatusProperty status => status.toJson(),
        SelectProperty select => select.toJson(),
      };

  factory Property.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String;
    final type = $enumDecode(_$PropertyTypeEnumMap, typeStr);
    switch (type) {
      case PropertyType.title:
        return TitleProperty.fromJson(json);
      case PropertyType.date:
        return DateProperty.fromJson(json);
      case PropertyType.checkbox:
        return CheckboxCompleteStatusProperty.fromJson(json);
      case PropertyType.status:
        return StatusCompleteStatusProperty.fromJson(json);
      case PropertyType.select:
        return SelectProperty.fromJson(json);
    }
  }
}

@JsonSerializable()
class TitleProperty extends Property {
  final String title;

  TitleProperty({
    required String id,
    required String name,
    required this.title,
  }) : super(id: id, name: name, type: PropertyType.title);

  factory TitleProperty.fromJson(Map<String, dynamic> json) =>
      _$TitlePropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TitlePropertyToJson(this);
}

@JsonSerializable()
class DateProperty extends Property {
  DateProperty({
    required String id,
    required String name,
  }) : super(id: id, name: name, type: PropertyType.date);

  factory DateProperty.fromJson(Map<String, dynamic> json) =>
      _$DatePropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DatePropertyToJson(this);
}

/// 完了ステータスプロパティの基底クラス
sealed class CompleteStatusProperty extends Property {
  CompleteStatusProperty({
    required String id,
    required String name,
    required PropertyType type,
  }) : super(id: id, name: name, type: type);

  static CompleteStatusProperty fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String;
    final type = $enumDecode(_$PropertyTypeEnumMap, typeStr);
    switch (type) {
      case PropertyType.checkbox:
        return CheckboxCompleteStatusProperty.fromJson(json);
      case PropertyType.status:
        return StatusCompleteStatusProperty.fromJson(json);
      default:
        throw ArgumentError('Unknown type: $type');
    }
  }

  @override
  Map<String, dynamic> toJson() => switch (this) {
        CheckboxCompleteStatusProperty status => status.toJson(),
        StatusCompleteStatusProperty status => status.toJson(),
      };
}

@JsonSerializable()
class CheckboxCompleteStatusProperty extends CompleteStatusProperty {
  final bool checked;

  CheckboxCompleteStatusProperty({
    required String id,
    required String name,
    required this.checked,
  }) : super(id: id, name: name, type: PropertyType.checkbox);

  factory CheckboxCompleteStatusProperty.fromJson(Map<String, dynamic> json) =>
      _$CheckboxCompleteStatusPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CheckboxCompleteStatusPropertyToJson(this);
}

@JsonSerializable()
class StatusCompleteStatusProperty extends CompleteStatusProperty {
  final ({List<StatusOption> options, List<StatusGroup> groups}) status;
  final StatusOption? todoOption;
  final StatusOption? inProgressOption; // optional
  final StatusOption? completeOption;

  StatusCompleteStatusProperty({
    required String id,
    required String name,
    required this.status,
    required this.todoOption,
    required this.inProgressOption,
    required this.completeOption,
  }) : super(id: id, name: name, type: PropertyType.status);

  StatusCompleteStatusProperty copyWith({
    StatusOption? todoOption,
    StatusOption? inProgressOption,
    StatusOption? completeOption,
  }) {
    return StatusCompleteStatusProperty(
      id: id,
      name: name,
      status: status,
      todoOption: todoOption ?? this.todoOption,
      inProgressOption: inProgressOption ?? this.inProgressOption,
      completeOption: completeOption ?? this.completeOption,
    );
  }

  factory StatusCompleteStatusProperty.fromJson(Map<String, dynamic> json) =>
      _$StatusCompleteStatusPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StatusCompleteStatusPropertyToJson(this);
}

enum StatusGroupType {
  todo('To-do'),
  inProgress('In progress'),
  complete('Complete');

  final String value;
  const StatusGroupType(this.value);
}

/// ステータスプロパティの基底クラス
abstract interface class StatusPropertyBase {
  String id;
  String name;
  String? color;

  StatusPropertyBase({
    required this.id,
    required this.name,
    required this.color,
  });
}

@JsonSerializable()
class StatusOption extends StatusPropertyBase {
  StatusOption({
    required String id,
    required String name,
    required String? color,
  }) : super(id: id, name: name, color: color);

  factory StatusOption.fromJson(Map<String, dynamic> json) =>
      _$StatusOptionFromJson(json);

  Map<String, dynamic> toJson() => _$StatusOptionToJson(this);
}

@JsonSerializable()
class StatusGroup extends StatusPropertyBase {
  @JsonKey(name: 'option_ids')
  final List<String> optionIds;

  StatusGroup({
    required String id,
    required String name,
    required String? color,
    required this.optionIds,
  }) : super(id: id, name: name, color: color);

  factory StatusGroup.fromJson(Map<String, dynamic> json) =>
      _$StatusGroupFromJson(json);

  Map<String, dynamic> toJson() => _$StatusGroupToJson(this);
}

@JsonSerializable()
class StatusOptionsByGroup {
  final StatusGroupType groupType;
  final List<StatusOption> options;

  StatusOptionsByGroup({required this.groupType, required this.options});

  factory StatusOptionsByGroup.fromJson(Map<String, dynamic> json) =>
      _$StatusOptionsByGroupFromJson(json);

  Map<String, dynamic> toJson() => _$StatusOptionsByGroupToJson(this);
}

/// NotionのAPIで定義されている色の列挙型
enum NotionColor {
  blue,
  brown,
  defaultColor,
  gray,
  green,
  orange,
  pink,
  purple,
  red,
  yellow;

  Color toColor() {
    return switch (this) {
      NotionColor.blue => const Color.fromARGB(255, 89, 96, 159),
      NotionColor.brown => const Color.fromARGB(255, 100, 70, 13),
      NotionColor.gray => const Color(0xff4b463d),
      NotionColor.green => const Color.fromARGB(255, 38, 93, 51),
      NotionColor.orange => const Color.fromARGB(255, 175, 126, 81),
      NotionColor.pink => const Color.fromARGB(255, 174, 99, 114),
      NotionColor.purple => const Color.fromARGB(255, 99, 75, 133),
      NotionColor.red => const Color.fromARGB(255, 160, 63, 63),
      NotionColor.yellow => const Color.fromARGB(255, 189, 169, 113),
      NotionColor.defaultColor => const Color(0xff7c766c),
    };
  }

  static NotionColor? fromString(String? value) {
    if (value == null) return null;
    return NotionColor.values.firstWhere(
      (e) => e.name == (value == 'default' ? 'defaultColor' : value),
      orElse: () => NotionColor.defaultColor,
    );
  }
}

@JsonSerializable()
class SelectOption {
  final String id;
  final String name;
  @JsonKey(fromJson: NotionColor.fromString)
  final NotionColor? notionColor;

  SelectOption({
    required this.id,
    required this.name,
    this.notionColor,
  });

  Color get color => notionColor?.toColor() ?? Colors.grey;

  factory SelectOption.fromJson(Map<String, dynamic> json) =>
      _$SelectOptionFromJson(json);

  Map<String, dynamic> toJson() => _$SelectOptionToJson(this);
}

@JsonSerializable()
class SelectProperty extends Property {
  final List<SelectOption> options;

  SelectProperty({
    required String id,
    required String name,
    required this.options,
  }) : super(id: id, name: name, type: PropertyType.select);

  factory SelectProperty.fromJson(Map<String, dynamic> json) =>
      _$SelectPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SelectPropertyToJson(this);
}
