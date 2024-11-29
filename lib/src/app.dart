import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/snackbar/view/snackbar_listener.dart';
import 'settings/task_database/view/task_database_setting_page.dart';
import 'notion/tasks/view/task_main_page.dart';
import 'settings/view/notion_settings_view.dart';
import 'settings/settings_viewmodel.dart';
import 'settings/view/settings_view.dart';
import 'settings/theme/theme.dart';
import 'settings/theme/util.dart';
import 'settings/view/theme_settings_view.dart';

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

    initATT();

    return AnimatedBuilder(
      animation: settingsViewModel,
      builder: (BuildContext context, Widget? child) => SnackbarListener(
        scaffoldMessengerKey: scaffoldMessengerKey,
        child: MaterialApp(
          scaffoldMessengerKey: scaffoldMessengerKey,
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

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
                  case SettingsView.routeName:
                    return SettingsView(settingsViewModel: settingsViewModel);
                  case NotionSettingsView.routeName:
                    return const NotionSettingsView();
                  case ThemeSettingsView.routeName:
                    return ThemeSettingsView(settingsViewModel);
                  case TaskDatabaseSettingPage.routeName:
                    return const TaskDatabaseSettingPage();
                  case TaskMainPage.routeName:
                    return const TaskMainPage();
                  default:
                    return const TaskMainPage();
                }
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> initATT() async {
    if (await AppTrackingTransparency.trackingAuthorizationStatus ==
        TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }
}
