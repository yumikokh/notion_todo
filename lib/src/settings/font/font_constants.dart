import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontConstants {
  static final Map<String, List<String>> fontsByLanguage = {
    'en': [
      'Bodoni Moda',
      'Roboto Condensed',
      'M PLUS 1p',
      'Ubuntu',
      'Amatic SC',
    ],
    'ja': [
      'Noto Sans JP',
      'Zen Old Mincho',
    ],
  };

  static List<String> getFontsForLocale(String languageCode) {
    return fontsByLanguage[languageCode] ?? fontsByLanguage['en']!;
  }

  static TextStyle getFont(String fontFamily) {
    try {
      return GoogleFonts.getFont(fontFamily);
    } catch (e) {
      return GoogleFonts.getFont('Bodoni Moda');
    }
  }
}
