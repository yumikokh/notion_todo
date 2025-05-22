// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotionDateTimeImpl _$$NotionDateTimeImplFromJson(Map<String, dynamic> json) =>
    _$NotionDateTimeImpl(
      datetime: DateTime.parse(json['datetime'] as String),
      isAllDay: json['isAllDay'] as bool,
    );

Map<String, dynamic> _$$NotionDateTimeImplToJson(
        _$NotionDateTimeImpl instance) =>
    <String, dynamic>{
      'datetime': instance.datetime.toIso8601String(),
      'isAllDay': instance.isAllDay,
    };

_$TaskDateImpl _$$TaskDateImplFromJson(Map<String, dynamic> json) =>
    _$TaskDateImpl(
      start: NotionDateTime.fromJson(json['start'] as Map<String, dynamic>),
      end: json['end'] == null
          ? null
          : NotionDateTime.fromJson(json['end'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TaskDateImplToJson(_$TaskDateImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

_$TaskStatusCheckboxImpl _$$TaskStatusCheckboxImplFromJson(
        Map<String, dynamic> json) =>
    _$TaskStatusCheckboxImpl(
      checkbox: json['checkbox'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TaskStatusCheckboxImplToJson(
        _$TaskStatusCheckboxImpl instance) =>
    <String, dynamic>{
      'checkbox': instance.checkbox,
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
      priority: json['priority'] == null
          ? null
          : SelectOption.fromJson(json['priority'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'dueDate': instance.dueDate,
      'url': instance.url,
      'priority': instance.priority,
    };
