// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskDateImpl _$$TaskDateImplFromJson(Map<String, dynamic> json) =>
    _$TaskDateImpl(
      start: json['start'] as String,
      end: json['end'] as String?,
    );

Map<String, dynamic> _$$TaskDateImplToJson(_$TaskDateImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

_$TaskStatusCheckboxImpl _$$TaskStatusCheckboxImplFromJson(
        Map<String, dynamic> json) =>
    _$TaskStatusCheckboxImpl(
      checked: json['checked'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TaskStatusCheckboxImplToJson(
        _$TaskStatusCheckboxImpl instance) =>
    <String, dynamic>{
      'checked': instance.checked,
      'runtimeType': instance.$type,
    };

_$TaskStatusStatusImpl _$$TaskStatusStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$TaskStatusStatusImpl(
      group: json['group'] == null
          ? null
          : StatusGroup.fromJson(json['group'] as Map<String, dynamic>),
      option: json['option'] == null
          ? null
          : StatusOption.fromJson(json['option'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TaskStatusStatusImplToJson(
        _$TaskStatusStatusImpl instance) =>
    <String, dynamic>{
      'group': instance.group,
      'option': instance.option,
      'runtimeType': instance.$type,
    };

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      status: TaskStatus.fromJson(json['status'] as Map<String, dynamic>),
      dueDate: json['dueDate'] == null
          ? null
          : TaskDate.fromJson(json['dueDate'] as Map<String, dynamic>),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'dueDate': instance.dueDate,
      'url': instance.url,
    };
