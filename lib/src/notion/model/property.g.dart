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
    );

Map<String, dynamic> _$TitlePropertyToJson(TitleProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
    };

DateProperty _$DatePropertyFromJson(Map<String, dynamic> json) => DateProperty(
      id: json['id'] as String,
      name: json['name'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$DatePropertyToJson(DateProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date?.toIso8601String(),
    };

CheckboxCompleteStatusProperty _$CheckboxCompleteStatusPropertyFromJson(
        Map<String, dynamic> json) =>
    CheckboxCompleteStatusProperty(
      id: json['id'] as String,
      name: json['name'] as String,
      checked: json['checked'] as bool,
    );

Map<String, dynamic> _$CheckboxCompleteStatusPropertyToJson(
        CheckboxCompleteStatusProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
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
      completeOption: json['completeOption'] == null
          ? null
          : StatusOption.fromJson(
              json['completeOption'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StatusCompleteStatusPropertyToJson(
        StatusCompleteStatusProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': <String, dynamic>{
        'groups': instance.status.groups,
        'options': instance.status.options,
      },
      'todoOption': instance.todoOption,
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
