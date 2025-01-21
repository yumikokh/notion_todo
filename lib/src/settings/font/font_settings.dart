import 'package:freezed_annotation/freezed_annotation.dart';

part 'font_settings.freezed.dart';
part 'font_settings.g.dart';

@freezed
class FontSettings with _$FontSettings {
  const factory FontSettings({
    @Default('en') String languageCode,
    @Default('Bodoni Moda') String fontFamily,
    @Default(true) bool isItalic,
    @Default(false) bool isBold,
    @Default(28) double fontSize,
    @Default(-0.8) double letterSpacing,
  }) = _FontSettings;

  factory FontSettings.fromJson(Map<String, dynamic> json) =>
      _$FontSettingsFromJson(json);
}
