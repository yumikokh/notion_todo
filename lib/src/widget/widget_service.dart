import 'dart:convert';

import 'package:home_widget/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import '../notion/model/task.dart';
import '../notion/repository/notion_task_repository.dart';

final widgetServiceProvider = Provider<WidgetService>((ref) {
  return WidgetService(ref);
});

class WidgetService {
  final Ref _ref;

  WidgetService(this._ref);

  static const String appGroupId = 'group.com.ymkokh.notionTodo';
  static const String todayTasksKey = 'today_tasks';
  static const String widgetURLScheme = 'notionTodo://widget/toggleTask';

  Future<void> updateTodayTasks(List<Task> tasks) async {
    try {
      // タスクのタイトルと完了状態を含むマップを作成
      final taskMaps = tasks
          .map((task) => {
                'id': task.id,
                'title': task.title,
                'isCompleted': task.isCompleted,
              })
          .toList();

      // タスクデータをJSONに変換
      final tasksJson = jsonEncode(taskMaps);

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

  // ウィジェットからのURLスキームを処理する
  Future<bool> handleWidgetURL(Uri uri) async {
    try {
      print('処理するURL: ${uri.toString()}');

      // 単純化したURLスキーム形式を処理
      // notionTodo://toggle/{taskId}/{isCompleted}
      final pathSegments = uri.pathSegments;
      if (pathSegments.length >= 3 && pathSegments[0] == 'toggle') {
        final taskId = pathSegments[1];
        final isCompletedStr = pathSegments[2];

        print('単純化URLスキーム - タスクID: $taskId, 完了状態: $isCompletedStr');

        if (taskId.isNotEmpty) {
          final isCompleted = isCompletedStr.toLowerCase() == 'true';

          // Notionのタスク状態を更新
          await _updateTaskCompletionInNotion(taskId, isCompleted);
          return true;
        }
      }

      // 従来のクエリパラメータ形式も処理（後方互換性のため）
      if (uri.toString().contains('toggleTask')) {
        // パラメータを取得
        final taskId = uri.queryParameters['id'];
        final isCompletedStr = uri.queryParameters['completed'];

        print('従来形式 - タスクID: $taskId, 完了状態: $isCompletedStr');

        if (taskId != null && isCompletedStr != null) {
          final isCompleted = isCompletedStr.toLowerCase() == 'true';

          // Notionのタスク状態を更新
          await _updateTaskCompletionInNotion(taskId, isCompleted);
          return true;
        }
      }

      return false;
    } catch (e) {
      print('ウィジェットURLの処理に失敗しました: $e');
      return false;
    }
  }

  // Notionのタスク状態を更新する
  Future<void> _updateTaskCompletionInNotion(
      String taskId, bool isCompleted) async {
    try {
      final repository = _ref.read(notionTaskRepositoryProvider);
      if (repository != null) {
        await repository.updateCompleteStatus(taskId, isCompleted);

        // 更新成功時にハプティックフィードバックを提供
        await HapticFeedback.mediumImpact();

        print('タスク $taskId の完了状態を $isCompleted に更新しました');
      } else {
        print('Notionリポジトリが見つかりません');
      }
    } catch (e) {
      print('Notionタスクの更新に失敗しました: $e');
    }
  }
}
