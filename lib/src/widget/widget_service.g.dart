// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WidgetTask _$WidgetTaskFromJson(Map<String, dynamic> json) => WidgetTask(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$WidgetTaskToJson(WidgetTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isCompleted': instance.isCompleted,
    };

WidgetValue _$WidgetValueFromJson(Map<String, dynamic> json) => WidgetValue(
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => WidgetTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      accessToken: json['accessToken'] as String?,
      taskDatabase: json['taskDatabase'] == null
          ? null
          : TaskDatabase.fromJson(json['taskDatabase'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WidgetValueToJson(WidgetValue instance) =>
    <String, dynamic>{
      'tasks': instance.tasks,
      'accessToken': instance.accessToken,
      'taskDatabase': instance.taskDatabase,
    };
