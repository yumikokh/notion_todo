import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'font_settings.dart';

class FontSettingsService {
  static const _fontSettingsKey = 'fontSettings';

  Future<FontSettings> getFontSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_fontSettingsKey);
    if (json == null) {
      return const FontSettings();
    }
    return FontSettings.fromJson(Map<String, dynamic>.from(
      Map.from(jsonDecode(json)),
    ));
  }

  Future<void> updateFontSettings(FontSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _fontSettingsKey,
      jsonEncode(settings.toJson()),
    );
  }
}
