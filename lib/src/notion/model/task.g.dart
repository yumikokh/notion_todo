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

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
      dueDate: json['dueDate'] == null
          ? null
          : TaskDate.fromJson(json['dueDate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isCompleted': instance.isCompleted,
      'dueDate': instance.dueDate,
    };
