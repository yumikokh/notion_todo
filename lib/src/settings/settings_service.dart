import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl_standalone.dart' as intl_standalone;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsService {
  static const _themeModeKey = 'themeMode';
  static const _languageKey = 'language';

  Future<ThemeMode> themeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeModeKey) ?? ThemeMode.system.index;
    return ThemeMode.values[themeIndex];
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, theme.index);
  }

  Future<Locale> language() async {
    final prefs = await SharedPreferences.getInstance();
    final systemLanguageCode =
        (await intl_standalone.findSystemLocale()).split('_').first;
    const supportedLocales = AppLocalizations.supportedLocales;
    // 対応している言語の中で、 保存された言語 > システム言語 > 英語
    final languageCode = prefs.getString(_languageKey) ??
        (supportedLocales.any((l) => l.languageCode == systemLanguageCode)
            ? systemLanguageCode
            : 'en');
    return Locale(languageCode);
  }

  Future<void> updateLanguage(Locale language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, language.languageCode);
  }

  Future<PackageInfo> packageInfo() async {
    return await PackageInfo.fromPlatform();
  }
}
