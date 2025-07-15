import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzaku_todo/src/notion/tasks/task_database_repository.dart';

import '../model/property.dart';
import '../cache/relation_cache.dart';
import '../../settings/task_database/task_database_viewmodel.dart';

part 'project_selection_viewmodel.g.dart';

@riverpod
class ProjectSelectionViewModel extends _$ProjectSelectionViewModel {
  static const String _recentProjectsKey = 'recent_projects';
  static const int _maxRecentProjects = 50;

  List<RelationOption>? _cachedProjects;
  DateTime? _lastFetchTime;
  static const Duration _cacheExpiration = Duration(minutes: 10);

  @override
  Future<List<RelationOption>> build() async {
    // キャッシュが有効な場合は即座に返す
    if (_cachedProjects != null &&
        _lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!) < _cacheExpiration) {
      return _cachedProjects!;
    }

    // RelationCacheから既存のプロジェクトを取得して初期表示用に使用
    final relationCache = RelationCache.instance;
    final cachedProjects = relationCache.getCachedRelationOptions('project');
    if (cachedProjects.isNotEmpty) {
      _cachedProjects = cachedProjects;
      _lastFetchTime = DateTime.now();

      // バックグラウンドで最新データを取得
      _fetchProjects().then((projects) {
        if (projects.isNotEmpty) {
          _cachedProjects = projects;
          _lastFetchTime = DateTime.now();
          // 状態を更新
          state = AsyncValue.data(projects);
        }
      });

      return cachedProjects;
    }

    // 初期表示では空のリストを返し、バックグラウンドで取得
    _fetchProjects().then((projects) {
      _cachedProjects = projects;
      _lastFetchTime = DateTime.now();
      state = AsyncValue.data(projects);
    }).catchError((e) {
      state = AsyncValue.error(e, StackTrace.current);
    });

    return <RelationOption>[];
  }

  Future<List<RelationOption>> _fetchProjects() async {
    try {
      final taskDatabase = await ref.read(taskDatabaseViewModelProvider.future);
      final projectProperty = taskDatabase?.project;

      if (projectProperty == null) {
        return <RelationOption>[];
      }

      // 関連データベースのIDを取得
      final relationDatabaseId =
          projectProperty.relation['database_id'] as String?;
      if (relationDatabaseId == null) {
        return <RelationOption>[];
      }

      // データベースの全ページを取得
      final taskDatabaseRepository =
          await ref.read(taskDatabaseRepositoryProvider.future);
      final pages = await taskDatabaseRepository
              ?.fetchDatabasePagesById(relationDatabaseId) ??
          [];

      // RelationOptionに変換
      final projects = pages.map((page) {
        final id = page['id'] as String;
        final title = _extractTitle(page);
        final displayTitle = title ?? id;
        return RelationOption(id: id, title: displayTitle);
      }).toList();

      // 最近使用したプロジェクトの順序を取得
      final recentProjectIds = await _getRecentProjectIds();

      // 最近使用した順に並び替え
      final sortedProjects = _sortByRecentUsage(projects, recentProjectIds);

      // キャッシュを更新
      _cachedProjects = sortedProjects;
      _lastFetchTime = DateTime.now();

      return sortedProjects;
    } catch (e) {
      // エラーの場合、キャッシュがあれば返す
      if (_cachedProjects != null) {
        return _cachedProjects!;
      }

      // キャッシュもない場合は空のリストを返す
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

  Future<void> refresh() async {
    // キャッシュをクリア
    _cachedProjects = null;
    _lastFetchTime = null;

    // 再取得
    state = const AsyncValue.loading();
    try {
      final projects = await _fetchProjects();
      state = AsyncValue.data(projects);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
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
}
