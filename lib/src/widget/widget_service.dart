import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:home_widget/home_widget.dart';

import '../notion/model/task.dart';

part 'widget_service.g.dart';

@JsonSerializable()
class WidgetTask {
  final String id;
  final String title;
  final bool isCompleted;

  WidgetTask({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory WidgetTask.fromJson(Map<String, dynamic> json) =>
      _$WidgetTaskFromJson(json);

  Map<String, dynamic> toJson() => _$WidgetTaskToJson(this);
}

class WidgetService {
  static const String appGroupId = 'group.com.ymkokh.notionTodo';
  static const String todayTasksKey = 'today_tasks';
  static const String widgetURLScheme = 'notionTodoWidget://toggle';

  initialize(Function(Uri?) interactivityCallback) async {
    await HomeWidget.setAppGroupId(appGroupId);
    await HomeWidget.registerInteractivityCallback(interactivityCallback);
  }

  Future<void> applyTasks(List<Task> tasks) async {
    final widgetTasks = tasks
        .map((task) => WidgetTask(
            id: task.id, title: task.title, isCompleted: task.isCompleted))
        .toList();

    await _sendAndUpdate(widgetTasks);
  }

  Future<void> completeTask(String id, bool isCompleted) async {
    final value = await HomeWidget.getWidgetData(todayTasksKey);
    final taskMaps = jsonDecode(value) as List<dynamic>;
    print('taskMaps: $taskMaps');
    final updatedTaskMaps = taskMaps
        .map((task) => task['id'] == id
            ? WidgetTask(id: id, title: task['title'], isCompleted: isCompleted)
            : WidgetTask(
                id: task['id'],
                title: task['title'],
                isCompleted: task['isCompleted']))
        .toList();

    await _sendAndUpdate(updatedTaskMaps);
  }

  _sendAndUpdate(List<WidgetTask> tasks) async {
    final value = tasks.map((task) => task.toJson()).toList();
    final tasksJson = jsonEncode(value);
    await HomeWidget.saveWidgetData(todayTasksKey, tasksJson);
    // ウィジェットを更新
    await HomeWidget.updateWidget(
      androidName: 'TodayTasksWidgetProvider',
      iOSName: 'TodayTasksWidget',
    );
  }
}
