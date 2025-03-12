import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:home_widget/home_widget.dart';

import '../notion/model/task.dart';
import '../notion/model/task_database.dart';
import '../notion/repository/notion_task_repository.dart';

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

@JsonSerializable()
class WidgetValue {
  final List<WidgetTask>? tasks;
  final String? accessToken;
  final TaskDatabase? taskDatabase;

  WidgetValue({this.tasks, this.accessToken, this.taskDatabase});

  factory WidgetValue.fromJson(Map<String, dynamic> json) =>
      _$WidgetValueFromJson(json);

  Map<String, dynamic> toJson() => _$WidgetValueToJson(this);
}

class WidgetService {
  // ウィジェットのグループID
  static const String appGroupId = 'group.com.ymkokh.notionTodo';

  // ウィジェットのデータキー
  static const String todayTasksKey = 'today_tasks';
  static const String accessTokenKey = 'access_token';
  static const String taskDatabaseKey = 'task_database';

  // ウィジェットのURLスキーム
  static const String widgetURLScheme = 'notiontodo://toggle';

  static final WidgetService _instance = WidgetService._();

  factory WidgetService() => _instance;
  WidgetService._();

  Future<WidgetValue> get value async {
    final rowTasks = await HomeWidget.getWidgetData(todayTasksKey);
    final accessToken = await HomeWidget.getWidgetData<String?>(accessTokenKey,
        defaultValue: null);
    final rowTaskDatabase =
        await HomeWidget.getWidgetData<String?>(taskDatabaseKey);

    final List<dynamic>? tasksJson =
        rowTasks != null ? jsonDecode(rowTasks) as List<dynamic> : null;
    List<WidgetTask> tasks = tasksJson
            ?.map<WidgetTask>((dynamic task) =>
                WidgetTask.fromJson(task as Map<String, dynamic>))
            .toList() ??
        [];
    TaskDatabase? taskDatabase = rowTaskDatabase != null
        ? TaskDatabase.fromJson(jsonDecode(rowTaskDatabase))
        : null;

    return WidgetValue(
        tasks: tasks, accessToken: accessToken, taskDatabase: taskDatabase);
  }

  initialize(Function(Uri?) interactivityCallback) async {
    await HomeWidget.setAppGroupId(appGroupId);
    await HomeWidget.registerInteractivityCallback(interactivityCallback);
  }

  sendDatabaseSettings(String? accessToken, TaskDatabase? taskDatabase) async {
    await HomeWidget.saveWidgetData<String?>(
      accessTokenKey,
      accessToken,
    );
    final taskDatabaseJson = jsonEncode(taskDatabase?.toJson());
    await HomeWidget.saveWidgetData<String?>(
      taskDatabaseKey,
      taskDatabaseJson,
    );
    await _updateWidget();
  }

  Future<void> applyTasks(List<Task> tasks) async {
    final widgetTasks = tasks
        .map((task) => WidgetTask(
            id: task.id, title: task.title, isCompleted: task.isCompleted))
        .toList();

    await _sendTasks(widgetTasks);
  }

  Future<void> completeTask(String id, bool isCompleted) async {
    final value = await this.value;
    final tasks = value.tasks;
    if (tasks == null) {
      print('[WidgetService] No widget data found');
      return;
    }

    final updatedTasks = tasks
        .map((task) => task.id == id
            ? WidgetTask(id: id, title: task.title, isCompleted: isCompleted)
            : task)
        .toList();
    await _sendTasks(updatedTasks);
    _updateTaskInNotion(id, isCompleted);

    // 完了したタスクは1秒後にウィジェットから削除
    if (isCompleted) {
      Future.delayed(const Duration(seconds: 1), () async {
        final currentTasks = (await this.value).tasks;
        if (currentTasks == null) return;

        final filteredTasks = currentTasks
            .where((task) => task.id != id || !task.isCompleted)
            .toList();
        if (filteredTasks.length != currentTasks.length) {
          await _sendTasks(filteredTasks);
        }
      });
    }
  }

  // Notionリポジトリを直接使用してタスクを更新するメソッド
  Future<void> _updateTaskInNotion(String id, bool isCompleted) async {
    final value = await this.value;
    final accessToken = value.accessToken;
    final taskDatabase = value.taskDatabase;
    if (accessToken == null || taskDatabase == null) {
      print('[WidgetService] No access token or task database found');
      return;
    }
    try {
      final repository = NotionTaskRepository(accessToken, taskDatabase);
      await repository.updateCompleteStatus(id, isCompleted);
      print(
          '[WidgetService] Task updated directly in Notion: $id, $isCompleted');
    } catch (e) {
      print('[WidgetService] Error updating task directly in Notion: $e');
    }
  }

  _sendTasks(List<WidgetTask> tasks) async {
    final value = tasks.map((task) => task.toJson()).toList();
    final tasksJson = jsonEncode(value);

    await HomeWidget.saveWidgetData(todayTasksKey, tasksJson);
    await _updateWidget();
  }

  _updateWidget() async {
    await HomeWidget.updateWidget(
      androidName: 'TodayTasksWidgetProvider',
      iOSName: 'TodayTasksWidget',
    );
    await HomeWidget.updateWidget(
      androidName: 'TaskProgressWidgetProvider',
      iOSName: 'TaskProgressWidget',
    );
  }
}
