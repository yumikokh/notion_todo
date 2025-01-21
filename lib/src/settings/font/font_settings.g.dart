// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'font_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FontSettingsImpl _$$FontSettingsImplFromJson(Map<String, dynamic> json) =>
    _$FontSettingsImpl(
      languageCode: json['languageCode'] as String? ?? 'en',
      fontFamily: json['fontFamily'] as String? ?? 'Bodoni Moda',
      isItalic: json['isItalic'] as bool? ?? true,
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 28,
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble() ?? -0.8,
    );

Map<String, dynamic> _$$FontSettingsImplToJson(_$FontSettingsImpl instance) =>
    <String, dynamic>{
      'languageCode': instance.languageCode,
      'fontFamily': instance.fontFamily,
      'isItalic': instance.isItalic,
      'fontSize': instance.fontSize,
      'letterSpacing': instance.letterSpacing,
    };
