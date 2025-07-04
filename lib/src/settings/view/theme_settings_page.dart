import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../helpers/haptic_helper.dart';
import '../settings_viewmodel.dart';

class ThemeSettingsPage extends ConsumerWidget {
  static const routeName = '/settings/theme';

  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.settings_view_theme_settings_title,
            style: const TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('System'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: ref.watch(settingsViewModelProvider).themeMode,
                onChanged: (value) {
                  ref.read(settingsViewModelProvider).updateThemeMode(value);
                  HapticHelper.light();
                },
              ),
            ),
            ListTile(
              title: const Text('Light'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: ref.watch(settingsViewModelProvider).themeMode,
                onChanged: (value) {
                  ref.read(settingsViewModelProvider).updateThemeMode(value);
                  HapticHelper.light();
                },
              ),
            ),
            ListTile(
              title: const Text('Dark'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: ref.watch(settingsViewModelProvider).themeMode,
                onChanged: (value) {
                  ref.read(settingsViewModelProvider).updateThemeMode(value);
                  HapticHelper.light();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
