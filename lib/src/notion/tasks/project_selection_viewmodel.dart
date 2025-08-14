import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzaku_todo/src/notion/model/task_database.dart';
import 'package:tanzaku_todo/src/notion/tasks/task_database_repository.dart';

import '../model/property.dart';
import '../../settings/task_database/task_database_viewmodel.dart';

part 'project_selection_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class ProjectSelectionViewModel extends _$ProjectSelectionViewModel {
  static const String _recentProjectsKey = 'recent_projects';
  static const String _cachedProjectsKey = 'cached_projects';
  static const int _maxRecentProjects = 50;

  @override
  Future<List<RelationOption>> build() async {
    // まずキャッシュから読み込んで即座に返す
    final cachedProjects = await _loadCachedProjects();
    if (cachedProjects.isNotEmpty) {
      // キャッシュがある場合は即座に返し、バックグラウンドで更新
      // ビルド中にstateを変更しないよう、Future.microtaskで遅延実行
      Future.microtask(() => fetchAndUpdateProjects());
      return cachedProjects;
    }

    // キャッシュがない場合は通常通り取得
    final taskDatabase = await ref.watch(taskDatabaseViewModelProvider.future);
    return await _fetchAllProjects(taskDatabase);
  }

  /// バックグラウンドでプロジェクトを取得して更新
  Future<void> fetchAndUpdateProjects() async {
    try {
      final taskDatabase = await ref.read(taskDatabaseViewModelProvider.future);
      final projects = await _fetchAllProjects(taskDatabase);
      // stateを更新することで自動的にUIが更新される
      state = AsyncData(projects);
    } catch (e) {
      // エラーが発生してもキャッシュがあるので何もしない
    }
  }

  /// 全プロジェクトを取得
  Future<List<RelationOption>> _fetchAllProjects(
      TaskDatabase? taskDatabase) async {
    try {
      final projectProperty = taskDatabase?.project;

      if (projectProperty == null) return <RelationOption>[];

      // 関連データベースのIDを取得
      final relationDatabaseId =
          projectProperty.relation['database_id'] as String?;
      if (relationDatabaseId == null) return <RelationOption>[];

      // データベースの全プロジェクトを一括取得
      final taskDatabaseRepository =
          await ref.read(taskDatabaseRepositoryProvider.future);
      final allPages = await taskDatabaseRepository
              ?.fetchDatabasePagesById(relationDatabaseId) ??
          [];

      // RelationOptionに変換
      final projects = allPages.map((page) {
        final id = page['id'] as String;
        final title = _extractTitle(page) ?? id;
        final icon = page['icon']?['emoji'] ?? page['icon']?['external']?['url'];
        return RelationOption(id: id, title: title, icon: icon);
      }).toList();

      // 最近使用したプロジェクトの順序で並び替え
      final recentProjectIds = await _getRecentProjectIds();
      final sortedProjects = _sortByRecentUsage(projects, recentProjectIds);

      // キャッシュに保存
      await _saveCachedProjects(sortedProjects);

      return sortedProjects;
    } catch (e) {
      // エラー時は空のリストを返す
      return <RelationOption>[];
    }
  }

  /// ページからタイトルを抽出
  String? _extractTitle(Map<String, dynamic> page) {
    final properties = page['properties'] as Map<String, dynamic>?;
    if (properties == null) return null;

    // 1. タイトルプロパティを探す
    for (final entry in properties.entries) {
      final property = entry.value as Map<String, dynamic>;
      if (property['type'] == 'title') {
        final title = property['title'] as List<dynamic>?;
        final text = _extractTextFromRichText(title);
        if (text != null) return text;
      }
    }

    // 2. rich_textプロパティを探す
    for (final entry in properties.entries) {
      final property = entry.value as Map<String, dynamic>;
      if (property['type'] == 'rich_text') {
        final richText = property['rich_text'] as List<dynamic>?;
        final text = _extractTextFromRichText(richText);
        if (text != null) return text;
      }
    }

    // 3. "Name"や"名前"などの一般的なプロパティ名を探す
    final nameProperties = ['Name', '名前', 'name', 'title', 'タイトル'];
    for (final nameProperty in nameProperties) {
      final property = properties[nameProperty] as Map<String, dynamic>?;
      if (property != null && property['type'] == 'rich_text') {
        final richText = property['rich_text'] as List<dynamic>?;
        final text = _extractTextFromRichText(richText);
        if (text != null) return text;
      }
    }

    return null;
  }

  String? _extractTextFromRichText(List<dynamic>? richText) {
    if (richText != null && richText.isNotEmpty) {
      final textItem = richText[0] as Map<String, dynamic>;
      final text = textItem['plain_text'] as String?;
      if (text != null && text.isNotEmpty) {
        return text;
      }
    }
    return null;
  }

  Future<List<String>> _getRecentProjectIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_recentProjectsKey) ?? [];
    } catch (e) {
      // 古いデータをクリアして空リストを返す
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_recentProjectsKey);
      return [];
    }
  }

  Future<void> updateRecentProjects(
      List<RelationOption> selectedProjects) async {
    final prefs = await SharedPreferences.getInstance();
    final recentProjectIds = await _getRecentProjectIds();

    // 新しく選択されたプロジェクトを先頭に追加
    for (final project in selectedProjects.reversed) {
      recentProjectIds
        ..remove(project.id)
        ..insert(0, project.id);
    }

    // 最大数を超えた場合は古いものを削除
    if (recentProjectIds.length > _maxRecentProjects) {
      recentProjectIds.removeRange(_maxRecentProjects, recentProjectIds.length);
    }

    await prefs.setStringList(_recentProjectsKey, recentProjectIds);
  }

  List<RelationOption> _sortByRecentUsage(
    List<RelationOption> projects,
    List<String> recentProjectIds,
  ) {
    final projectMap = {for (final project in projects) project.id: project};
    final sortedProjects = <RelationOption>[];

    // 最近使用したプロジェクトを順番に追加
    for (final projectId in recentProjectIds) {
      final project = projectMap[projectId];
      if (project != null) {
        sortedProjects.add(project);
        projectMap.remove(projectId);
      }
    }

    // 残りのプロジェクトを追加
    sortedProjects.addAll(projectMap.values);

    return sortedProjects;
  }

  /// キャッシュからプロジェクトを読み込む
  Future<List<RelationOption>> _loadCachedProjects() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_cachedProjectsKey);
      if (jsonString == null) return [];

      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList.map((json) {
        final jsonMap = json as Map<String, dynamic>;
        return RelationOption(
          id: jsonMap['id'] as String,
          title: jsonMap['title'] as String,
          icon: jsonMap['icon'] as String?,
        );
      }).toList();
    } catch (e) {
      // キャッシュの読み込みに失敗した場合は空のリストを返す
      return [];
    }
  }

  /// プロジェクトをキャッシュに保存
  Future<void> _saveCachedProjects(List<RelationOption> projects) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = projects
          .map((project) => {
                'id': project.id,
                'title': project.title,
                'icon': project.icon,
              })
          .toList();
      final jsonString = jsonEncode(jsonList);
      await prefs.setString(_cachedProjectsKey, jsonString);
    } catch (e) {
      // キャッシュの保存に失敗しても処理を継続
    }
  }
}
