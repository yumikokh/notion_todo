import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../common/widgets/settings_list_tile.dart';
import '../font/view/font_settings_view.dart';
import '../settings_viewmodel.dart';
import 'theme_settings_page.dart';

class AppearanceSettingsPage extends ConsumerWidget {
  static const routeName = '/settings/appearance';

  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final settingsViewModel = ref.watch(settingsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l.appearance_settings_title,
            style: const TextStyle(fontSize: 18)),
      ),
      body: ListView(
        children: [
          SettingsListTile.navigation(
            title: l.settings_view_theme_settings_title,
            subtitle: l.current_setting(settingsViewModel.themeModeName),
            analyticsScreenName: 'ThemeSettings',
            onTap: () {
              Navigator.of(context).pushNamed(ThemeSettingsPage.routeName);
            },
          ),
          SettingsListTile.navigation(
            title: l.font_settings,
            subtitle: l.font_settings_description,
            analyticsScreenName: 'FontSettings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FontSettingsView(),
                ),
              );
            },
          ),
          SettingsListTile.switchTile(
            title: l.hide_navigation_label_title,
            subtitle: l.hide_navigation_label_description,
            value: settingsViewModel.hideNavigationLabel,
            analyticsSettingName: 'hideNavigationLabel',
            onChanged: (value) {
              settingsViewModel.updateHideNavigationLabel(value);
            },
          ),
        ],
      ),
    );
  }
}
