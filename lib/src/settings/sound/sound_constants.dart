import 'package:flutter/material.dart';

class SoundConstants {
  static const List<String> soundTypes = [
    'none',
    'cute',
    'mokkin',
    'mokugyo',
  ];

  static String getSoundName(String soundType) {
    switch (soundType) {
      case 'none':
        return 'なし';
      case 'cute':
        return 'かわいい音';
      case 'mokkin':
        return '木琴';
      case 'mokugyo':
        return '木魚';
      default:
        return soundType;
    }
  }

  static IconData getSoundIcon(String soundType) {
    switch (soundType) {
      case 'none':
        return Icons.volume_off;
      case 'cute':
        return Icons.music_note;
      case 'mokkin':
        return Icons.music_note;
      case 'mokugyo':
        return Icons.music_note;
      default:
        return Icons.music_note;
    }
  }
}
