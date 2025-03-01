import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sound_settings.dart';

part 'sound_settings_viewmodel.g.dart';

@riverpod
class SoundSettingsViewModel extends _$SoundSettingsViewModel {
  @override
  SoundSettings build() {
    _loadSettings();
    return const SoundSettings();
  }

  static const _enabledKey = 'sound_enabled';
  static const _soundTypeKey = 'sound_type';

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool(_enabledKey) ?? true;
    final soundType = prefs.getString(_soundTypeKey) ?? 'success';
    state = SoundSettings(enabled: enabled, soundType: soundType);
  }

  Future<void> updateSettings(SoundSettings settings) async {
    state = settings;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, settings.enabled);
    await prefs.setString(_soundTypeKey, settings.soundType);
  }

  Future<void> updateEnabled(bool enabled) async {
    await updateSettings(state.copyWith(enabled: enabled));
  }

  Future<void> updateSoundType(String soundType) async {
    await updateSettings(state.copyWith(soundType: soundType));
  }
}
