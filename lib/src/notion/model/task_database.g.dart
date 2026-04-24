// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_database.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskDatabase _$TaskDatabaseFromJson(Map<String, dynamic> json) =>
    _TaskDatabase(
      id: json['id'] as String,
      name: json['name'] as String,
      title: TitleProperty.fromJson(json['title'] as Map<String, dynamic>),
      status: CompleteStatusProperty.fromJson(
        json['status'] as Map<String, dynamic>,
      ),
      date: DateProperty.fromJson(json['date'] as Map<String, dynamic>),
      priority: json['priority'] == null
          ? null
          : SelectProperty.fromJson(json['priority'] as Map<String, dynamic>),
      project: json['project'] == null
          ? null
          : RelationProperty.fromJson(json['project'] as Map<String, dynamic>),
      additionalProperties:
          (json['additionalProperties'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Property.fromJson(e as Map<String, dynamic>)),
          ) ??
          {},
    );

Map<String, dynamic> _$TaskDatabaseToJson(_TaskDatabase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title.toJson(),
      'status': instance.status.toJson(),
      'date': instance.date.toJson(),
      'priority': instance.priority?.toJson(),
      'project': instance.project?.toJson(),
      'additionalProperties': instance.additionalProperties?.map(
        (k, e) => MapEntry(k, e.toJson()),
      ),
    };
