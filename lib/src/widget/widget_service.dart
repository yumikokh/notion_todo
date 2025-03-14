import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:home_widget/home_widget.dart';

import '../notion/model/task.dart';
import '../notion/model/task_database.dart';
import '../notion/repository/notion_task_repository.dart';
import '../notion/tasks/task_viewmodel.dart';
import '../notion/tasks/view/task_main_page.dart';
import '../notion/tasks/view/task_sheet/task_sheet.dart';

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
  static const String lastUpdatedTaskKey = 'last_updated_task';

  static const String widgetScheme = 'notiontodo';

  static final WidgetService _instance = WidgetService._();

  factory WidgetService() => _instance;
  WidgetService._();

  // アプリバックグラウンド復帰時に使用するストリームコントローラー
  StreamSubscription<Uri?>? _widgetClickedSubscription;

  // アプリが起動中にウィジェットクリックを検出するためのストリームを取得
  Stream<Uri?> get widgetClicked => HomeWidget.widgetClicked;

  // ウィジェットから起動されたかどうかを確認するメソッド
  Future<Uri?> registerInitialLaunchFromWidget(
      GlobalKey<NavigatorState> globalNavigatorKey, WidgetRef ref) async {
    print('[WidgetService] registerInitialLaunchFromWidget');
    final uri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    await _handleWidgetLaunch(uri, globalNavigatorKey, ref);
    return uri;
  }

  // ウィジェットからのクリックを監視開始
  void startListeningWidgetClicks(
      GlobalKey<NavigatorState> globalNavigatorKey, WidgetRef ref) {
    print('[WidgetService] startListeningWidgetClicks');
    // 既存のサブスクリプションがあれば解除
    _widgetClickedSubscription?.cancel();
    _widgetClickedSubscription = HomeWidget.widgetClicked.listen((uri) {
      print('[WidgetService] widgetClicked: $uri');
      _handleWidgetLaunch(uri, globalNavigatorKey, ref);
    });
  }

  // ウィジェットからのクリック監視を停止
  void stopListeningWidgetClicks() {
    print('[WidgetService] Stopping widget click listener');
    _widgetClickedSubscription?.cancel();
    _widgetClickedSubscription = null;
  }

  Future<void> _handleWidgetLaunch(Uri? uri,
      GlobalKey<NavigatorState> globalNavigatorKey, WidgetRef ref) async {
    if (uri == null || uri.scheme != widgetScheme) return;

    if (uri.host == "add_task") {
      return WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleWidgetLaunchAddTaskToToday(globalNavigatorKey, ref);
      });
    }
  }

  // ウィジェットからの起動処理
  Future<void> _handleWidgetLaunchAddTaskToToday(
      GlobalKey<NavigatorState> globalNavigatorKey, WidgetRef ref) async {
    _navigateToTodayPage(globalNavigatorKey);

    final context = globalNavigatorKey.currentContext;
    final todayViewModel =
        ref.read(taskViewModelProvider(filterType: FilterType.today).notifier);
    final initialDueDate = TaskDate(
      start: NotionDateTime(
        datetime: DateTime.now(),
        isAllDay: true,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context != null) {
        _showTaskSheet(context, todayViewModel.addTask, initialDueDate);
      }
    });
  }

  _navigateToTodayPage(GlobalKey<NavigatorState> globalNavigatorKey) {
    final currentState = globalNavigatorKey.currentState;
    if (currentState == null) return;
    currentState.pushNamedAndRemoveUntil(
        TaskMainPage.routeName, (route) => false);
  }

  Future<void> _showTaskSheet(
      BuildContext context,
      Future<void> Function(String, TaskDate?, bool needSnackbarFloating)
          onAddTask,
      TaskDate? initialDueDate) async {
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => TaskSheet(
        initialDueDate: initialDueDate,
        initialTitle: null,
        onSubmitted: (title, dueDate, {bool? needSnackbarFloating}) {
          onAddTask(title, dueDate, needSnackbarFloating ?? false);
        },
      ),
    );
  }

  /////////////////////////

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

  // ウィジェットのインタラクティブコールバック
  Future<void> interactivityCallback(Uri? uri) async {
    if (uri == null || uri.scheme != widgetScheme) return;
    final action = uri.host;
    final pathSegments = uri.pathSegments;
    try {
      if (action == 'toggle') {
        final [taskId, isCompletedStr] = pathSegments;
        final isCompleted = isCompletedStr.toLowerCase() == 'true';
        await _completeTask(taskId, isCompleted);
      }
    } catch (e) {
      print('[HomeWidget] Error in interactivity callback: $e');
    }
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

  Future<void> _completeTask(String id, bool isCompleted) async {
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

    await _saveLastUpdatedTask(id, isCompleted);

    _updateTaskInNotion(id, isCompleted);
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

  // 最後に更新したタスク情報を保存
  Future<void> _saveLastUpdatedTask(String taskId, bool isCompleted) async {
    final data = jsonEncode({
      'id': taskId,
      'isCompleted': isCompleted,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
    await HomeWidget.saveWidgetData(lastUpdatedTaskKey, data);
  }

  // 最後に更新したタスク情報を取得
  Future<Map<String, dynamic>?> getLastUpdatedTask() async {
    final data = await HomeWidget.getWidgetData<String?>(lastUpdatedTaskKey);
    if (data == null) return null;

    try {
      final Map<String, dynamic> taskInfo = jsonDecode(data);
      return taskInfo;
    } catch (e) {
      print('[WidgetService] Error parsing last updated task: $e');
      return null;
    }
  }

  // 最後に更新したタスク情報をクリア
  Future<void> clearLastUpdatedTask() async {
    await HomeWidget.saveWidgetData(lastUpdatedTaskKey, null);
  }
}
