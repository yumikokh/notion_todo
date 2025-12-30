// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotionDateTime _$NotionDateTimeFromJson(Map<String, dynamic> json) =>
    _NotionDateTime(
      datetime: DateTime.parse(json['datetime'] as String),
      isAllDay: json['isAllDay'] as bool,
    );

Map<String, dynamic> _$NotionDateTimeToJson(_NotionDateTime instance) =>
    <String, dynamic>{
      'datetime': instance.datetime.toIso8601String(),
      'isAllDay': instance.isAllDay,
    };

_TaskDate _$TaskDateFromJson(Map<String, dynamic> json) => _TaskDate(
  start: NotionDateTime.fromJson(json['start'] as Map<String, dynamic>),
  end: json['end'] == null
      ? null
      : NotionDateTime.fromJson(json['end'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TaskDateToJson(_TaskDate instance) => <String, dynamic>{
  'start': instance.start,
  'end': instance.end,
};

TaskStatusCheckbox _$TaskStatusCheckboxFromJson(Map<String, dynamic> json) =>
    TaskStatusCheckbox(
      checkbox: json['checkbox'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TaskStatusCheckboxToJson(TaskStatusCheckbox instance) =>
    <String, dynamic>{
      'checkbox': instance.checkbox,
      'runtimeType': instance.$type,
    };

TaskStatusStatus _$TaskStatusStatusFromJson(Map<String, dynamic> json) =>
    TaskStatusStatus(
      group: json['group'] == null
          ? null
          : StatusGroup.fromJson(json['group'] as Map<String, dynamic>),
      option: json['option'] == null
          ? null
          : StatusOption.fromJson(json['option'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TaskStatusStatusToJson(TaskStatusStatus instance) =>
    <String, dynamic>{
      'group': instance.group,
      'option': instance.option,
      'runtimeType': instance.$type,
    };

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  title: json['title'] as String,
  status: TaskStatus.fromJson(json['status'] as Map<String, dynamic>),
  dueDate: json['dueDate'] == null
      ? null
      : TaskDate.fromJson(json['dueDate'] as Map<String, dynamic>),
  url: json['url'] as String?,
  icon: json['icon'] as String?,
  priority: json['priority'] == null
      ? null
      : SelectOption.fromJson(json['priority'] as Map<String, dynamic>),
  projects: (json['projects'] as List<dynamic>?)
      ?.map((e) => RelationOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalFields: json['additionalFields'] as Map<String, dynamic>? ?? {},
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'status': instance.status,
  'dueDate': instance.dueDate,
  'url': instance.url,
  'icon': instance.icon,
  'priority': instance.priority,
  'projects': instance.projects,
  'additionalFields': instance.additionalFields,
};
