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
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<ThemeMode>(
              value: settingsViewModel.themeMode,
              onChanged: settingsViewModel.updateThemeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
