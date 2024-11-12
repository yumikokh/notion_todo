// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_database_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SelectedTaskDatabaseImpl _$$SelectedTaskDatabaseImplFromJson(
        Map<String, dynamic> json) =>
    _$SelectedTaskDatabaseImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      status:
          TaskStatusProperty.fromJson(json['status'] as Map<String, dynamic>),
      date: TaskDateProperty.fromJson(json['date'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SelectedTaskDatabaseImplToJson(
        _$SelectedTaskDatabaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'date': instance.date,
    };
