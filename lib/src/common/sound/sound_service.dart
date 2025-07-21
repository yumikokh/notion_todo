import 'package:audioplayers/audioplayers.dart';

class SoundService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _completionSoundPlayer = AudioPlayer();

  Future<void> playSound(String assetPath) async {
    try {
      await _audioPlayer.play(AssetSource(assetPath));
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  Future<void> playCompletionSound(String assetPath) async {
    try {
      await _completionSoundPlayer.play(AssetSource(assetPath));
    } catch (e) {
      print('Error playing completion sound: $e');
    }
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
    _completionSoundPlayer.dispose();
  }
}
