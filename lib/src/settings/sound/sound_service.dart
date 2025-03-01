import 'package:just_audio/just_audio.dart';

class SoundService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  factory SoundService() => _instance;

  SoundService._();

  static final SoundService _instance = SoundService._();

  static SoundService get instance => _instance;

  Future<void> playSound(String soundType) async {
    if (soundType == 'none') return;

    try {
      // 音声ファイルのパスを取得
      final assetPath = _getSoundAssetPath(soundType);

      // 音声を再生
      await _audioPlayer.setAsset(assetPath);
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
