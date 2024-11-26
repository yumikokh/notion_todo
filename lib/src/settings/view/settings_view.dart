import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../task_database/task_database_viewmodel.dart';
import 'notion_settings_view.dart';
import '../settings_viewmodel.dart';
import 'theme_settings_view.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends ConsumerWidget {
  static const routeName = '/settings';

  final SettingsViewModel settingsViewModel;

  const SettingsView({super.key, required this.settingsViewModel});

  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(settingsViewModelProvider).themeMode;
    final database = ref.watch(taskDatabaseViewModelProvider).valueOrNull;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Notion Settings'),
              subtitle: database != null
                  ? Text(database.name)
                  : const Row(
                      children: [
                        Icon(Icons.warning_rounded, size: 16),
                        SizedBox(width: 8),
                        Text('データベース設定が必要です'),
                      ],
                    ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pushNamed(NotionSettingsView.routeName);
              },
            ),
            ListTile(
              title: const Text('Theme Settings'),
              subtitle: Text(themeMode.name),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pushNamed(ThemeSettingsView.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
