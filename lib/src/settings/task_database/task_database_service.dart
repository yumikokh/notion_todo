import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../notion/model/index.dart';
import '../../notion/model/task_database.dart';
import '../../notion/repository/notion_database_repository.dart';

class TaskDatabaseService {
  static const _taskDatabaseKey = 'taskDatabase';
  final NotionDatabaseRepository? notionDatabaseRepository;

  TaskDatabaseService({required this.notionDatabaseRepository});

  Future<TaskDatabase?> loadSetting() async {
    final pref = await SharedPreferences.getInstance();
    final taskDatabaseJson = pref.getString(_taskDatabaseKey);
    if (taskDatabaseJson == null) {
      return null;
    }
    try {
      final taskDatabase = TaskDatabase.fromJson(jsonDecode(taskDatabaseJson));
      if (notionDatabaseRepository != null) {
        return await _updateDatabaseWithLatestInfo(taskDatabase);
      }
      return taskDatabase;
    } catch (e) {
      print('Failed to load task database: $e');
      clear();
      return null;
    }
  }

  /// 保存されているデータベース情報を最新の情報で更新する
  Future<TaskDatabase> _updateDatabaseWithLatestInfo(
      TaskDatabase taskDatabase) async {
    try {
      final latestDatabase = await _fetchDatabase(taskDatabase.id);
      return _updateTaskDatabaseProperties(taskDatabase, latestDatabase);
    } catch (e) {
      rethrow;
    }
  }

  /// 指定されたIDのデータベースを取得する
  Future<Database> _fetchDatabase(String databaseId) async {
    final data = await notionDatabaseRepository?.fetchDatabase(databaseId);
    if (data == null) {
      throw Exception('Database not found');
    }
    return _getDatabase(data);
  }

  /// データベースのプロパティを最新の情報で更新する
  TaskDatabase _updateTaskDatabaseProperties(
      TaskDatabase savedDatabase, Database latestDatabase) {
    // 保存されているプロパティのIDを使って最新のプロパティを探す
    final titleProperty = latestDatabase.properties.firstWhere(
        (p) => p.id == savedDatabase.title.id,
        orElse: () => savedDatabase.title);
    final statusProperty = latestDatabase.properties.firstWhere(
        (p) => p.id == savedDatabase.status.id,
        orElse: () => savedDatabase.status);
    final dateProperty = latestDatabase.properties.firstWhere(
        (p) => p.id == savedDatabase.date.id,
        orElse: () => savedDatabase.date);
    final priorityProperty = savedDatabase.priority != null
        ? latestDatabase.properties.firstWhere(
            (p) => p.id == savedDatabase.priority!.id,
            orElse: () => savedDatabase.priority!)
        : null;

    // プロパティの型チェック
    if (titleProperty is! TitleProperty ||
        statusProperty is! CompleteStatusProperty ||
        dateProperty is! DateProperty ||
        (savedDatabase.priority != null &&
            priorityProperty is! SelectProperty)) {
      throw Exception('Property types do not match');
    }

    return TaskDatabase(
      id: latestDatabase.id,
      name: latestDatabase.name,
      title: titleProperty,
      status: statusProperty,
      date: dateProperty,
      priority: priorityProperty as SelectProperty?,
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
    final data = await notionDatabaseRepository?.fetchAccessibleDatabases();
    if (data == null) {
      return [];
    }
    final databases = data.map<Database>((e) => _getDatabase(e)).toList();

    // print('databases: $databases');
    return databases;
  }

  Future<Property?> createProperty(
      String databaseId, CreatePropertyType type, String name) async {
    final data =
        await notionDatabaseRepository?.createProperty(databaseId, type, name);
    if (data == null) {
      return null;
    }
    final properties = _getProperties(data["properties"]);
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
    final properties = _getProperties(e['properties']);
    return Database(id: id, name: name, url: url, properties: properties);
  }

  List<Property> _getProperties(Map<String, dynamic> properties) =>
      properties.entries
          // typeがtitle, date, checkbox, status, selectのものだけを取得
          .where((entry) =>
              entry.value['type'] == 'title' ||
              entry.value['type'] == 'status' ||
              entry.value['type'] == 'checkbox' ||
              entry.value['type'] == 'date' ||
              entry.value['type'] == 'select')
          .map<Property>((entry) {
        final property = entry.value;
        final id = property['id'] as String;
        final name = property['name'] as String;
        final type = property['type'] as String;

        switch (type) {
          case 'title':
            return TitleProperty(
              id: id,
              name: name,
              title: property['title'].isEmpty
                  ? ''
                  : property['title'][0]['plain_text'],
            );
          case 'date':
            return DateProperty(
              id: id,
              name: name,
            );
          case 'checkbox':
            return CheckboxCompleteStatusProperty(
              id: id,
              name: name,
              checked: false,
            );
          case 'status':
            final options = (property['status']['options'] as List<dynamic>)
                .map((option) => StatusOption.fromJson(option))
                .toList();
            final groups = (property['status']['groups'] as List<dynamic>)
                .map((group) => StatusGroup.fromJson(group))
                .toList();
            return StatusCompleteStatusProperty(
              id: id,
              name: name,
              status: (
                options: options,
                groups: groups,
              ),
              todoOption: null,
              inProgressOption: null,
              completeOption: null,
            );
          case 'select':
            final options = (property['select']['options'] as List<dynamic>)
                .map((option) => SelectOption.fromJson(option))
                .toList();
            return SelectProperty(
              id: id,
              name: name,
              options: options,
            );
          default:
            throw Exception('Unknown property type: $type');
        }
      }).toList();
}
