import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../settings/settings_viewmodel.dart';
import 'sound_service.dart';

part 'sound_viewmodel.g.dart';

@Riverpod(keepAlive: true)
SoundViewModel soundViewModel(Ref ref) {
  final soundEnabled = ref.watch(settingsViewModelProvider).soundEnabled;
  final soundService = SoundService();

  ref.onDispose(() {
    soundService.dispose();
  });

  return SoundViewModel(soundService, soundEnabled);
}

class SoundViewModel {
  final SoundService _soundService;
  final bool _soundEnabled;

  static const soundPath = 'sounds/cute.mp3';

  SoundViewModel(this._soundService, this._soundEnabled);

  Future<void> playSound() async {
    if (!_soundEnabled) return;
    await _soundService.stopSound();
    await _soundService.playSound(soundPath);
  }

  void dispose() {
    _soundService.dispose();
  }
}
