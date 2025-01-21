import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../task_database/task_database_viewmodel.dart';
import 'language_settings_view.dart';
import 'notion_settings_view.dart';
import '../settings_viewmodel.dart';
import 'theme_settings_view.dart';
import '../../common/analytics/analytics_service.dart';
import '../../common/app_version/app_version_viewmodel.dart';
import '../font/view/font_settings_view.dart';

class SettingsView extends ConsumerWidget {
  static const routeName = '/settings';

  final SettingsViewModel settingsViewModel;

  const SettingsView({super.key, required this.settingsViewModel});

  @override
  Widget build(BuildContext context, ref) {
    final database = ref.read(taskDatabaseViewModelProvider).valueOrNull;
    final analytics = ref.read(analyticsServiceProvider);
    final appVersionViewModel = ref.read(appVersionViewModelProvider);
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title:
            Text(l.settings_view_title, style: const TextStyle(fontSize: 20)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          children: [
            _buildSection(
              context,
              title: l.settings_view_app_settings_title,
              children: [
                ListTile(
                  title: Text(l.settings_view_notion_settings_title),
                  subtitle: database != null
                      ? Text(database.name)
                      : Row(
                          children: [
                            Icon(Icons.warning_rounded,
                                size: 16,
                                color: Theme.of(context).colorScheme.error),
                            const SizedBox(width: 8),
                            Text(l.settings_view_notion_settings_description),
                          ],
                        ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    analytics.logScreenView(screenName: 'NotionSettings');
                    Navigator.of(context)
                        .pushNamed(NotionSettingsView.routeName);
                  },
                ),
                ListTile(
                  title: Text(l.settings_view_theme_settings_title),
                  subtitle: Text(settingsViewModel.themeModeName),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    analytics.logScreenView(screenName: 'ThemeSettings');
                    Navigator.of(context)
                        .pushNamed(ThemeSettingsView.routeName);
                  },
                ),
                ListTile(
                  title: Text(l.language_settings_title),
                  subtitle: Text(settingsViewModel.languageName(l)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    analytics.logScreenView(screenName: 'LanguageSettings');
                    Navigator.of(context)
                        .pushNamed(LanguageSettingsView.routeName);
                  },
                ),
                ListTile(
                  title: Text(l.font_settings),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    analytics.logScreenView(screenName: 'FontSettings');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FontSettingsView(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(l.wakelock_title),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.warning_rounded, size: 14),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(l.wakelock_description,
                            style: const TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                  trailing: Switch(
                    value: settingsViewModel.wakelock,
                    onChanged: (value) {
                      settingsViewModel.updateWakelock(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: l.settings_view_support_title,
              children: [
                ListTile(
                  title: Text(l.settings_view_support_faq_title),
                  leading: const Icon(Icons.help_outline),
                  trailing: const Icon(Icons.open_in_new_rounded, size: 16),
                  onTap: () async {
                    const url =
                        'https://yumikokh.notion.site/Tanzaku-Todo-11f54c37a54c800da12cf5162f5beada';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                      analytics.logScreenView(screenName: 'FAQ');
                    }
                  },
                ),
                ListTile(
                  title: Text(l.settings_view_support_feedback_title),
                  trailing: const Icon(Icons.open_in_new_rounded, size: 16),
                  onTap: () async {
                    const url =
                        'https://docs.google.com/forms/d/e/1FAIpQLSfIdMsEJVzbWHdxdvNzr_-OUPEVqe3AMOmafCYctaa7hzcQpQ/viewform';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                      analytics.logScreenView(screenName: 'Feedback');
                    }
                  },
                ),
                ListTile(
                  title: Text(l.settings_view_support_release_notes_title),
                  trailing: const Icon(Icons.open_in_new_rounded, size: 16),
                  onTap: () async {
                    const url =
                        'https://yumikokh.notion.site/Release-Note-18154c37a54c807b8ac6ef6612524378';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                      analytics.logScreenView(screenName: 'ReleaseNotes');
                    }
                  },
                ),
                ListTile(
                  title: Text(l.settings_view_support_privacy_policy_title),
                  trailing: const Icon(Icons.open_in_new_rounded, size: 16),
                  onTap: () async {
                    const url =
                        'https://yumikokh.notion.site/Privacy-Policy-14b54c37a54c80e1b288c0097bb6c7bd';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                      analytics.logScreenView(screenName: 'PrivacyPolicy');
                    }
                  },
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                final version = await appVersionViewModel.getCurrentVersion();
                if (!context.mounted) return;
                Clipboard.setData(ClipboardData(text: version));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l.settings_view_version_copy),
                    duration: const Duration(seconds: 2),
                  ),
                );
                analytics.logSettingsChanged(
                  settingName: 'copy_version',
                  value: version,
                );
              },
              child: ListTile(
                title: Text(l.settings_view_version_title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder<String>(
                      future: appVersionViewModel.getCurrentVersion(),
                      builder: (context, snapshot) {
                        final version = snapshot.data ?? '';
                        return Text(version,
                            style: const TextStyle(fontSize: 14));
                      },
                    ),
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
