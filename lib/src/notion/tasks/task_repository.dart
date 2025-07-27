import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/utils/notion_converter.dart';
import '../../settings/task_database/task_database_viewmodel.dart';
import '../../widget/widget_service.dart';
import '../common/filter_type.dart';
import '../model/task.dart';
import '../model/task_database.dart';
import '../oauth/notion_oauth_viewmodel.dart';
import '../api/notion_task_api.dart';
import '../api/notion_database_api.dart';
import '../cache/relation_cache.dart';
import '../cache/relation_type.dart';
import '../model/property.dart';

part 'task_repository.g.dart';

class TaskResult {
  final List<Task> tasks;
  final bool hasMore;
  final String? nextCursor;

  TaskResult({
    required this.tasks,
    required this.hasMore,
    this.nextCursor,
  });
}

@riverpod
Future<TaskRepository?> taskRepository(Ref ref) async {
  final taskDatabase = await ref.watch(taskDatabaseViewModelProvider.future);
  final accessToken =
      ref.watch(notionOAuthViewModelProvider).valueOrNull?.accessToken;
  WidgetService.sendDatabaseSettings(accessToken, taskDatabase);

  if (accessToken == null || taskDatabase == null) {
    return null;
  }
  final notionTaskApi = NotionTaskApi(accessToken, taskDatabase);
  final notionDatabaseApi = NotionDatabaseApi(accessToken);

  return TaskRepository(notionTaskApi, notionDatabaseApi, taskDatabase);
}

class TaskRepository {
  final NotionTaskApi notionTaskApi;
  final NotionDatabaseApi notionDatabaseApi;
  final TaskDatabase taskDatabase;
  final RelationCache _relationCache = RelationCache();

  TaskRepository(this.notionTaskApi, this.notionDatabaseApi, this.taskDatabase);

  Future<bool> loadShowCompleted() async {
    return await notionTaskApi.loadShowCompleted();
  }

  Future<void> saveShowCompleted(bool value) async {
    await notionTaskApi.saveShowCompleted(value);
  }

  Future<TaskResult> fetchTasks(FilterType filterType, bool hasCompleted,
      {String? startCursor}) async {
    final data = await notionTaskApi.fetchPages(filterType, hasCompleted,
        startCursor: startCursor);

    final tasks = (data['results'] as List<dynamic>)
        .map((dynamic page) =>
            NotionConverter.createTaskFromData(page, taskDatabase))
        .toList();

    // リレーション情報を補完
    final enrichedTasks = await _enrichTasksWithRelations(tasks);

    return TaskResult(
      tasks: enrichedTasks,
      hasMore: data['has_more'] ?? false,
      nextCursor: data['next_cursor'],
    );
  }

  Future<Task> addTask(Task task) async {
    final data = await notionTaskApi.addTask(task);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      throw Exception('Failed to add task');
    }
    final newTask = NotionConverter.createTaskFromData(data, taskDatabase);
    final enrichedTasks = await _enrichTasksWithRelations([newTask]);
    return enrichedTasks.first;
  }

  Future<Task> updateTask(Task task) async {
    final data = await notionTaskApi.updateTask(task);
    if (data == null || data['id'] == null || data['object'] == 'error') {
      throw Exception('Failed to update task');
    }
    final updatedTask = NotionConverter.createTaskFromData(data, taskDatabase);
    final enrichedTasks = await _enrichTasksWithRelations([updatedTask]);
    return enrichedTasks.first;
  }

  Future<Task> updateCompleteStatus(String taskId, bool isCompleted) async {
    final data = await notionTaskApi.updateCompleteStatus(taskId, isCompleted);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      throw Exception('Failed to update task');
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task> updateInProgressStatus(String taskId, bool isInProgress) async {
    final data =
        await notionTaskApi.updateInProgressStatus(taskId, isInProgress);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      throw Exception('Failed to update task');
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task?> deleteTask(String taskId) async {
    final data = await notionTaskApi.deleteTask(taskId);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      return null;
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  Future<Task?> undoDeleteTask(String taskId) async {
    final data = await notionTaskApi.revertTask(taskId);
    if (data == null || data.isEmpty || data['object'] == 'error') {
      return null;
    }
    return NotionConverter.createTaskFromData(data, taskDatabase);
  }

  /// タスクリストにリレーション情報を補完する
  Future<List<Task>> _enrichTasksWithRelations(List<Task> tasks) async {
    try {
      // プロジェクトを補完（固有の処理）
      await _enrichProjectRelations(tasks);

      // その他のリレーションを補完（動的な処理）
      await _enrichOtherRelations(tasks);

      return tasks;
    } catch (e) {
      print('Error enriching tasks with relations: $e');
      return tasks;
    }
  }

  /// プロジェクトのリレーション情報を補完
  Future<void> _enrichProjectRelations(List<Task> tasks) async {
    await _enrichRelationType(
      tasks: tasks,
      relationType: RelationType.project,
      getRelations: (task) => task.projects,
      updateTask: (task, enrichedRelations) =>
          task.copyWith(projects: enrichedRelations),
    );
  }

  /// その他のリレーション情報を補完
  Future<void> _enrichOtherRelations(List<Task> tasks) async {
    final taskDatabase = this.taskDatabase;
    final additionalProperties = taskDatabase.additionalProperties;

    if (additionalProperties == null || additionalProperties.isEmpty) {
      return;
    }

    // リレーションプロパティのみ補完処理を実行
    for (final entry in additionalProperties.entries) {
      final propertyId = entry.key;
      final property = entry.value;

      // リレーションプロパティの場合のみ処理
      if (property.type == PropertyType.relation) {
        await _enrichRelationType(
          tasks: tasks,
          relationType: RelationType(propertyId), // 動的なリレーションタイプ
          getRelations: (task) {
            final value = task.additionalFields?[propertyId];
            return value is List ? value.cast<RelationOption>() : null;
          },
          updateTask: (task, enrichedRelations) {
            final updatedFields = Map<String, dynamic>.from(
              task.additionalFields ?? {},
            );
            updatedFields[propertyId] = enrichedRelations;
            return task.copyWith(additionalFields: updatedFields);
          },
        );
      }
    }
  }

  /// 特定のリレーションタイプの情報を補完する汎用メソッド
  Future<void> _enrichRelationType({
    required List<Task> tasks,
    required RelationType relationType,
    required List<RelationOption>? Function(Task) getRelations,
    required Task Function(Task, List<RelationOption>) updateTask,
  }) async {
    // リレーションIDを収集
    final relationIds = <String>{};
    for (final task in tasks) {
      final relations = getRelations(task);
      if (relations != null && relations.isNotEmpty) {
        for (final relation in relations) {
          relationIds.add(relation.id);
        }
      }
    }

    if (relationIds.isEmpty) {
      return;
    }

    // キャッシュされていないIDを取得
    final uncachedIds =
        _relationCache.getUncachedIds(relationType.value, relationIds.toList());

    // キャッシュされていない情報を取得
    if (uncachedIds.isNotEmpty) {
      await _fetchAndCacheRelations(relationType, uncachedIds);
    }

    // タスクのリレーション情報を補完
    for (var i = 0; i < tasks.length; i++) {
      final task = tasks[i];
      final relations = getRelations(task);
      if (relations != null && relations.isNotEmpty) {
        final enrichedRelations =
            _relationCache.enrichRelationOptions(relationType.value, relations);
        tasks[i] = updateTask(task, enrichedRelations);
      }
    }
  }

  /// リレーション情報を取得してキャッシュに保存
  Future<void> _fetchAndCacheRelations(
      RelationType relationType, List<String> relationIds) async {
    try {
      // リレーションタイプに応じてデータベースIDを取得
      final databaseId = await _getRelationDatabaseId(relationType);
      if (databaseId == null) {
        return;
      }

      // データベース全体を取得
      final allPages = await notionDatabaseApi.fetchDatabasePagesById(databaseId);
      
      // 必要なIDのページのみをフィルタリング
      final relationIdSet = relationIds.toSet();
      final pages = allPages.where((page) {
        final id = page['id'] as String?;
        return id != null && relationIdSet.contains(id);
      }).toList();
      
      final relationInfo = <String, String>{};

      for (final page in pages) {
        final id = page['id'] as String?;
        final properties = page['properties'] as Map<String, dynamic>?;

        if (id != null && properties != null) {
          // タイトルプロパティを探す
          final title = _extractTitleFromProperties(properties);
          if (title != null && title.isNotEmpty) {
            relationInfo[id] = title;
          }
        }
      }

      // キャッシュに保存
      _relationCache.setMultiple(relationType.value, relationInfo);
    } catch (e) {
      // エラーが発生しても処理を続行
    }
  }

  /// リレーションタイプに対応するデータベースIDを取得
  Future<String?> _getRelationDatabaseId(RelationType relationType) async {
    if (relationType == RelationType.project) {
      // プロジェクトの場合
      final projectProperty = taskDatabase.project;
      if (projectProperty is RelationProperty) {
        return projectProperty.relation['database_id'] as String?;
      }
    } else {
      // その他のリレーションプロパティの場合
      final additionalProperties = taskDatabase.additionalProperties;
      if (additionalProperties == null) return null;
      
      final property = additionalProperties[relationType.value];
      if (property is RelationProperty) {
        return property.relation['database_id'] as String?;
      }
    }
    return null;
  }

  /// プロパティからタイトルを抽出するヘルパーメソッド
  String? _extractTitleFromProperties(Map<String, dynamic> properties) {
    for (final entry in properties.entries) {
      final property = entry.value as Map<String, dynamic>?;
      if (property != null && property['type'] == 'title') {
        final titleArray = property['title'] as List<dynamic>?;
        if (titleArray != null && titleArray.isNotEmpty) {
          return titleArray[0]['plain_text'] as String?;
        }
      }
    }
    return null;
  }
}
