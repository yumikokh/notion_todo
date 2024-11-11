import 'package:shared_preferences/shared_preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import '../entity/index.dart';
import '../repository/notion_database_repository.dart';

part 'task_database_service.freezed.dart';
part 'task_database_service.g.dart';

@freezed
class TaskDatabase with _$TaskDatabase {
  const factory TaskDatabase({
    required String id,
    required String name,
    required List<Property> properties,
    required String? statusId,
    required String? dateId,
  }) = _SelectedTaskDatabase;

  factory TaskDatabase.initial() => const TaskDatabase(
        id: '',
        name: '',
        properties: [],
        statusId: null,
        dateId: null,
      );

  factory TaskDatabase.fromJson(Map<String, dynamic> json) =>
      _$TaskDatabaseFromJson(json);
}

class TaskDatabaseService {
  static const _taskDatabaseKey = 'taskDatabase';
  final String _accessToken;
  late final NotionDatabaseRepository _notionDatabaseRepository;

  TaskDatabaseService(this._accessToken) {
    _notionDatabaseRepository = NotionDatabaseRepository(_accessToken);
  }

  Future<TaskDatabase?> loadSetting() async {
    final pref = await SharedPreferences.getInstance();
    final taskDatabase = pref.getString(_taskDatabaseKey);
    if (taskDatabase == null) {
      return null;
    }
    return TaskDatabase.fromJson(jsonDecode(taskDatabase));
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
    final data = await _notionDatabaseRepository.fetchAccessibleDatabases();
    final databases = data.map<Database>((e) {
      final id = e['id'];
      final name =
          e['title'].length > 0 ? e['title'][0]['plain_text'] : 'NoTitle';
      final url = e['url'];

      final properties = (e['properties'] as Map<String, dynamic>)
          .entries
          // typeがdate, checkbox, statusのものだけを取得
          .where((entry) =>
              entry.value['type'] == 'date' ||
              entry.value['type'] == 'checkbox' ||
              entry.value['type'] == 'status')
          .map<Property>((entry) {
        final property = entry.value;
        final id = property['id'] as String;
        final name = property['name'] as String;
        final type = property['type'] as String;

        switch (type) {
          case 'date':
            return Property.date(
              id: id,
              name: name,
              type: type,
              date: property['date'].isEmpty
                  ? null
                  : DateTime.parse(property['date']['start']),
            );
          case 'checkbox':
            return Property.checkbox(
              id: id,
              name: name,
              type: type,
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
              type: type,
              status: (
                options: options,
                groups: groups,
              ),
            );
          default:
            throw Exception('Unknown property type: $type');
        }
      }).toList();

      return Database(id: id, name: name, url: url, properties: properties);
    }).toList();
    return databases;
  }
}
