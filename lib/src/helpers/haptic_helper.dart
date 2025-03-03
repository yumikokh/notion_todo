import 'package:haptic_feedback/haptic_feedback.dart';

/// ハプティックフィードバックを提供するヘルパークラス
class HapticHelper {
  /// 選択時のハプティックフィードバック
  static Future<void> selection() async {
    if (await Haptics.canVibrate()) {
      await Haptics.vibrate(HapticsType.selection);
    }
  }

  /// 軽いハプティックフィードバック
  static Future<void> light() async {
    if (await Haptics.canVibrate()) {
      await Haptics.vibrate(HapticsType.light);
    }
  }

  /// 中程度のハプティックフィードバック
  static Future<void> medium() async {
    if (await Haptics.canVibrate()) {
      await Haptics.vibrate(HapticsType.medium);
    }
  }

  /// 強いハプティックフィードバック
  static Future<void> heavy() async {
    if (await Haptics.canVibrate()) {
      await Haptics.vibrate(HapticsType.heavy);
    }
  }

  /// 成功時のハプティックフィードバック
  static Future<void> success() async {
    if (await Haptics.canVibrate()) {
      await Haptics.vibrate(HapticsType.success);
    }
  }

  /// 警告時のハプティックフィードバック
  static Future<void> warning() async {
    if (await Haptics.canVibrate()) {
      await Haptics.vibrate(HapticsType.warning);
    }
  }

  /// エラー時のハプティックフィードバック
  static Future<void> error() async {
    if (await Haptics.canVibrate()) {
      await Haptics.vibrate(HapticsType.error);
    }
  }
}
