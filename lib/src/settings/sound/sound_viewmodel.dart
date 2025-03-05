import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'sound_service.dart';
import 'sound_settings.dart';

part 'sound_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class SoundViewModel extends _$SoundViewModel {
  late final SoundService _soundService = SoundService();

  @override
  SoundSettings build() {
    _loadSettings();

    ref.onDispose(() {
      _soundService.dispose();
    });

    return const SoundSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await _soundService.getSoundSettings();
    state = settings;
  }

  Future<void> updateSettings(SoundSettings settings) async {
    state = settings;
    await _soundService.updateSoundSettings(settings);
  }

  Future<void> updateEnabled(bool enabled) async {
    await updateSettings(state.copyWith(enabled: enabled));
  }

  Future<void> updateSoundType(String soundType) async {
    await updateSettings(state.copyWith(soundType: soundType));
  }

  Future<void> playSound() async {
    if (!state.enabled) return;
    await _soundService.playSound(state.soundType);
  }
}
