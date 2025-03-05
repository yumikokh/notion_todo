import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/haptic_helper.dart';
import '../sound_constants.dart';
import '../sound_service.dart';
import '../sound_settings.dart';
import '../sound_settings_viewmodel.dart';

class SoundSettingsView extends HookConsumerWidget {
  static const routeName = '/settings/sound';
  const SoundSettingsView({super.key});

  Widget _buildSettingTitle(String text) {
    return Text(text, style: const TextStyle(fontSize: 14));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soundSettings = ref.watch(soundSettingsViewModelProvider);
    final l = AppLocalizations.of(context)!;
    final viewModel = ref.read(soundSettingsViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title:
            Text(l.sound_settings_title, style: const TextStyle(fontSize: 16)),
        actions: [
          IconButton(
            onPressed: () async {
              await viewModel.updateSettings(const SoundSettings());
              HapticHelper.light();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.refresh),
            tooltip: l.reset,
          ),
        ],
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: _buildSettingTitle(l.sound_enabled),
            subtitle: Text(l.sound_enabled_description,
                style: const TextStyle(fontSize: 10)),
            value: soundSettings.enabled,
            onChanged: (value) async {
              await viewModel.updateEnabled(value);
              HapticHelper.light();
            },
          ),
          if (soundSettings.enabled)
            ListTile(
              title: _buildSettingTitle(l.sound_type),
              subtitle: Text(l.sound_type_description,
                  style: const TextStyle(fontSize: 10)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(SoundConstants.getSoundIcon(soundSettings.soundType)),
                  const SizedBox(width: 8),
                  Text(SoundConstants.getSoundName(soundSettings.soundType),
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right),
                ],
              ),
              onTap: () async {
                final selectedSoundType = await showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l.sound_type),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: SoundConstants.soundTypes.length,
                        itemBuilder: (context, index) {
                          final soundType = SoundConstants.soundTypes[index];
                          return ListTile(
                            leading:
                                Icon(SoundConstants.getSoundIcon(soundType)),
                            title: Text(SoundConstants.getSoundName(soundType)),
                            onTap: () {
                              Navigator.pop(context, soundType);
                              HapticHelper.light();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
                if (selectedSoundType != null) {
                  await viewModel.updateSoundType(selectedSoundType);
                }
              },
            ),
          const SizedBox(height: 16),
          if (soundSettings.enabled && soundSettings.soundType != 'none')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () async {
                  final soundSettings =
                      ref.read(soundSettingsViewModelProvider);
                  if (soundSettings.enabled &&
                      soundSettings.soundType != 'none') {
                    final soundService = ref.read(soundServiceProvider);
                    await soundService.playSound(soundSettings.soundType);
                  }
                  HapticHelper.light();
                },
                icon: const Icon(Icons.play_arrow),
                label: Text(l.play_sound),
              ),
            ),
        ],
      ),
    );
  }
}
