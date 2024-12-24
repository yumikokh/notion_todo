import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../settings_viewmodel.dart';

class ThemeSettingsView extends StatelessWidget {
  static const routeName = '/settings/theme';

  final SettingsViewModel settingsViewModel;
  const ThemeSettingsView(this.settingsViewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.settings_view_theme_settings_title),
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
                groupValue: settingsViewModel.themeMode,
                onChanged: settingsViewModel.updateThemeMode,
              ),
            ),
            ListTile(
              title: const Text('Light'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: settingsViewModel.themeMode,
                onChanged: settingsViewModel.updateThemeMode,
              ),
            ),
            ListTile(
              title: const Text('Dark'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: settingsViewModel.themeMode,
                onChanged: settingsViewModel.updateThemeMode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
