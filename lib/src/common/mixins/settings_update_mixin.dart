import 'package:flutter/foundation.dart';

/// 設定の更新処理を共通化するためのMixin
/// SettingsViewModelなどで使用し、重複コードを削減
mixin SettingsUpdateMixin on ChangeNotifier {
  /// 汎用的な設定更新メソッド
  /// 
  /// [T] - 設定値の型
  /// [newValue] - 新しい値
  /// [currentValue] - 現在の値
  /// [updateFunction] - 実際の更新処理を行う関数
  /// [saveFunction] - 永続化処理を行う関数（オプション）
  /// [analyticsKey] - 分析用のキー（オプション）
  /// [logAnalytics] - 分析ログを記録する関数（オプション）
  Future<void> updateSetting<T>({
    required T newValue,
    required T currentValue,
    required void Function(T value) updateFunction,
    Future<void> Function()? saveFunction,
    String? analyticsKey,
    void Function(String key, String value)? logAnalytics,
  }) async {
    // 値が変わっていない場合は何もしない
    if (newValue == currentValue) return;

    // 内部状態を更新
    updateFunction(newValue);
    
    // UIを更新
    notifyListeners();

    // 永続化処理
    if (saveFunction != null) {
      await saveFunction();
    }

    // 分析ログ
    if (analyticsKey != null && logAnalytics != null) {
      logAnalytics(analyticsKey, newValue.toString());
    }
  }

  /// bool型設定専用の更新メソッド
  Future<void> updateBoolSetting({
    required bool newValue,
    required bool currentValue,
    required void Function(bool value) updateFunction,
    Future<void> Function()? saveFunction,
    String? analyticsKey,
    void Function(String key, String value)? logAnalytics,
  }) async {
    await updateSetting<bool>(
      newValue: newValue,
      currentValue: currentValue,
      updateFunction: updateFunction,
      saveFunction: saveFunction,
      analyticsKey: analyticsKey,
      logAnalytics: (key, value) {
        logAnalytics?.call(key, newValue ? 'enabled' : 'disabled');
      },
    );
  }

  /// String型設定専用の更新メソッド
  Future<void> updateStringSetting({
    required String newValue,
    required String currentValue,
    required void Function(String value) updateFunction,
    Future<void> Function()? saveFunction,
    String? analyticsKey,
    void Function(String key, String value)? logAnalytics,
  }) async {
    await updateSetting<String>(
      newValue: newValue,
      currentValue: currentValue,
      updateFunction: updateFunction,
      saveFunction: saveFunction,
      analyticsKey: analyticsKey,
      logAnalytics: logAnalytics,
    );
  }

  /// Enum型設定専用の更新メソッド
  Future<void> updateEnumSetting<E extends Enum>({
    required E newValue,
    required E currentValue,
    required void Function(E value) updateFunction,
    Future<void> Function()? saveFunction,
    String? analyticsKey,
    void Function(String key, String value)? logAnalytics,
  }) async {
    await updateSetting<E>(
      newValue: newValue,
      currentValue: currentValue,
      updateFunction: updateFunction,
      saveFunction: saveFunction,
      analyticsKey: analyticsKey,
      logAnalytics: (key, value) {
        logAnalytics?.call(key, newValue.name);
      },
    );
  }
}