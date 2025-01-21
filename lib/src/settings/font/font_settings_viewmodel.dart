import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'font_settings.dart';
import 'font_settings_service.dart';

part 'font_settings_viewmodel.g.dart';

@riverpod
class FontSettingsViewModel extends _$FontSettingsViewModel {
  late final _service = FontSettingsService();

  @override
  Future<FontSettings> build() async {
    return _service.getFontSettings();
  }

  Future<void> updateFontSettings(FontSettings settings) async {
    await _service.updateFontSettings(settings);
    state = AsyncData(settings);
  }
}
