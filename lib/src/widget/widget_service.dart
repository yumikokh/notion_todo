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
  static const String widgetURLScheme = 'notiontodo://widget/toggleTask';

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
  Future<bool> handleWidgetURL(Uri uri, {bool isBackground = false}) async {
    try {
      print('処理するURL: ${uri.toString()}');

      // 単純化したURLスキーム形式を処理
      // notionTodo://toggle/{taskId}/{isCompleted}
      final pathSegments = uri.pathSegments;
      if (pathSegments.length >= 3 && pathSegments[0] == 'toggle') {
        final taskId = pathSegments[1];
        // isCompletedStrにはhomeWidgetパラメータが含まれている可能性があるため、分割して処理
        String isCompletedStr = pathSegments[2];

        // homeWidgetパラメータが含まれている場合は除去
        if (isCompletedStr.contains('&')) {
          isCompletedStr = isCompletedStr.split('&')[0];
        }

        print('単純化URLスキーム - タスクID: $taskId, 完了状態: $isCompletedStr');

        if (taskId.isNotEmpty) {
          final isCompleted = isCompletedStr.toLowerCase() == 'true';

          // Notionのタスク状態を更新
          await updateTaskCompletionInNotion(taskId, isCompleted);
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
  Future<void> updateTaskCompletionInNotion(
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
