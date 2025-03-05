import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sound_settings.dart';

class SoundService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  static const _enabledKey = 'sound_enabled';
  static const _soundTypeKey = 'sound_type';

  Future<SoundSettings> getSoundSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool(_enabledKey) ?? true;
    final soundType = prefs.getString(_soundTypeKey) ?? 'cute';

    return SoundSettings(enabled: enabled, soundType: soundType);
  }

  Future<void> updateSoundSettings(SoundSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, settings.enabled);
    await prefs.setString(_soundTypeKey, settings.soundType);
  }

  Future<void> updateEnabled(bool enabled) async {
    final settings = await getSoundSettings();
    await updateSoundSettings(settings.copyWith(enabled: enabled));
  }

  Future<void> updateSoundType(String soundType) async {
    final settings = await getSoundSettings();
    await updateSoundSettings(settings.copyWith(soundType: soundType));
  }

  Future<void> playSound(String soundType) async {
    if (soundType == 'none') return;

    try {
      final assetPath = _getSoundAssetPath(soundType);
      print('Playing sound from asset: $assetPath');

      // audioplayers パッケージを使用してアセットから音声を再生
      await _audioPlayer.play(AssetSource(assetPath));
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  String _getSoundAssetPath(String soundType) {
    switch (soundType) {
      case 'cute':
        return 'sounds/cute.mp3';
      case 'mokkin':
        return 'sounds/mokkin.mp3';
      case 'mokugyo':
        return 'sounds/mokugyo.mp3';
      default:
        return 'sounds/cute.mp3';
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
