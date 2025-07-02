import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/analytics/analytics_service.dart';
import '../../helpers/haptic_helper.dart';

/// 設定ページで使用される共通のListTileウィジェット
/// 分析とハプティックフィードバックを内蔵
class SettingsListTile extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enableHaptic;
  final String? analyticsScreenName;
  final String? analyticsSettingName;
  final String? analyticsValue;

  const SettingsListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.enableHaptic = true,
    this.analyticsScreenName,
    this.analyticsSettingName,
    this.analyticsValue,
  });

  /// ナビゲーション用のファクトリーコンストラクタ
  factory SettingsListTile.navigation({
    Key? key,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    String? analyticsScreenName,
  }) {
    return SettingsListTile(
      key: key,
      title: title,
      subtitle: subtitle,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      analyticsScreenName: analyticsScreenName,
    );
  }

  /// スイッチ設定用のファクトリーコンストラクタ
  factory SettingsListTile.switchTile({
    Key? key,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required String analyticsSettingName,
  }) {
    return SettingsListTile(
      key: key,
      title: title,
      subtitle: subtitle,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
      onTap: () => onChanged(!value),
      analyticsSettingName: analyticsSettingName,
      analyticsValue: (!value).toString(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.read(analyticsServiceProvider);

    return ListTile(
      title: Text(title),
      subtitle: subtitle != null
          ? Text(subtitle!, style: const TextStyle(fontSize: 11))
          : null,
      trailing: trailing,
      onTap: onTap == null
          ? null
          : () async {
              // ハプティックフィードバック
              if (enableHaptic) {
                await HapticHelper.light();
              }

              // 分析ログ
              if (analyticsScreenName != null) {
                analytics.logScreenView(screenName: analyticsScreenName!);
              } else if (analyticsSettingName != null) {
                analytics.logSettingsChanged(
                  settingName: analyticsSettingName!,
                  value: analyticsValue ?? '',
                );
              }

              // コールバック実行
              onTap!();
            },
    );
  }
}