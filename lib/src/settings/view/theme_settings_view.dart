import 'package:flutter/material.dart';
import '../settings_viewmodel.dart';

class ThemeSettingsView extends StatelessWidget {
  static const routeName = '/settings/theme';

  final SettingsViewModel settingsViewModel;
  const ThemeSettingsView(this.settingsViewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('System Theme'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: settingsViewModel.themeMode,
                onChanged: settingsViewModel.updateThemeMode,
              ),
            ),
            ListTile(
              title: const Text('Light Theme'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: settingsViewModel.themeMode,
                onChanged: settingsViewModel.updateThemeMode,
              ),
            ),
            ListTile(
              title: const Text('Dark Theme'),
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
