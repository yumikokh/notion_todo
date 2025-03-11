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
