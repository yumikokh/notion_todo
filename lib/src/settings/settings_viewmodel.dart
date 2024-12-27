import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'settings_service.dart';

class SettingsViewModel with ChangeNotifier {
  final SettingsService _settingsService;

  SettingsViewModel(this._settingsService) {
    _themeMode = ThemeMode.system;
    _locale = const Locale('en');
    _version = '';

    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _locale = await _settingsService.locale();
    _version = (await _settingsService.packageInfo()).version;
    notifyListeners();
  }

  /// ThemeMode
  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;
    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
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
  }

  /// Version
  late String _version;
  String get version => _version;
}

// MEMO: code-generatorで生成されるProviderはデフォルトで自動破棄が有効なため、appでListenableに適用できない
// keepAliveをtrueにしてもうまくいかなかったため、手動で作成している
// see: https://stackoverflow.com/questions/69512241/how-to-get-a-listenable-from-a-riverpod-provider
// see: https://riverpod.dev/ja/docs/concepts/about_code_generation#autodispose-%E3%81%AE%E6%9C%89%E5%8A%B9%E7%84%A1%E5%8A%B9%E5%8C%96
final settingsViewModelProvider = ChangeNotifierProvider<SettingsViewModel>(
  (ref) => SettingsViewModel(SettingsService()),
);
