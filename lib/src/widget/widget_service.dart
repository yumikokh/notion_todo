import 'dart:convert';

import 'package:home_widget/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notion/model/task.dart';

final widgetServiceProvider = Provider<WidgetService>((ref) {
  return WidgetService();
});

class WidgetService {
  static const String appGroupId = 'group.com.ymkokh.notionTodo';
  static const String todayTasksKey = 'today_tasks';

  Future<void> updateTodayTasks(List<Task> tasks) async {
    try {
      // タスクのタイトルのみを抽出
      final taskTitles = tasks.map((task) => task.title).toList();

      // タスクのタイトルをJSONに変換
      final tasksJson = jsonEncode(taskTitles);

      // ウィジェットにデータを送信
      await HomeWidget.saveWidgetData(
        todayTasksKey,
        tasksJson,
      );

      // ウィジェットを更新
      await HomeWidget.updateWidget(
        name: 'TodayTasksWidgetProvider',
        androidName: 'TodayTasksWidgetProvider',
        iOSName: 'TodayTasksWidget',
        qualifiedAndroidName: 'com.ymkokh.notionTodo.TodayTasksWidgetProvider',
      );
    } catch (e) {
      print('ウィジェットの更新に失敗しました: $e');
    }
  }
}
