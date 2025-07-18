/// リレーションタイプのラッパークラス
class RelationType {
  final String value;
  
  const RelationType(this.value);
  
  // 事前定義された固定のリレーションタイプ
  static const RelationType project = RelationType('project');
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RelationType &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
  
  @override
  String toString() => 'RelationType($value)';
}