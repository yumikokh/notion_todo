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
      properties: (json['properties'] as List<dynamic>)
          .map((e) => Property.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusId: json['statusId'] as String?,
      dateId: json['dateId'] as String?,
    );

Map<String, dynamic> _$$SelectedTaskDatabaseImplToJson(
        _$SelectedTaskDatabaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'properties': instance.properties,
      'statusId': instance.statusId,
      'dateId': instance.dateId,
    };
