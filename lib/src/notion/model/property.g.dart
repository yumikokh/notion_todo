// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TitleProperty _$TitlePropertyFromJson(Map<String, dynamic> json) =>
    TitleProperty(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
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

CheckboxCompleteStatusProperty _$CheckboxCompleteStatusPropertyFromJson(
        Map<String, dynamic> json) =>
    CheckboxCompleteStatusProperty(
      id: json['id'] as String,
      name: json['name'] as String,
      checked: json['checked'] as bool,
    )..type = $enumDecode(_$PropertyTypeEnumMap, json['type']);

Map<String, dynamic> _$CheckboxCompleteStatusPropertyToJson(
        CheckboxCompleteStatusProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'checked': instance.checked,
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
        'groups': instance.status.groups,
        'options': instance.status.options,
      },
      'todoOption': instance.todoOption,
      'inProgressOption': instance.inProgressOption,
      'completeOption': instance.completeOption,
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);

StatusOption _$StatusOptionFromJson(Map<String, dynamic> json) => StatusOption(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$StatusOptionToJson(StatusOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
    };

StatusGroup _$StatusGroupFromJson(Map<String, dynamic> json) => StatusGroup(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String?,
      optionIds: (json['option_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$StatusGroupToJson(StatusGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'option_ids': instance.optionIds,
    };

StatusOptionsByGroup _$StatusOptionsByGroupFromJson(
        Map<String, dynamic> json) =>
    StatusOptionsByGroup(
      groupType: $enumDecode(_$StatusGroupTypeEnumMap, json['groupType']),
      options: (json['options'] as List<dynamic>)
          .map((e) => StatusOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatusOptionsByGroupToJson(
        StatusOptionsByGroup instance) =>
    <String, dynamic>{
      'groupType': _$StatusGroupTypeEnumMap[instance.groupType]!,
      'options': instance.options,
    };

const _$StatusGroupTypeEnumMap = {
  StatusGroupType.todo: 'todo',
  StatusGroupType.inProgress: 'inProgress',
  StatusGroupType.complete: 'complete',
};

SelectOption _$SelectOptionFromJson(Map<String, dynamic> json) => SelectOption(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$SelectOptionToJson(SelectOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
    };

SelectProperty _$SelectPropertyFromJson(Map<String, dynamic> json) =>
    SelectProperty(
      id: json['id'] as String,
      name: json['name'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => SelectOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..type = $enumDecode(_$PropertyTypeEnumMap, json['type']);

Map<String, dynamic> _$SelectPropertyToJson(SelectProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'options': instance.options,
    };
