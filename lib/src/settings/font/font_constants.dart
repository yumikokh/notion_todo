import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontConstants {
  static const Map<String, List<String>> fontsByLanguage = {
    'en': [
      'Bodoni Moda',
      'Playfair Display',
      'Cormorant Garamond',
      'Libre Baskerville',
      'Crimson Text',
    ],
    'ja': [
      'Bodoni Moda',
      // 'Noto Serif JP',
      // 'Shippori Mincho B1',
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
