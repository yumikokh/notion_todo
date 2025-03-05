import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/haptic_helper.dart';
import '../settings_viewmodel.dart';
import '../sound/sound_constants.dart';
import '../sound/sound_viewmodel.dart';
import '../sound/view/sound_settings_view.dart';
import '../../common/analytics/analytics_service.dart';

class BehaviorSettingsPage extends ConsumerWidget {
  static const routeName = '/settings/behavior';

  const BehaviorSettingsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final l = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l.behavior_settings_title,
            style: const TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          children: [
            ListTile(
              title: Text(l.wakelock_title),
              subtitle: Row(
                children: [
                  const Icon(Icons.warning_rounded, size: 14),
                  const SizedBox(width: 2),
                  Flexible(
                    child: Text(l.wakelock_description,
                        style: const TextStyle(fontSize: 10)),
                  ),
                ],
              ),
              trailing: Switch(
                value: ref.watch(settingsViewModelProvider).wakelock,
                onChanged: (value) {
                  ref
                      .read(settingsViewModelProvider.notifier)
                      .updateWakelock(value);
                  analytics.logSettingsChanged(
                    settingName: 'wakelock',
                    value: value ? 'enabled' : 'disabled',
                  );
                  HapticHelper.light();
                },
              ),
            ),
            ListTile(
              title: Text(l.continuous_task_addition_title),
              subtitle: Text(l.continuous_task_addition_description,
                  style: const TextStyle(fontSize: 10)),
              trailing: Switch(
                value:
                    ref.watch(settingsViewModelProvider).continuousTaskAddition,
                onChanged: (value) {
                  ref
                      .read(settingsViewModelProvider.notifier)
                      .updateContinuousTaskAddition(value);
                  analytics.logSettingsChanged(
                    settingName: 'continuous_task_addition',
                    value: value ? 'enabled' : 'disabled',
                  );
                  HapticHelper.light();
                },
              ),
            ),

            // タスク完了時の音設定
            ListTile(
              title: Text(l.task_completion_sound_title),
              subtitle: Row(
                children: [
                  Flexible(
                    child: Text(
                      l.task_completion_sound_description,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (ref.watch(soundViewModelProvider).enabled &&
                      ref.watch(soundViewModelProvider).soundType != 'none')
                    Icon(
                      SoundConstants.getSoundIcon(
                        ref.watch(soundViewModelProvider).soundType,
                      ),
                      size: 16,
                    ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right),
                ],
              ),
              onTap: () {
                analytics.logScreenView(screenName: 'SoundSettings');
                Navigator.pushNamed(context, SoundSettingsView.routeName);
              },
            ),

            // 将来的に追加される他のふるまい設定
          ],
        ),
      ),
    );
  }
}
