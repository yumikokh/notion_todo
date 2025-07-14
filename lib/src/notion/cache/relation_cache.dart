import '../model/property.dart';

/// リレーション情報をキャッシュする汎用クラス
class RelationCache {
  // シングルトンインスタンス
  static final RelationCache _instance = RelationCache._internal();
  factory RelationCache() => _instance;
  RelationCache._internal();

  // リレーションタイプごとにキャッシュを管理
  // key: リレーションタイプ（例: "project", "assignee" など）
  // value: そのタイプのキャッシュ
  final Map<String, RelationTypeCache> _caches = {};

  // キャッシュの有効期限（30分）
  static const _cacheExpiry = Duration(minutes: 30);

  /// 特定のリレーションタイプのキャッシュを取得（なければ作成）
  RelationTypeCache _getTypeCache(String relationType) {
    return _caches.putIfAbsent(
      relationType,
      () => RelationTypeCache(relationType),
    );
  }

  /// キャッシュからリレーション情報を取得
  RelationInfo? get(String relationType, String relationId) {
    return _getTypeCache(relationType).get(relationId);
  }

  /// キャッシュにリレーション情報を追加
  void set(String relationType, String relationId, String title) {
    _getTypeCache(relationType).set(relationId, title);
  }

  /// 複数のリレーション情報を一括でキャッシュに追加
  void setMultiple(String relationType, Map<String, String> relations) {
    _getTypeCache(relationType).setMultiple(relations);
  }

  /// キャッシュされていないリレーションIDのリストを取得
  List<String> getUncachedIds(String relationType, List<String> relationIds) {
    return _getTypeCache(relationType).getUncachedIds(relationIds);
  }

  /// RelationOptionのリストをキャッシュから補完
  List<RelationOption> enrichRelationOptions(
    String relationType,
    List<RelationOption>? options,
  ) {
    if (options == null || options.isEmpty) return [];

    final typeCache = _getTypeCache(relationType);
    return options.map((option) {
      final cached = typeCache.get(option.id);
      if (cached != null) {
        return RelationOption(
          id: option.id,
          title: cached.title,
        );
      }
      return option;
    }).toList();
  }

  /// 特定のリレーションタイプのキャッシュをクリア
  void clearType(String relationType) {
    _caches.remove(relationType);
  }

  /// すべてのキャッシュをクリア
  void clearAll() {
    _caches.clear();
  }
}

/// 特定のリレーションタイプのキャッシュを管理するクラス
class RelationTypeCache {
  final String relationType;
  final Map<String, RelationInfo> _cache = {};

  RelationTypeCache(this.relationType);

  /// キャッシュから情報を取得
  RelationInfo? get(String relationId) {
    final cached = _cache[relationId];
    if (cached == null) return null;

    // 有効期限をチェック
    if (DateTime.now().isAfter(cached.expiry)) {
      _cache.remove(relationId);
      return null;
    }

    return cached;
  }

  /// キャッシュに情報を追加
  void set(String relationId, String title) {
    _cache[relationId] = RelationInfo(
      id: relationId,
      title: title,
      expiry: DateTime.now().add(RelationCache._cacheExpiry),
    );
  }

  /// 複数の情報を一括でキャッシュに追加
  void setMultiple(Map<String, String> relations) {
    final now = DateTime.now();
    final expiry = now.add(RelationCache._cacheExpiry);

    relations.forEach((id, title) {
      _cache[id] = RelationInfo(
        id: id,
        title: title,
        expiry: expiry,
      );
    });
  }

  /// キャッシュされていないIDのリストを取得
  List<String> getUncachedIds(List<String> relationIds) {
    final uncached = <String>[];
    final now = DateTime.now();

    for (final id in relationIds) {
      final cached = _cache[id];
      if (cached == null || now.isAfter(cached.expiry)) {
        uncached.add(id);
      }
    }

    return uncached;
  }
}

/// キャッシュされるリレーション情報
class RelationInfo {
  final String id;
  final String title;
  final DateTime expiry;

  RelationInfo({
    required this.id,
    required this.title,
    required this.expiry,
  });
}
