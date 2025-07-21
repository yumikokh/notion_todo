import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notion_todo/src/common/sound/sound_service.dart';
import 'package:notion_todo/src/common/sound/sound_viewmodel.dart';

void main() {
  group('SoundViewModel', () {
    test('playSound should use playCompletionSound when enabled', () async {
      final soundService = _MockSoundService();
      final viewModel = SoundViewModel(soundService, true);
      
      await viewModel.playSound();
      
      expect(soundService.playCompletionSoundCalled, true);
      expect(soundService.playSoundCalled, false);
    });

    test('playSound should not play when disabled', () async {
      final soundService = _MockSoundService();
      final viewModel = SoundViewModel(soundService, false);
      
      await viewModel.playSound();
      
      expect(soundService.playCompletionSoundCalled, false);
      expect(soundService.playSoundCalled, false);
    });
  });
}

class _MockSoundService extends SoundService {
  bool playCompletionSoundCalled = false;
  bool playSoundCalled = false;

  @override
  Future<void> playCompletionSound(String assetPath) async {
    playCompletionSoundCalled = true;
  }

  @override
  Future<void> playSound(String assetPath) async {
    playSoundCalled = true;
  }

  @override
  void dispose() {}
}