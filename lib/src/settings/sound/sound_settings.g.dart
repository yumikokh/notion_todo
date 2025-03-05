// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SoundSettingsImpl _$$SoundSettingsImplFromJson(Map<String, dynamic> json) =>
    _$SoundSettingsImpl(
      enabled: json['enabled'] as bool? ?? true,
      soundType: json['soundType'] as String? ?? 'cute',
    );

Map<String, dynamic> _$$SoundSettingsImplToJson(_$SoundSettingsImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'soundType': instance.soundType,
    };
