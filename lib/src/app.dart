import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/snackbar/view/snackbar_listener.dart';
import 'helpers/date.dart';
import 'common/app_version/view/app_version_notifier.dart';
import 'settings/task_database/view/task_database_setting_page.dart';
import 'notion/tasks/view/task_main_page.dart';
import 'settings/view/appearance_settings_page.dart';
import 'settings/view/language_settings_page.dart';
import 'settings/view/notification_settings_page.dart';
import 'settings/view/notion_settings_page.dart';
import 'settings/settings_viewmodel.dart';
import 'settings/view/settings_page.dart';
import 'settings/theme/theme.dart';
import 'settings/theme/util.dart';
import 'settings/view/theme_settings_page.dart';

/// The Widget that configures your application.
class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final settings = ref.watch(settingsViewModelProvider);
    final settingsViewModel = ref.read(settingsViewModelProvider.notifier);
    final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    final TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    final MaterialTheme theme = MaterialTheme(textTheme);

    DateHelper().setup(settings.locale.languageCode);

    return AnimatedBuilder(
      animation: settingsViewModel,
      builder: (BuildContext context, Widget? child) => SnackbarListener(
        scaffoldMessengerKey: scaffoldMessengerKey,
        child: MaterialApp(
          // debugShowCheckedModeBanner: false, // demo用
          scaffoldMessengerKey: scaffoldMessengerKey,
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: settings.locale,

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: settings.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsPage.routeName:
                    return const SettingsPage();
                  case NotionSettingsPage.routeName:
                    return const NotionSettingsPage();
                  case ThemeSettingsPage.routeName:
                    return const ThemeSettingsPage();
                  case LanguageSettingsPage.routeName:
                    return const LanguageSettingsPage();
                  case TaskDatabaseSettingPage.routeName:
                    return const TaskDatabaseSettingPage();
                  case AppearanceSettingsPage.routeName:
                    return const AppearanceSettingsPage();
                  case NotificationSettingsPage.routeName:
                    return const NotificationSettingsPage();
                  case TaskMainPage.routeName:
                    return const TaskMainPage();
                  default:
                    return const TaskMainPage();
                }
              },
            );
          },
          home: Builder(
            builder: (context) {
              // アプリ起動時にアップデートチェックを実行
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppVersionNotifier.checkAndShow(context, ref);
              });
              return const TaskMainPage();
            },
          ),
        ),
      ),
    );
  }
}
