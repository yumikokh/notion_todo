import 'package:flutter/material.dart';

import 'settings_viewmodel.dart';
import '../notion/notion_viewmodel.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView(
      {super.key,
      required this.settingsViewModel,
      required this.notionViewModel});

  static const routeName = '/settings';

  final SettingsViewModel settingsViewModel;
  final NotionViewModel notionViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: ListView(
          children: [
            const Text('Notion Sync'),
            notionViewModel.accessToken != null
                ? const Text('Authenticated ✅') // FIXME: 即時反映されない
                : const Text('Not Authenticated'),
            ElevatedButton(
              onPressed: () async {
                await notionViewModel.authenticate();
              },
              child: notionViewModel.accessToken != null
                  ? const Text('Re-authenticate')
                  : const Text('Authenticate'),
            ),
            const Text('Theme Mode'),
            DropdownButton<ThemeMode>(
              // Read the selected themeMode from the controller
              value: settingsViewModel.themeMode,
              // Call the updateThemeMode method any time the user selects a theme.
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
            )
          ],
        ),
      ),
    );
  }
}
