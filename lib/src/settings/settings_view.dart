import 'package:flutter/material.dart';

import 'settings_controller.dart';
import '../notion/notion_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView(
      {super.key,
      required this.settingsController,
      required this.notionController});

  static const routeName = '/settings';

  final SettingsController settingsController;
  final NotionController notionController;

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
            notionController.accessToken != null
                ? const Text('Authenticated ✅') // FIXME: 即時反映されない
                : const Text('Not Authenticated'),
            ElevatedButton(
              onPressed: () async {
                await notionController.authenticate();
              },
              child: notionController.accessToken != null
                  ? const Text('Re-authenticate')
                  : const Text('Authenticate'),
            ),
            const Text('Theme Mode'),
            DropdownButton<ThemeMode>(
              // Read the selected themeMode from the controller
              value: settingsController.themeMode,
              // Call the updateThemeMode method any time the user selects a theme.
              onChanged: settingsController.updateThemeMode,
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
