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
    final taskDatabase = pref.getString(_taskDatabaseKey);
    if (taskDatabase == null) {
      return null;
    }
    try {
      return TaskDatabase.fromJson(jsonDecode(taskDatabase));
    } catch (e) {
      print('Failed to load task database: $e');
      clear();
      return null;
    }
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

  Future<List<Property>> createProperty(
      String databaseId, CreatePropertyType type, String name) async {
    final data =
        await notionDatabaseRepository?.createProperty(databaseId, type, name);
    if (data == null) {
      return [];
    }
    return _getProperties(data["properties"]);
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
          // typeがtitle, date, checkbox, statusのものだけを取得
          .where((entry) =>
              entry.value['type'] == 'title' ||
              entry.value['type'] == 'status' ||
              entry.value['type'] == 'checkbox' ||
              entry.value['type'] == 'date')
          .map<Property>((entry) {
        final property = entry.value;
        final id = property['id'] as String;
        final name = property['name'] as String;
        final type = property['type'] as String;

        switch (type) {
          case 'title':
            return Property.title(
              id: id,
              name: name,
              type: PropertyType.title,
              title: property['title'].isEmpty
                  ? ''
                  : property['title'][0]['plain_text'],
            );
          case 'date':
            return Property.date(
              id: id,
              name: name,
              type: PropertyType.date,
              date: property['date'].isEmpty
                  ? null
                  : DateTime.parse(property['date']['start']),
            );
          case 'checkbox':
            return Property.checkbox(
              id: id,
              name: name,
              type: PropertyType.checkbox,
              checked: property['checkbox'].isEmpty
                  ? false
                  : property['checkbox']['checked'],
            );
          case 'status':
            final options = (property['status']['options'] as List<dynamic>)
                .map((option) => StatusOption.fromJson(option))
                .toList();
            final groups = (property['status']['groups'] as List<dynamic>)
                .map((group) => StatusGroup.fromJson(group))
                .toList();
            return Property.status(
              id: id,
              name: name,
              type: PropertyType.status,
              status: (
                options: options,
                groups: groups,
              ),
              todoOption: null,
              completeOption: null,
            );
          default:
            throw Exception('Unknown property type: $type');
        }
      }).toList();
}
