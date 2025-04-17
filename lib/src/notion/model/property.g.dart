// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TitleProperty _$TitlePropertyFromJson(Map<String, dynamic> json) =>
    TitleProperty(
      id: json['id'] as String,
      name: json['name'] as String,
      title:
          TitleProperty._titleFromJson(json['title'] as Map<String, dynamic>?),
    )..type = $enumDecode(_$PropertyTypeEnumMap, json['type']);

Map<String, dynamic> _$TitlePropertyToJson(TitleProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'title': instance.title,
    };

const _$PropertyTypeEnumMap = {
  PropertyType.title: 'title',
  PropertyType.date: 'date',
  PropertyType.checkbox: 'checkbox',
  PropertyType.status: 'status',
  PropertyType.select: 'select',
};

DateProperty _$DatePropertyFromJson(Map<String, dynamic> json) => DateProperty(
      id: json['id'] as String,
      name: json['name'] as String,
    )..type = $enumDecode(_$PropertyTypeEnumMap, json['type']);

Map<String, dynamic> _$DatePropertyToJson(DateProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
    };

SelectProperty _$SelectPropertyFromJson(Map<String, dynamic> json) =>
    SelectProperty(
      id: json['id'] as String,
      name: json['name'] as String,
      select: _$recordConvert(
        json['select'],
        ($jsonValue) => (
          options: ($jsonValue['options'] as List<dynamic>)
              .map((e) => SelectOption.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
    )..type = $enumDecode(_$PropertyTypeEnumMap, json['type']);

Map<String, dynamic> _$SelectPropertyToJson(SelectProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'select': <String, dynamic>{
        'options': instance.select.options.map((e) => e.toJson()).toList(),
      },
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);

CheckboxProperty _$CheckboxPropertyFromJson(Map<String, dynamic> json) =>
    CheckboxProperty(
      id: json['id'] as String,
      name: json['name'] as String,
      checkbox: json['checkbox'] as bool,
      type: $enumDecode(_$PropertyTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$CheckboxPropertyToJson(CheckboxProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'checkbox': instance.checkbox,
    };

StatusProperty _$StatusPropertyFromJson(Map<String, dynamic> json) =>
    StatusProperty(
      id: json['id'] as String,
      name: json['name'] as String,
      status: _$recordConvert(
        json['status'],
        ($jsonValue) => (
          groups: ($jsonValue['groups'] as List<dynamic>)
              .map((e) => StatusGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
          options: ($jsonValue['options'] as List<dynamic>)
              .map((e) => StatusOption.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
    )..type = $enumDecode(_$PropertyTypeEnumMap, json['type']);

Map<String, dynamic> _$StatusPropertyToJson(StatusProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'status': <String, dynamic>{
        'groups': instance.status.groups.map((e) => e.toJson()).toList(),
        'options': instance.status.options.map((e) => e.toJson()).toList(),
      },
    };

CheckboxCompleteStatusProperty _$CheckboxCompleteStatusPropertyFromJson(
        Map<String, dynamic> json) =>
    CheckboxCompleteStatusProperty(
      id: json['id'] as String,
      name: json['name'] as String,
      checkbox: json['checkbox'] as bool,
    )..type = $enumDecode(_$PropertyTypeEnumMap, json['type']);

Map<String, dynamic> _$CheckboxCompleteStatusPropertyToJson(
        CheckboxCompleteStatusProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'checkbox': instance.checkbox,
    };

StatusCompleteStatusProperty _$StatusCompleteStatusPropertyFromJson(
        Map<String, dynamic> json) =>
    StatusCompleteStatusProperty(
      id: json['id'] as String,
      name: json['name'] as String,
      status: _$recordConvert(
        json['status'],
        ($jsonValue) => (
          groups: ($jsonValue['groups'] as List<dynamic>)
              .map((e) => StatusGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
          options: ($jsonValue['options'] as List<dynamic>)
              .map((e) => StatusOption.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
      todoOption: json['todoOption'] == null
          ? null
          : StatusOption.fromJson(json['todoOption'] as Map<String, dynamic>),
      inProgressOption: json['inProgressOption'] == null
          ? null
          : StatusOption.fromJson(
              json['inProgressOption'] as Map<String, dynamic>),
      completeOption: json['completeOption'] == null
          ? null
          : StatusOption.fromJson(
              json['completeOption'] as Map<String, dynamic>),
    )..type = $enumDecode(_$PropertyTypeEnumMap, json['type']);

Map<String, dynamic> _$StatusCompleteStatusPropertyToJson(
        StatusCompleteStatusProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'status': <String, dynamic>{
        'groups': instance.status.groups.map((e) => e.toJson()).toList(),
        'options': instance.status.options.map((e) => e.toJson()).toList(),
      },
      'todoOption': instance.todoOption?.toJson(),
      'inProgressOption': instance.inProgressOption?.toJson(),
      'completeOption': instance.completeOption?.toJson(),
    };

SelectOption _$SelectOptionFromJson(Map<String, dynamic> json) => SelectOption(
      id: json['id'] as String,
      name: json['name'] as String,
      color: $enumDecodeNullable(_$NotionColorEnumMap, json['color']),
    );

Map<String, dynamic> _$SelectOptionToJson(SelectOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': _$NotionColorEnumMap[instance.color],
    };

const _$NotionColorEnumMap = {
  NotionColor.blue: 'blue',
  NotionColor.brown: 'brown',
  NotionColor.defaultColor: 'default',
  NotionColor.gray: 'gray',
  NotionColor.green: 'green',
  NotionColor.orange: 'orange',
  NotionColor.pink: 'pink',
  NotionColor.purple: 'purple',
  NotionColor.red: 'red',
  NotionColor.yellow: 'yellow',
};

StatusOption _$StatusOptionFromJson(Map<String, dynamic> json) => StatusOption(
      id: json['id'] as String,
      name: json['name'] as String,
      color: $enumDecodeNullable(_$NotionColorEnumMap, json['color']),
    );

Map<String, dynamic> _$StatusOptionToJson(StatusOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': _$NotionColorEnumMap[instance.color],
    };

StatusGroup _$StatusGroupFromJson(Map<String, dynamic> json) => StatusGroup(
      id: json['id'] as String,
      name: json['name'] as String,
      color: $enumDecodeNullable(_$NotionColorEnumMap, json['color']),
      optionIds: (json['option_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$StatusGroupToJson(StatusGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': _$NotionColorEnumMap[instance.color],
      'option_ids': instance.optionIds,
    };
