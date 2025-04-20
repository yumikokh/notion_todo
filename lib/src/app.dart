import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common/snackbar/view/snackbar_listener.dart';
import 'helpers/date.dart';
import 'common/app_lifecycle_observer.dart';
import 'common/app_version/view/app_version_notifier.dart';
import 'notion/common/filter_type.dart';
import 'settings/task_database/view/task_database_setting_page.dart';
import 'notion/tasks/view/task_main_page.dart';
import 'settings/view/appearance_settings_page.dart';
import 'settings/view/behavior_settings_page.dart';
import 'settings/view/language_settings_page.dart';
import 'settings/view/licenses_page.dart';
import 'settings/view/notification_settings_page.dart';
import 'settings/view/notion_settings_page.dart';
import 'settings/settings_viewmodel.dart';
import 'settings/view/settings_page.dart';
import 'settings/theme/theme.dart';
import 'settings/theme/util.dart';
import 'settings/view/theme_settings_page.dart';
import 'widget/widget_service.dart';
import 'notion/tasks/task_viewmodel.dart';

/// The Widget that configures your application.
class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  static bool _isInitialized = false;
  static GlobalKey<NavigatorState> globalNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void _initializeApp(BuildContext context, WidgetRef ref) {
    if (_isInitialized) return;

    // アプリ起動時にアップデートチェックを実行
    AppVersionNotifier.checkAndShow(context, ref);

    // ウィジェットからの起動処理
    WidgetService.registerInitialLaunchFromWidget(globalNavigatorKey, ref);
    WidgetService.startListeningWidgetClicks(globalNavigatorKey, ref);

    _isInitialized = true;
  }

  @override
  Widget build(BuildContext context, ref) {
    final settings = ref.watch(settingsViewModelProvider);
    final settingsViewModel = ref.read(settingsViewModelProvider.notifier);

    final TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    final MaterialTheme theme = MaterialTheme(textTheme);

    DateHelper().setup(settings.locale.languageCode);

    // アプリのライフサイクル管理
    useEffect(() {
      Future<void> applyWidgetChanges() async {
        final lastUpdated = await WidgetService.getLastUpdatedTask();
        if (lastUpdated == null) return;
        // 今日のタスクとすべてのタスク両方に適用
        ref.invalidate(taskViewModelProvider(filterType: FilterType.today));
        ref.invalidate(taskViewModelProvider(filterType: FilterType.all));
        await WidgetService.clearLastUpdatedTask();
      }

      applyWidgetChanges();

      final observer = AppLifecycleObserver(applyWidgetChanges);
      WidgetsBinding.instance.addObserver(observer);
      return () => WidgetsBinding.instance.removeObserver(observer);
    }, []);

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

          navigatorKey: globalNavigatorKey,

          builder: (context, child) {
            if (!_isInitialized) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _initializeApp(context, ref);
              });
            }
            return child ?? const SizedBox.shrink();
          },

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
                  case BehaviorSettingsPage.routeName:
                    return const BehaviorSettingsPage();
                  case LicensesPage.routeName:
                    return const LicensesPage();
                  case TaskMainPage.routeName:
                    final arguments =
                        routeSettings.arguments as Map<String, dynamic>?;
                    final tab = arguments?['tab'] as String?;
                    return TaskMainPage(initialTab: tab);
                  default:
                    return const TaskMainPage(initialTab: 'today');
                }
              },
            );
          },
        ),
      ),
    );
  }
}
