import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontConstants {
  static final Map<String, List<String>> fontsByLanguage = {
    'en': [
      'Bodoni Moda',
      'M PLUS 1p',
      'Amatic SC',
    ],
    'ja': [
      'Noto Sans JP',
      'Zen Old Mincho',
    ],
    'ko': [
      'Nanum Gothic',
      'Nanum Myeongjo',
      'Nanum Pen Script',
    ],
    'zh_Hant': [
      'Noto Sans TC',
      'Noto Serif TC',
    ],
    'es': [
      'Bodoni Moda',
      'M PLUS 1p',
      'Amatic SC',
    ],
    'fr': [
      'Bodoni Moda',
      'M PLUS 1p',
      'Amatic SC',
    ],
    'de': [
      'Bodoni Moda',
      'M PLUS 1p',
      'Amatic SC',
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
