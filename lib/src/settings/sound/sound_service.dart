import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sound_service.g.dart';

class SoundService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSound(String soundType) async {
    if (soundType == 'none') return;

    try {
      final assetPath = _getSoundAssetPath(soundType);
      // 保留
      // await _audioPlayer.setAsset(assetPath);
      await _audioPlayer.setAudioSource(AudioSource.asset(assetPath));
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  String _getSoundAssetPath(String soundType) {
    switch (soundType) {
      case 'cute':
        return 'assets/sounds/cute.mp3';
      case 'mokkin':
        return 'assets/sounds/mokkin.mp3';
      case 'mokugyo':
        return 'assets/sounds/mokugyo.mp3';
      default:
        return 'assets/sounds/cute.mp3';
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

@Riverpod(keepAlive: true)
SoundService soundService(Ref ref) {
  final service = SoundService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
}
