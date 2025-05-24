import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../common/analytics/analytics_service.dart';
import '../../helpers/haptic_helper.dart';
import '../font/view/font_settings_view.dart';
import '../settings_viewmodel.dart';
import 'theme_settings_page.dart';

class AppearanceSettingsPage extends ConsumerWidget {
  static const routeName = '/settings/appearance';

  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);
    final settingsViewModel = ref.watch(settingsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l.appearance_settings_title,
            style: const TextStyle(fontSize: 18)),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(l.settings_view_theme_settings_title),
            subtitle: Text(l.current_setting(settingsViewModel.themeModeName),
                style: const TextStyle(fontSize: 11)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              analytics.logScreenView(screenName: 'ThemeSettings');
              Navigator.of(context).pushNamed(ThemeSettingsPage.routeName);
            },
          ),
          ListTile(
            title: Text(l.font_settings),
            subtitle: Text(l.font_settings_description,
                style: const TextStyle(fontSize: 11)),
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
            title: Text(l.hide_navigation_label_title),
            subtitle: Text(l.hide_navigation_label_description,
                style: const TextStyle(fontSize: 11)),
            trailing: Switch(
              value: settingsViewModel.hideNavigationLabel,
              onChanged: (value) {
                analytics.logSettingsChanged(
                    settingName: 'hideNavigationLabel',
                    value: value.toString());
                settingsViewModel.updateHideNavigationLabel(value);
                HapticHelper.light();
              },
            ),
          ),
        ],
      ),
    );
  }
}
