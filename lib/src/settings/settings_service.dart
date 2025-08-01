import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl_standalone.dart' as intl_standalone;
import 'package:tanzaku_todo/generated/app_localizations.dart';

import '../widget/widget_service.dart';

class SettingsService {
  static const _themeModeKey = 'themeMode';
  static const _languageKey = 'language';
  static const _wakelockKey = 'wakelock';
  static const _hideNavigationLabelKey = 'hide_navigation_label';
  static const _showNotificationBadgeKey = 'show_notification_badge';
  static const _continuousTaskAdditionKey = 'continuous_task_addition';
  static const _soundEnabledKey = 'sound_enabled';

  /* themeMode */
  Future<ThemeMode> themeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeModeKey) ?? ThemeMode.system.index;
    return ThemeMode.values[themeIndex];
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, theme.index);
  }

  /* language */
  Future<Locale> locale() async {
    final prefs = await SharedPreferences.getInstance();
    final systemLanguageCode =
        (await intl_standalone.findSystemLocale()).split('_').first;
    const supportedLocales = AppLocalizations.supportedLocales;
    // 対応している言語の中で、 保存された言語 > システム言語 > 英語
    final languageCode = prefs.getString(_languageKey) ??
        (supportedLocales.any((l) => l.languageCode == systemLanguageCode)
            ? systemLanguageCode
            : 'en');

    WidgetService.updateLocaleForWidget(languageCode);
    return Locale(languageCode);
  }

  Future<void> updateLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = locale.languageCode;
    await prefs.setString(_languageKey, languageCode);
    WidgetService.updateLocaleForWidget(languageCode);
  }

  /* wakelock */
  Future<bool> wakelock() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_wakelockKey) ?? false;
  }

  Future<void> updateWakelock(bool wakelock) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_wakelockKey, wakelock);
  }

  /* packageInfo */
  Future<PackageInfo> packageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  /* hideNavigationLabel */

  Future<bool> loadHideNavigationLabel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hideNavigationLabelKey) ?? false;
  }

  Future<void> saveHideNavigationLabel(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hideNavigationLabelKey, value);
  }

  /* notificationBadge */

  Future<bool> loadShowNotificationBadge() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showNotificationBadgeKey) ?? true;
  }

  Future<void> saveShowNotificationBadge(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showNotificationBadgeKey, value);
  }

  Future<void> updateShowNotificationBadge(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showNotificationBadgeKey, value);
  }

  /* continuousTaskAddition */
  Future<bool> loadContinuousTaskAddition() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_continuousTaskAdditionKey) ?? true;
  }

  Future<void> updateContinuousTaskAddition(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_continuousTaskAdditionKey, value);
  }

  /* soundEnabled */
  Future<bool> loadSoundEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_soundEnabledKey) ?? true;
  }

  Future<void> updateSoundEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundEnabledKey, value);
  }

  // 言語設定を保存
  Future<void> saveLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', languageCode);
    await WidgetService.updateLocaleForWidget(languageCode);
  }

  // 言語設定を取得
  Future<String> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('locale') ?? 'en';
    await WidgetService.updateLocaleForWidget(languageCode);
    return languageCode;
  }
}
