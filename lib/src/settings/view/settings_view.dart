import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          children: [
            _buildSection(
              context,
              title: 'アプリ設定',
              children: [
                ListTile(
                  title: const Text('Notion Settings'),
                  subtitle: database != null
                      ? Text(database.name)
                      : Row(
                          children: [
                            Icon(Icons.warning_rounded,
                                size: 16,
                                color: Theme.of(context).colorScheme.error),
                            const SizedBox(width: 8),
                            const Text('データベース設定が必要です'),
                          ],
                        ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(NotionSettingsView.routeName);
                  },
                ),
                ListTile(
                  title: const Text('Theme Settings'),
                  subtitle: Text(themeMode.name),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ThemeSettingsView.routeName);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: 'サポート',
              children: [
                ListTile(
                  title: const Text('よくある質問'),
                  leading: const Icon(Icons.help_outline),
                  trailing: const Icon(Icons.open_in_new_rounded),
                  onTap: () async {
                    await launchUrl(Uri.parse(
                        'https://yumikokh.notion.site/Tanzaku-Todo-11f54c37a54c800da12cf5162f5beada'));
                  },
                ),
                ListTile(
                  title: const Text('バグ報告・要望・問い合わせ'),
                  trailing: const Icon(Icons.open_in_new_rounded),
                  onTap: () async {
                    await launchUrl(Uri.parse(
                        'https://docs.google.com/forms/d/e/1FAIpQLSfIdMsEJVzbWHdxdvNzr_-OUPEVqe3AMOmafCYctaa7hzcQpQ/viewform'));
                  },
                ),
                ListTile(
                  title: const Text('プライバシーポリシー'),
                  trailing: const Icon(Icons.open_in_new_rounded),
                  onTap: () async {
                    await launchUrl(Uri.parse(
                        'https://yumikokh.notion.site/Privacy-Policy-14b54c37a54c80e1b288c0097bb6c7bd'));
                  },
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Clipboard.setData(
                    ClipboardData(text: settingsViewModel.version));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('バージョン情報をコピーしました'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: ListTile(
                title: const Text('バージョン'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(settingsViewModel.version,
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 8),
                    const Icon(Icons.copy, size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...children,
      ],
    );
  }
}
