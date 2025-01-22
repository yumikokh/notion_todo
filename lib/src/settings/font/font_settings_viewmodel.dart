import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/analytics/analytics_service.dart';
import 'font_settings.dart';
import 'font_settings_service.dart';

part 'font_settings_viewmodel.g.dart';

@riverpod
class FontSettingsViewModel extends _$FontSettingsViewModel {
  late final _service = FontSettingsService();
  late FontSettings _temporarySettings;

  @override
  Future<FontSettings> build() async {
    final settings = await _service.getFontSettings();
    _temporarySettings = settings;
    return settings;
  }

  Future<void> updateFontSettings(FontSettings settings) async {
    await _service.updateFontSettings(settings);
    state = AsyncValue.data(settings);
  }

  Future<void> updateTemporarySettings(FontSettings settings) async {
    _temporarySettings = settings;
    state = AsyncValue.data(settings);
  }

  Future<void> saveSettings() async {
    await updateFontSettings(_temporarySettings);

    final analytics = ref.read(analyticsServiceProvider);
    analytics.logSettingsChanged(
        settingName: 'font-settings', value: _temporarySettings.fontFamily);
  }

  Future<void> resetTemporarySettings() async {
    final settings = await _service.getFontSettings();
    _temporarySettings = settings;
    state = AsyncValue.data(settings);
  }

  Future<void> resetToDefault() async {
    await updateTemporarySettings(const FontSettings());
  }
}
