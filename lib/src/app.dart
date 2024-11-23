import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/app_theme.dart';
import 'common/snackbar/view/snackbar_listener.dart';
import 'notion/task_database/view/task_database_setting_page.dart';
import 'notion/tasks/view/task_main_page.dart';
import 'settings/settings_viewmodel.dart';
import 'settings/settings_view.dart';

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
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
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

          theme: AppTheme.light.copyWith(
              dividerTheme: DividerThemeData(color: Colors.grey[300]),
              appBarTheme: AppTheme.light.appBarTheme.copyWith(
                  centerTitle: true,
                  titleTextStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.grey),
              navigationBarTheme: AppTheme.light.navigationBarTheme.copyWith(
                  shadowColor: Colors.black,
                  labelBehavior:
                      NavigationDestinationLabelBehavior.alwaysHide)),
          darkTheme: AppTheme.dark.copyWith(
              appBarTheme: AppTheme.dark.appBarTheme.copyWith(
                  centerTitle: true,
                  titleTextStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.black),
              navigationBarTheme: AppTheme.dark.navigationBarTheme.copyWith(
                  labelBehavior:
                      NavigationDestinationLabelBehavior.alwaysHide)),
          themeMode: settings.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(
                      settingsViewModel: settingsViewModel,
                    );
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
}
