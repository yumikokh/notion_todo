import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'settings_service.dart';
import '../common/analytics/analytics_service.dart';

class SettingsViewModel with ChangeNotifier {
  final SettingsService _settingsService;
  final AnalyticsService _analytics;

  SettingsViewModel(this._settingsService, this._analytics) {
    _themeMode = ThemeMode.system;
    _locale = const Locale('en');
    _wakelock = false;
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _locale = await _settingsService.locale();
    _wakelock = await _settingsService.wakelock();
    _hideNavigationLabel = await _settingsService.loadHideNavigationLabel();
    notifyListeners();
  }

  /// ThemeMode
  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;
  String get themeModeName =>
      _themeMode.name[0].toUpperCase() +
      _themeMode.name.substring(1).toLowerCase();

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;
    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
    await _analytics.logSettingsChanged(
      settingName: 'theme_mode',
      value: newThemeMode.name,
    );
  }

  /// Language
  late Locale _locale;
  Locale get locale => _locale;
  String languageName(AppLocalizations l) => switch (_locale) {
        Locale(languageCode: 'en') => l.language_settings_language_en,
        Locale(languageCode: 'ja') => l.language_settings_language_ja,
        _ => 'Unknown',
      };

  Future<void> updateLocale(Locale locale) async {
    if (locale == _locale) return;

    _locale = locale;
    notifyListeners();

    await _settingsService.updateLocale(locale);
    await _analytics.logSettingsChanged(
      settingName: 'locale',
      value: locale.languageCode,
    );
  }

  /// Wakelock
  late bool _wakelock;
  bool get wakelock => _wakelock;
  Future<void> updateWakelock(bool wakelock) async {
    if (wakelock == _wakelock) return;

    _wakelock = wakelock;
    notifyListeners();

    await _settingsService.updateWakelock(wakelock);
    await _analytics.logSettingsChanged(
      settingName: 'wakelock',
      value: wakelock ? 'enabled' : 'disabled',
    );
  }

  /// Navigation Label
  late bool _hideNavigationLabel;
  bool get hideNavigationLabel => _hideNavigationLabel;

  Future<void> updateHideNavigationLabel(bool value) async {
    if (value == _hideNavigationLabel) return;

    _hideNavigationLabel = value;
    notifyListeners();

    await _settingsService.saveHideNavigationLabel(value);
    await _analytics.logSettingsChanged(
      settingName: 'hide_navigation_label',
      value: value ? 'hidden' : 'shown',
    );
  }
}

// MEMO: code-generatorで生成されるProviderはデフォルトで自動破棄が有効なため、appでListenableに適用できない
// keepAliveをtrueにしてもうまくいかなかったため、手動で作成している
// see: https://stackoverflow.com/questions/69512241/how-to-get-a-listenable-from-a-riverpod-provider
// see: https://riverpod.dev/ja/docs/concepts/about_code_generation#autodispose-%E3%81%AE%E6%9C%89%E5%8A%B9%E7%84%A1%E5%8A%B9%E5%8C%96
final settingsViewModelProvider = ChangeNotifierProvider<SettingsViewModel>(
  (ref) => SettingsViewModel(
    SettingsService(),
    ref.read(analyticsServiceProvider),
  ),
);
