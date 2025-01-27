// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TitlePropertyImpl _$$TitlePropertyImplFromJson(Map<String, dynamic> json) =>
    _$TitlePropertyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      type: $enumDecodeNullable(_$PropertyTypeEnumMap, json['type']) ??
          PropertyType.title,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TitlePropertyImplToJson(_$TitlePropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'runtimeType': instance.$type,
    };

const _$PropertyTypeEnumMap = {
  PropertyType.title: 'title',
  PropertyType.date: 'date',
  PropertyType.checkbox: 'checkbox',
  PropertyType.status: 'status',
};

_$DatePropertyImpl _$$DatePropertyImplFromJson(Map<String, dynamic> json) =>
    _$DatePropertyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      type: $enumDecodeNullable(_$PropertyTypeEnumMap, json['type']) ??
          PropertyType.date,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DatePropertyImplToJson(_$DatePropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date?.toIso8601String(),
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'runtimeType': instance.$type,
    };

_$CheckboxPropertyImpl _$$CheckboxPropertyImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckboxPropertyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      checked: json['checked'] as bool,
      type: $enumDecodeNullable(_$PropertyTypeEnumMap, json['type']) ??
          PropertyType.checkbox,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CheckboxPropertyImplToJson(
        _$CheckboxPropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'checked': instance.checked,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'runtimeType': instance.$type,
    };

_$StatusPropertyImpl _$$StatusPropertyImplFromJson(Map<String, dynamic> json) =>
    _$StatusPropertyImpl(
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
      completeOption: json['completeOption'] == null
          ? null
          : StatusOption.fromJson(
              json['completeOption'] as Map<String, dynamic>),
      type: $enumDecodeNullable(_$PropertyTypeEnumMap, json['type']) ??
          PropertyType.status,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$StatusPropertyImplToJson(
        _$StatusPropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': <String, dynamic>{
        'groups': instance.status.groups,
        'options': instance.status.options,
      },
      'todoOption': instance.todoOption,
      'completeOption': instance.completeOption,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'runtimeType': instance.$type,
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);

_$CheckboxCompleteStatusPropertyImpl
    _$$CheckboxCompleteStatusPropertyImplFromJson(Map<String, dynamic> json) =>
        _$CheckboxCompleteStatusPropertyImpl(
          id: json['id'] as String,
          name: json['name'] as String,
          checked: json['checked'] as bool,
          type: $enumDecodeNullable(_$PropertyTypeEnumMap, json['type']) ??
              PropertyType.checkbox,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$CheckboxCompleteStatusPropertyImplToJson(
        _$CheckboxCompleteStatusPropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'checked': instance.checked,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'runtimeType': instance.$type,
    };

_$StatusCompleteStatusPropertyImpl _$$StatusCompleteStatusPropertyImplFromJson(
        Map<String, dynamic> json) =>
    _$StatusCompleteStatusPropertyImpl(
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
      completeOption: json['completeOption'] == null
          ? null
          : StatusOption.fromJson(
              json['completeOption'] as Map<String, dynamic>),
      type: $enumDecodeNullable(_$PropertyTypeEnumMap, json['type']) ??
          PropertyType.status,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$StatusCompleteStatusPropertyImplToJson(
        _$StatusCompleteStatusPropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': <String, dynamic>{
        'groups': instance.status.groups,
        'options': instance.status.options,
      },
      'todoOption': instance.todoOption,
      'completeOption': instance.completeOption,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'runtimeType': instance.$type,
    };

_$StatusOptionImpl _$$StatusOptionImplFromJson(Map<String, dynamic> json) =>
    _$StatusOptionImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$StatusOptionImplToJson(_$StatusOptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
    };

_$StatusGroupImpl _$$StatusGroupImplFromJson(Map<String, dynamic> json) =>
    _$StatusGroupImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String?,
      option_ids: (json['option_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$StatusGroupImplToJson(_$StatusGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'option_ids': instance.option_ids,
    };
