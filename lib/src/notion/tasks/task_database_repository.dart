import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/index.dart';
import '../model/task_database.dart';
import '../oauth/notion_oauth_viewmodel.dart';
import '../api/notion_database_api.dart';

part 'task_database_repository.g.dart';

class TaskDatabaseRepository {
  static const _taskDatabaseKey = 'taskDatabase';
  final NotionDatabaseApi? notionDatabaseApi;

  TaskDatabaseRepository({required this.notionDatabaseApi});

  Future<TaskDatabase?> loadSetting() async {
    final pref = await SharedPreferences.getInstance();
    final taskDatabaseString = pref.getString(_taskDatabaseKey);
    if (taskDatabaseString == null) {
      return null;
    }
    final taskDatabaseJson = jsonDecode(taskDatabaseString);
    return TaskDatabase.fromJson(taskDatabaseJson);
  }

  /// 保存されているデータベース情報を最新の情報で更新する
  Future<TaskDatabase> updateDatabaseWithLatestInfo(
      TaskDatabase taskDatabase) async {
    try {
      final latestDatabase = await _fetchDatabase(taskDatabase.id);
      final updatedTaskDatabase =
          _updateTaskDatabaseProperties(taskDatabase, latestDatabase);
      await save(updatedTaskDatabase);
      return updatedTaskDatabase;
    } catch (e) {
      rethrow;
    }
  }

  /// 指定されたIDのデータベースを取得する
  Future<Database> _fetchDatabase(String databaseId) async {
    final data = await notionDatabaseApi?.fetchDatabase(databaseId);
    if (data == null) {
      throw Exception('Database not found');
    }
    return _getDatabase(data);
  }

  /// データベースのプロパティを最新の情報で更新する
  TaskDatabase _updateTaskDatabaseProperties(
      TaskDatabase savedDatabase, Database latestDatabase) {
    Property findProperty(String targetId, List<Property> latestProperties) {
      return latestProperties.firstWhere((p) => p.id == targetId,
          orElse: () => throw Exception('Property not found: $targetId'));
    }

    final titleProperty =
        findProperty(savedDatabase.title.id, latestDatabase.properties);
    var statusProperty =
        findProperty(savedDatabase.status.id, latestDatabase.properties);
    final dateProperty =
        findProperty(savedDatabase.date.id, latestDatabase.properties);
    final priorityProperty = savedDatabase.priority != null
        ? findProperty(savedDatabase.priority!.id, latestDatabase.properties)
        : null;
    final projectProperty = savedDatabase.project != null
        ? findProperty(savedDatabase.project!.id, latestDatabase.properties)
        : null;

    if (titleProperty is! TitleProperty ||
        dateProperty is! DateProperty ||
        (statusProperty is! CheckboxProperty &&
            statusProperty is! StatusProperty) ||
        (priorityProperty is! SelectProperty?) ||
        (projectProperty is! RelationProperty?)) {
      throw Exception(
          'Property types do not match ${titleProperty.type.name} ${dateProperty.type.name} ${statusProperty.type.name} ${priorityProperty?.type.name} ${projectProperty?.type.name}');
    }

    final updatedStatusProperty =
        switch ((statusProperty, savedDatabase.status)) {
      (StatusProperty status, StatusCompleteStatusProperty savedStatus) =>
        StatusCompleteStatusProperty.fromSavedStatusOptions(
          newStatusProperty: status,
          savedStatus: savedStatus,
        ),
      (CheckboxProperty checkbox, _) =>
        CheckboxCompleteStatusProperty.fromJson(checkbox.toJson()),
      _ => throw Exception('Invalid property type'),
    };

    return TaskDatabase(
      id: latestDatabase.id,
      name: latestDatabase.name,
      title: titleProperty,
      status: updatedStatusProperty as CompleteStatusProperty,
      date: dateProperty,
      priority: priorityProperty,
      project: projectProperty,
    );
  }

  Future<void> save(TaskDatabase taskDatabase) async {
    // 永続化する
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_taskDatabaseKey, jsonEncode(taskDatabase.toJson()));
  }

  clear() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_taskDatabaseKey);
  }

  Future<List<Database>> fetchDatabases() async {
    final data = await notionDatabaseApi?.fetchAccessibleDatabases();
    if (data == null) {
      return [];
    }
    final databases = data.map<Database>((e) => _getDatabase(e)).toList();

    return databases;
  }

  Future<Property?> createProperty(
      String databaseId, CreatePropertyType type, String name) async {
    final data =
        await notionDatabaseApi?.createProperty(databaseId, type, name);
    if (data == null) {
      return null;
    }
    final properties = _getPropertiesFromJson(data["properties"]);
    return properties
        .where((property) =>
            property.name == name && property.type.name == type.name)
        .firstOrNull;
  }

  Database _getDatabase(Map<String, dynamic> e) {
    final id = e['id'];
    final name =
        e['title'].length > 0 ? e['title'][0]['plain_text'] : 'NoTitle';
    final url = e['url'];
    final properties = _getPropertiesFromJson(e['properties']);
    return Database(id: id, name: name, url: url, properties: properties);
  }

  List<Property> _getPropertiesFromJson(Map<String, dynamic> properties) {
    final list = properties.entries
        // typeがtitle, date, checkbox, status, select, relationのものだけを取得
        .where((entry) => PropertyType.values
            .any((propertyType) => propertyType.name == entry.value['type']));
    return list
        .map<Property>((entry) => Property.fromJson(entry.value))
        .toList();
  }
}

@riverpod
Future<TaskDatabaseRepository?> taskDatabaseRepository(Ref ref) async {
  final accessToken = await ref
      .watch(notionOAuthViewModelProvider.future)
      .then((value) => value.accessToken);
  if (accessToken == null) {
    return null;
  }
  final notionDatabaseApi = NotionDatabaseApi(accessToken);
  return TaskDatabaseRepository(notionDatabaseApi: notionDatabaseApi);
}
