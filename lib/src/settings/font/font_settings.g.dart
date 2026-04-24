// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'font_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FontSettings _$FontSettingsFromJson(Map<String, dynamic> json) =>
    _FontSettings(
      languageCode: json['languageCode'] as String? ?? 'en',
      fontFamily: json['fontFamily'] as String? ?? 'Bodoni Moda',
      isItalic: json['isItalic'] as bool? ?? true,
      isBold: json['isBold'] as bool? ?? false,
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 28,
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble() ?? -0.8,
    );

Map<String, dynamic> _$FontSettingsToJson(_FontSettings instance) =>
    <String, dynamic>{
      'languageCode': instance.languageCode,
      'fontFamily': instance.fontFamily,
      'isItalic': instance.isItalic,
      'isBold': instance.isBold,
      'fontSize': instance.fontSize,
      'letterSpacing': instance.letterSpacing,
    };
