import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'property.g.dart';

enum PropertyType {
  title,
  date,
  checkbox,
  status,
  select,
  relation,
  number,
  url,
  formula,
  multiSelect,
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
        CheckboxProperty checkbox => checkbox.toJson(),
        StatusProperty status => status.toJson(),
        SelectProperty select => select.toJson(),
        RelationProperty relation => relation.toJson(),
        NumberProperty number => number.toJson(),
        UrlProperty url => url.toJson(),
        FormulaProperty formula => formula.toJson(),
        MultiSelectProperty multiSelect => multiSelect.toJson(),
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
        return CheckboxProperty.fromJson(json);
      case PropertyType.status:
        return StatusProperty.fromJson(json);
      case PropertyType.select:
        return SelectProperty.fromJson(json);
      case PropertyType.relation:
        return RelationProperty.fromJson(json);
      case PropertyType.number:
        return NumberProperty.fromJson(json);
      case PropertyType.url:
        return UrlProperty.fromJson(json);
      case PropertyType.formula:
        return FormulaProperty.fromJson(json);
      case PropertyType.multiSelect:
        return MultiSelectProperty.fromJson(json);
    }
  }
}

@JsonSerializable()
class TitleProperty extends Property {
  @JsonKey(fromJson: _titleFromJson)
  final String? title;

  TitleProperty({
    required super.id,
    required super.name,
    required this.title,
  }) : super(type: PropertyType.title);

  static String? _titleFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is List && json.isNotEmpty) {
      return (json[0] as Map<String, dynamic>)['plain_text'] as String;
    }
    return null;
  }

  factory TitleProperty.fromJson(Map<String, dynamic> json) =>
      _$TitlePropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TitlePropertyToJson(this);
}

@JsonSerializable()
class DateProperty extends Property {
  DateProperty({
    required super.id,
    required super.name,
  }) : super(type: PropertyType.date);

  factory DateProperty.fromJson(Map<String, dynamic> json) =>
      _$DatePropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DatePropertyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SelectProperty extends Property {
  final ({List<SelectOption> options}) select;

  SelectProperty({
    required super.id,
    required super.name,
    required this.select,
  }) : super(type: PropertyType.select);

  factory SelectProperty.fromJson(Map<String, dynamic> json) =>
      _$SelectPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SelectPropertyToJson(this);
}

@JsonSerializable()
class CheckboxProperty extends Property {
  final bool checkbox;

  CheckboxProperty({
    required super.id,
    required super.name,
    required this.checkbox,
    required PropertyType type,
  }) : super(type: PropertyType.checkbox);

  factory CheckboxProperty.fromJson(Map<String, dynamic> json) {
    // checkboxの値が空のオブジェクト{}の場合はfalseとして扱う
    if (json['checkbox'] is Map) {
      json['checkbox'] = false;
    }
    return _$CheckboxPropertyFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$CheckboxPropertyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StatusProperty extends Property {
  final ({List<StatusOption> options, List<StatusGroup> groups}) status;

  StatusProperty({
    required super.id,
    required super.name,
    required this.status,
  }) : super(type: PropertyType.status);

  StatusProperty copyWith({
    String? id,
    String? name,
    ({List<StatusOption> options, List<StatusGroup> groups})? status,
  }) {
    return StatusProperty(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  factory StatusProperty.fromJson(Map<String, dynamic> json) =>
      _$StatusPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StatusPropertyToJson(this);
}

/// 完了ステータスの基底クラス - チェックボックス or ステータス
sealed class CompleteStatusProperty {
  final String id;
  final String name;
  final PropertyType type;

  CompleteStatusProperty({
    required this.id,
    required this.name,
    required this.type,
  });

  static Map<String, dynamic> initialJson(CompleteStatusProperty status) {
    return switch (status) {
      StatusCompleteStatusProperty() => {
          "status": {"name": status.todoOption?.name}
        },
      CheckboxCompleteStatusProperty() => {"checkbox": false},
    };
  }

  factory CompleteStatusProperty.fromJson(Map<String, dynamic> json) {
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
  Map<String, dynamic> toJson() => switch (this) {
        CheckboxCompleteStatusProperty status => status.toJson(),
        StatusCompleteStatusProperty status => status.toJson(),
      };
}

@JsonSerializable()
class CheckboxCompleteStatusProperty extends CheckboxProperty
    implements CompleteStatusProperty {
  CheckboxCompleteStatusProperty({
    required super.id,
    required super.name,
    required super.checkbox,
  }) : super(type: PropertyType.checkbox);

  factory CheckboxCompleteStatusProperty.fromJson(Map<String, dynamic> json) {
    if (json['checked'] != null) {
      // TODO: 前のバージョンではcheckboxがcheckedというキーで保存されていたため。しばらくしたら消す
      json['checkbox'] = json['checked'];
    }
    return _$CheckboxCompleteStatusPropertyFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$CheckboxCompleteStatusPropertyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StatusCompleteStatusProperty extends StatusProperty
    implements CompleteStatusProperty {
  final StatusOption? todoOption;
  final StatusOption? inProgressOption; // optional
  final StatusOption? completeOption;

  StatusCompleteStatusProperty({
    required super.id,
    required super.name,
    required super.status,
    required this.todoOption,
    required this.inProgressOption,
    required this.completeOption,
  });

  /// 既存のStatusCompleteStatusPropertyのオプションIDを使用して、
  /// 新しいStatusPropertyから対応するStatusCompleteStatusPropertyを作成します
  factory StatusCompleteStatusProperty.fromSavedStatusOptions({
    required StatusProperty newStatusProperty,
    required StatusCompleteStatusProperty savedStatus,
  }) {
    // 保存済みのオプションIDを使って、新しいステータスから対応するオプションを探す
    StatusOption? findOptionById(String? currentOptionId) {
      if (currentOptionId == null) return null;
      return newStatusProperty.status.options.firstWhere(
        (option) => option.id == currentOptionId,
        orElse: () =>
            throw StateError('対応するステータスオプションが見つかりません: $currentOptionId'),
      );
    }

    return StatusCompleteStatusProperty(
      id: newStatusProperty.id,
      name: newStatusProperty.name,
      status: newStatusProperty.status,
      todoOption: findOptionById(savedStatus.todoOption?.id),
      inProgressOption: findOptionById(savedStatus.inProgressOption?.id),
      completeOption: findOptionById(savedStatus.completeOption?.id),
    );
  }

  @override
  StatusCompleteStatusProperty copyWith({
    String? id,
    String? name,
    ({List<StatusOption> options, List<StatusGroup> groups})? status,
    StatusOption? todoOption,
    StatusOption? Function()? inProgressOption,
    StatusOption? completeOption,
  }) {
    return StatusCompleteStatusProperty(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      todoOption: todoOption ?? this.todoOption,
      inProgressOption: inProgressOption != null ? inProgressOption() : this.inProgressOption,
      completeOption: completeOption ?? this.completeOption,
    );
  }

  factory StatusCompleteStatusProperty.fromJson(Map<String, dynamic> json) =>
      _$StatusCompleteStatusPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StatusCompleteStatusPropertyToJson(this);
}

abstract interface class OptionBase {
  final String id;
  final String name;
  final NotionColor? color;

  OptionBase({
    required this.id,
    required this.name,
    this.color,
  });

  Color get mColor => color?.toColor() ?? Colors.grey;
}

@JsonSerializable(explicitToJson: true)
class SelectOption extends OptionBase {
  SelectOption({
    required super.id,
    required super.name,
    @JsonKey(fromJson: NotionColor.fromString) super.color,
  });

  factory SelectOption.fromJson(Map<String, dynamic> json) =>
      _$SelectOptionFromJson(json);

  Map<String, dynamic> toJson() => _$SelectOptionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StatusOption extends OptionBase {
  StatusOption({
    required super.id,
    required super.name,
    @JsonKey(fromJson: NotionColor.fromString) super.color,
  });

  factory StatusOption.fromJson(Map<String, dynamic> json) =>
      _$StatusOptionFromJson(json);

  Map<String, dynamic> toJson() => _$StatusOptionToJson(this);
}

enum StatusGroupType {
  todo('To-do'),
  inProgress('In progress'),
  complete('Complete');

  final String value;
  const StatusGroupType(this.value);
}

@JsonSerializable(explicitToJson: true)
class StatusGroup extends OptionBase {
  @JsonKey(name: 'option_ids')
  final List<String> optionIds;

  StatusGroup({
    required super.id,
    required super.name,
    @JsonKey(fromJson: NotionColor.fromString) super.color,
    required this.optionIds,
  });

  List<StatusOption> getStatusOptionsByGroup(
    List<StatusOption> options,
  ) {
    return options.where((option) => optionIds.contains(option.id)).toList();
  }

  factory StatusGroup.fromJson(Map<String, dynamic> json) =>
      _$StatusGroupFromJson(json);

  Map<String, dynamic> toJson() => _$StatusGroupToJson(this);
}

/// NotionのAPIで定義されている色の列挙型
enum NotionColor {
  blue,
  brown,
  @JsonValue('default')
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
      NotionColor.blue => const Color.fromARGB(255, 120, 160, 170),
      NotionColor.brown => const Color.fromARGB(255, 150, 100, 40),
      NotionColor.gray => const Color.fromARGB(255, 130, 130, 130),
      NotionColor.green => const Color.fromARGB(255, 95, 164, 95),
      NotionColor.orange => const Color.fromARGB(255, 200, 130, 0),
      NotionColor.pink => const Color.fromARGB(255, 200, 140, 150),
      NotionColor.purple => const Color.fromARGB(255, 170, 120, 170),
      NotionColor.red => const Color.fromARGB(255, 200, 65, 40),
      NotionColor.yellow => const Color.fromARGB(255, 203, 182, 63),
      NotionColor.defaultColor => const Color.fromARGB(255, 170, 170, 170),
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

/// RelationプロパティのオプションクラスNotionのRelation
@JsonSerializable()
class RelationOption {
  final String id;
  final String? title;

  RelationOption({
    required this.id,
    this.title,
  });

  factory RelationOption.fromJson(Map<String, dynamic> json) =>
      _$RelationOptionFromJson(json);

  Map<String, dynamic> toJson() => _$RelationOptionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RelationProperty extends Property {
  @JsonKey(fromJson: _relationFromJson)
  final Map<String, dynamic> relation;

  RelationProperty({
    required super.id,
    required super.name,
    required this.relation,
  }) : super(type: PropertyType.relation);

  static Map<String, dynamic> _relationFromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return json;
    }
    return {};
  }

  factory RelationProperty.fromJson(Map<String, dynamic> json) =>
      _$RelationPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RelationPropertyToJson(this);
}

@JsonSerializable()
class NumberProperty extends Property {
  NumberProperty({
    required super.id,
    required super.name,
  }) : super(type: PropertyType.number);

  factory NumberProperty.fromJson(Map<String, dynamic> json) =>
      _$NumberPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NumberPropertyToJson(this);
}

@JsonSerializable()
class UrlProperty extends Property {
  UrlProperty({
    required super.id,
    required super.name,
  }) : super(type: PropertyType.url);

  factory UrlProperty.fromJson(Map<String, dynamic> json) =>
      _$UrlPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UrlPropertyToJson(this);
}

@JsonSerializable()
class FormulaProperty extends Property {
  FormulaProperty({
    required super.id,
    required super.name,
  }) : super(type: PropertyType.formula);

  factory FormulaProperty.fromJson(Map<String, dynamic> json) =>
      _$FormulaPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FormulaPropertyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MultiSelectProperty extends Property {
  @JsonKey(name: 'multi_select')
  final ({List<SelectOption> options}) multiSelect;

  MultiSelectProperty({
    required super.id,
    required super.name,
    required this.multiSelect,
  }) : super(type: PropertyType.multiSelect);

  factory MultiSelectProperty.fromJson(Map<String, dynamic> json) =>
      _$MultiSelectPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MultiSelectPropertyToJson(this);
}
