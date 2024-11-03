import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  // final settingsViewModel = SettingsViewModel(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  // await settingsViewModel.loadSettings();

  // final notionOAuthService = NotionOAuthService(
  //     Env.notionAuthUrl, Env.oAuthClientId, Env.oAuthClientSecret);
  // final notionViewModel = NotionViewModel(notionOAuthService);

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(ProviderScope(
    child: MyApp(),
  ));
  // MyApp(
  //   settingsViewModel: settingsViewModel, notionViewModel: notionViewModel));
}
