import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';

import '../../common/widgets/settings_list_tile.dart';
import '../settings_viewmodel.dart';

class BehaviorSettingsPage extends ConsumerWidget {
  static const routeName = '/settings/behavior';

  const BehaviorSettingsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final l = AppLocalizations.of(context)!;
    final settingsViewModel = ref.watch(settingsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l.behavior_settings_title,
            style: const TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          children: [
            SettingsListTile(
              title: l.wakelock_title,
              subtitle: l.wakelock_description,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.warning_rounded, size: 14),
                  const SizedBox(width: 8),
                  Switch(
                    value: settingsViewModel.wakelock,
                    onChanged: (value) {
                      ref
                          .read(settingsViewModelProvider.notifier)
                          .updateWakelock(value);
                    },
                  ),
                ],
              ),
              analyticsSettingName: 'wakelock',
              analyticsValue: (!settingsViewModel.wakelock) ? 'enabled' : 'disabled',
              onTap: () {
                ref
                    .read(settingsViewModelProvider.notifier)
                    .updateWakelock(!settingsViewModel.wakelock);
              },
            ),
            SettingsListTile.switchTile(
              title: l.continuous_task_addition_title,
              subtitle: l.continuous_task_addition_description,
              value: settingsViewModel.continuousTaskAddition,
              analyticsSettingName: 'continuous_task_addition',
              onChanged: (value) {
                ref
                    .read(settingsViewModelProvider.notifier)
                    .updateContinuousTaskAddition(value);
              },
            ),

            // タスク完了時の音設定
            SettingsListTile.switchTile(
              title: l.task_completion_sound_title,
              subtitle: l.task_completion_sound_description,
              value: settingsViewModel.soundEnabled,
              analyticsSettingName: 'sound_enabled',
              onChanged: (value) {
                ref
                    .read(settingsViewModelProvider.notifier)
                    .updateSoundEnabled(value);
              },
            ),

            // 将来的に追加される他のふるまい設定
          ],
        ),
      ),
    );
  }
}
