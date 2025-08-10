import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> alphabetFonts = [
  'Bodoni Moda',
  'Roboto',
  'M PLUS 1p',
  'Amatic SC',
];

class FontConstants {
  static final Map<String, List<String>> fontsByLanguage = {
    'en': [
      ...alphabetFonts,
    ],
    'ja': [
      'Noto Sans JP',
      'Zen Old Mincho',
    ],
    'ko': [
      'Nanum Gothic',
      'Nanum Myeongjo',
    ],
    'zh_Hant': [
      'Noto Sans TC',
      'Noto Serif TC',
    ],
    'es': [
      ...alphabetFonts,
    ],
    'fr': [
      ...alphabetFonts,
    ],
    'de': [
      ...alphabetFonts,
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
