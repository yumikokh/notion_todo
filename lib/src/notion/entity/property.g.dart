// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DatePropertyImpl _$$DatePropertyImplFromJson(Map<String, dynamic> json) =>
    _$DatePropertyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$PropertyTypeEnumMap, json['type']),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DatePropertyImplToJson(_$DatePropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'date': instance.date?.toIso8601String(),
      'runtimeType': instance.$type,
    };

const _$PropertyTypeEnumMap = {
  PropertyType.date: 'date',
  PropertyType.checkbox: 'checkbox',
  PropertyType.status: 'status',
};

_$CheckboxPropertyImpl _$$CheckboxPropertyImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckboxPropertyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$PropertyTypeEnumMap, json['type']),
      checked: json['checked'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CheckboxPropertyImplToJson(
        _$CheckboxPropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'checked': instance.checked,
      'runtimeType': instance.$type,
    };

_$StatusPropertyImpl _$$StatusPropertyImplFromJson(Map<String, dynamic> json) =>
    _$StatusPropertyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$PropertyTypeEnumMap, json['type']),
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
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$StatusPropertyImplToJson(
        _$StatusPropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'status': <String, dynamic>{
        'groups': instance.status.groups,
        'options': instance.status.options,
      },
      'runtimeType': instance.$type,
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);

_$TaskDatePropertyImpl _$$TaskDatePropertyImplFromJson(
        Map<String, dynamic> json) =>
    _$TaskDatePropertyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$PropertyTypeEnumMap, json['type']),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$TaskDatePropertyImplToJson(
        _$TaskDatePropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'date': instance.date?.toIso8601String(),
    };

_$CheckboxTaskStatusPropertyImpl _$$CheckboxTaskStatusPropertyImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckboxTaskStatusPropertyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$PropertyTypeEnumMap, json['type']),
      checked: json['checked'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CheckboxTaskStatusPropertyImplToJson(
        _$CheckboxTaskStatusPropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'checked': instance.checked,
      'runtimeType': instance.$type,
    };

_$StatusTaskStatusPropertyImpl _$$StatusTaskStatusPropertyImplFromJson(
        Map<String, dynamic> json) =>
    _$StatusTaskStatusPropertyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$PropertyTypeEnumMap, json['type']),
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
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$StatusTaskStatusPropertyImplToJson(
        _$StatusTaskStatusPropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$PropertyTypeEnumMap[instance.type]!,
      'status': <String, dynamic>{
        'groups': instance.status.groups,
        'options': instance.status.options,
      },
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
