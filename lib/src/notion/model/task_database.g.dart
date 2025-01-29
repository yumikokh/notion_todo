// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_database.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskDatabaseImpl _$$TaskDatabaseImplFromJson(Map<String, dynamic> json) =>
    _$TaskDatabaseImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      title: TitleProperty.fromJson(json['title'] as Map<String, dynamic>),
      status: _fromJson(json['status'] as Map<String, dynamic>),
      date: DateProperty.fromJson(json['date'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TaskDatabaseImplToJson(_$TaskDatabaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'status': _toJson(instance.status),
      'date': instance.date,
    };
