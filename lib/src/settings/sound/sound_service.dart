import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sound_service.g.dart';

class SoundService {
  final AudioPlayer _audioPlayer = AudioPlayer();

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

@Riverpod(keepAlive: true)
SoundService soundService(Ref ref) {
  final service = SoundService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
}
