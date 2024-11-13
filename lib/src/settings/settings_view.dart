import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notion/model/property.dart';
import '../notion/task_database/view/task_database_setting_page.dart';
import 'settings_viewmodel.dart';
import '../notion/oauth/notion_oauth_viewmodel.dart';
import '../notion/task_database/task_database_viewmodel.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends ConsumerWidget {
  final SettingsViewModel settingsViewModel;
  const SettingsView({super.key, required this.settingsViewModel});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, ref) {
    final settings = ref.watch(settingsViewModelProvider);
    final notionOAuth = ref.read(notionOAuthViewModelProvider.notifier);
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final taskDatabaseViewModel =
        ref.watch(taskDatabaseViewModelProvider.notifier);
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).taskDatabase;

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
            isAuthenticated
                ? const Text('Authenticated ✅')
                : const Text('Not Authenticated'),
            ElevatedButton(
              onPressed: () async {
                await notionOAuth.authenticate();
                await taskDatabaseViewModel.fetchDatabases();
              },
              child: isAuthenticated
                  ? const Text('Re-authenticate')
                  : const Text('Authenticate'),
            ),
            if (isAuthenticated)
              ElevatedButton(
                onPressed: () async {
                  await notionOAuth.deauthenticate();
                  taskDatabaseViewModel.clear();
                },
                child: const Text('Deauthenticate'),
              ),
            if (taskDatabase != null)
              Column(
                children: [
                  const Text('Task Database'),
                  Text(taskDatabase.name),
                  const Text('Status Property'),
                  Text(taskDatabase.status.name),
                  const Text('Date Property'),
                  Text(taskDatabase.date.name),
                ],
              ),
            if (taskDatabase?.status.type == PropertyType.status &&
                (taskDatabase?.status as StatusTaskStatusProperty)
                        .todoOption
                        ?.name !=
                    null)
              Column(
                children: [
                  const Text('To-do Option'),
                  Text((taskDatabase?.status as StatusTaskStatusProperty)
                          .todoOption
                          ?.name ??
                      'None'),
                  const Text('Complete Option'),
                  Text((taskDatabase?.status as StatusTaskStatusProperty)
                          .completeOption
                          ?.name ??
                      'None'),
                ],
              ),
            if (isAuthenticated)
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pushNamed(TaskDatabaseSettingPage.routeName);
                  await taskDatabaseViewModel.fetchDatabases();
                },
                child: const Text('Task Database Settings'),
              ),
            const Text('Theme Mode'),
            DropdownButton<ThemeMode>(
              // Read the task themeMode from the controller
              value: settings.themeMode,
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
