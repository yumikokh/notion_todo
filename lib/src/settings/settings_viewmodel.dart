import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';

import 'settings_service.dart';
import '../common/analytics/analytics_service.dart';
import '../common/mixins/settings_update_mixin.dart';

class SettingsViewModel with ChangeNotifier, SettingsUpdateMixin {
  final SettingsService _settingsService;
  final AnalyticsService _analytics;

  SettingsViewModel(this._settingsService, this._analytics) {
    _themeMode = ThemeMode.system;
    _locale = const Locale('en');
    _wakelock = false;
    _soundEnabled = true;
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _locale = await _settingsService.locale();
    _wakelock = await _settingsService.wakelock();
    _hideNavigationLabel = await _settingsService.loadHideNavigationLabel();
    _showNotificationBadge = await _settingsService.loadShowNotificationBadge();
    _continuousTaskAddition =
        await _settingsService.loadContinuousTaskAddition();
    _soundEnabled = await _settingsService.loadSoundEnabled();
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
    
    await updateEnumSetting(
      newValue: newThemeMode,
      currentValue: _themeMode,
      updateFunction: (value) => _themeMode = value,
      saveFunction: () => _settingsService.updateThemeMode(newThemeMode),
      analyticsKey: 'theme_mode',
      logAnalytics: (key, value) => _analytics.logSettingsChanged(
        settingName: key,
        value: value,
      ),
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
    await updateSetting(
      newValue: locale,
      currentValue: _locale,
      updateFunction: (value) => _locale = value,
      saveFunction: () => _settingsService.updateLocale(locale),
      analyticsKey: 'locale',
      logAnalytics: (key, _) => _analytics.logSettingsChanged(
        settingName: key,
        value: locale.languageCode,
      ),
    );
  }

  /// Wakelock
  late bool _wakelock;
  bool get wakelock => _wakelock;
  Future<void> updateWakelock(bool wakelock) async {
    await updateBoolSetting(
      newValue: wakelock,
      currentValue: _wakelock,
      updateFunction: (value) => _wakelock = value,
      saveFunction: () => _settingsService.updateWakelock(wakelock),
      analyticsKey: 'wakelock',
      logAnalytics: (key, value) => _analytics.logSettingsChanged(
        settingName: key,
        value: value,
      ),
    );
  }

  /// Navigation Label
  late bool _hideNavigationLabel;
  bool get hideNavigationLabel => _hideNavigationLabel;

  Future<void> updateHideNavigationLabel(bool value) async {
    await updateSetting(
      newValue: value,
      currentValue: _hideNavigationLabel,
      updateFunction: (v) => _hideNavigationLabel = v,
      saveFunction: () => _settingsService.saveHideNavigationLabel(value),
      analyticsKey: 'hide_navigation_label',
      logAnalytics: (key, _) => _analytics.logSettingsChanged(
        settingName: key,
        value: value ? 'hidden' : 'shown',
      ),
    );
  }

  /// Notification Badge
  late bool _showNotificationBadge;
  bool get showNotificationBadge => _showNotificationBadge;
  Future<void> updateShowNotificationBadge(bool value) async {
    await updateBoolSetting(
      newValue: value,
      currentValue: _showNotificationBadge,
      updateFunction: (v) => _showNotificationBadge = v,
      saveFunction: () => _settingsService.updateShowNotificationBadge(value),
      analyticsKey: 'show_notification_badge',
      logAnalytics: (key, value) => _analytics.logSettingsChanged(
        settingName: key,
        value: value,
      ),
    );
  }

  /// Continuous Task Addition
  late bool _continuousTaskAddition;
  bool get continuousTaskAddition => _continuousTaskAddition;
  Future<void> updateContinuousTaskAddition(bool value) async {
    await updateBoolSetting(
      newValue: value,
      currentValue: _continuousTaskAddition,
      updateFunction: (v) => _continuousTaskAddition = v,
      saveFunction: () => _settingsService.updateContinuousTaskAddition(value),
      analyticsKey: 'continuous_task_addition',
      logAnalytics: (key, value) => _analytics.logSettingsChanged(
        settingName: key,
        value: value,
      ),
    );
  }

  /// Sound Enabled
  late bool _soundEnabled;
  bool get soundEnabled => _soundEnabled;
  Future<void> updateSoundEnabled(bool value) async {
    await updateBoolSetting(
      newValue: value,
      currentValue: _soundEnabled,
      updateFunction: (v) => _soundEnabled = v,
      saveFunction: () => _settingsService.updateSoundEnabled(value),
      analyticsKey: 'sound_enabled',
      logAnalytics: (key, value) => _analytics.logSettingsChanged(
        settingName: key,
        value: value,
      ),
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
