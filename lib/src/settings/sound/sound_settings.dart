import 'package:freezed_annotation/freezed_annotation.dart';

part 'sound_settings.freezed.dart';
part 'sound_settings.g.dart';

@freezed
class SoundSettings with _$SoundSettings {
  const factory SoundSettings({
    @Default(true) bool enabled,
    @Default('success') String soundType,
  }) = _SoundSettings;

  factory SoundSettings.fromJson(Map<String, dynamic> json) =>
      _$SoundSettingsFromJson(json);
}
