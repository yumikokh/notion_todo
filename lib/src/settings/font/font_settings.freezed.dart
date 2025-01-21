// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'font_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FontSettings _$FontSettingsFromJson(Map<String, dynamic> json) {
  return _FontSettings.fromJson(json);
}

/// @nodoc
mixin _$FontSettings {
  String get languageCode => throw _privateConstructorUsedError;
  String get fontFamily => throw _privateConstructorUsedError;
  bool get isItalic => throw _privateConstructorUsedError;
  double get fontSize => throw _privateConstructorUsedError;
  double get letterSpacing => throw _privateConstructorUsedError;

  /// Serializes this FontSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FontSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FontSettingsCopyWith<FontSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FontSettingsCopyWith<$Res> {
  factory $FontSettingsCopyWith(
          FontSettings value, $Res Function(FontSettings) then) =
      _$FontSettingsCopyWithImpl<$Res, FontSettings>;
  @useResult
  $Res call(
      {String languageCode,
      String fontFamily,
      bool isItalic,
      double fontSize,
      double letterSpacing});
}

/// @nodoc
class _$FontSettingsCopyWithImpl<$Res, $Val extends FontSettings>
    implements $FontSettingsCopyWith<$Res> {
  _$FontSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FontSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languageCode = null,
    Object? fontFamily = null,
    Object? isItalic = null,
    Object? fontSize = null,
    Object? letterSpacing = null,
  }) {
    return _then(_value.copyWith(
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      fontFamily: null == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      isItalic: null == isItalic
          ? _value.isItalic
          : isItalic // ignore: cast_nullable_to_non_nullable
              as bool,
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      letterSpacing: null == letterSpacing
          ? _value.letterSpacing
          : letterSpacing // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FontSettingsImplCopyWith<$Res>
    implements $FontSettingsCopyWith<$Res> {
  factory _$$FontSettingsImplCopyWith(
          _$FontSettingsImpl value, $Res Function(_$FontSettingsImpl) then) =
      __$$FontSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String languageCode,
      String fontFamily,
      bool isItalic,
      double fontSize,
      double letterSpacing});
}

/// @nodoc
class __$$FontSettingsImplCopyWithImpl<$Res>
    extends _$FontSettingsCopyWithImpl<$Res, _$FontSettingsImpl>
    implements _$$FontSettingsImplCopyWith<$Res> {
  __$$FontSettingsImplCopyWithImpl(
      _$FontSettingsImpl _value, $Res Function(_$FontSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FontSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languageCode = null,
    Object? fontFamily = null,
    Object? isItalic = null,
    Object? fontSize = null,
    Object? letterSpacing = null,
  }) {
    return _then(_$FontSettingsImpl(
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      fontFamily: null == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      isItalic: null == isItalic
          ? _value.isItalic
          : isItalic // ignore: cast_nullable_to_non_nullable
              as bool,
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      letterSpacing: null == letterSpacing
          ? _value.letterSpacing
          : letterSpacing // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FontSettingsImpl implements _FontSettings {
  const _$FontSettingsImpl(
      {this.languageCode = 'en',
      this.fontFamily = 'Bodoni Moda',
      this.isItalic = true,
      this.fontSize = 28,
      this.letterSpacing = -0.8});

  factory _$FontSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FontSettingsImplFromJson(json);

  @override
  @JsonKey()
  final String languageCode;
  @override
  @JsonKey()
  final String fontFamily;
  @override
  @JsonKey()
  final bool isItalic;
  @override
  @JsonKey()
  final double fontSize;
  @override
  @JsonKey()
  final double letterSpacing;

  @override
  String toString() {
    return 'FontSettings(languageCode: $languageCode, fontFamily: $fontFamily, isItalic: $isItalic, fontSize: $fontSize, letterSpacing: $letterSpacing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FontSettingsImpl &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.isItalic, isItalic) ||
                other.isItalic == isItalic) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.letterSpacing, letterSpacing) ||
                other.letterSpacing == letterSpacing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, languageCode, fontFamily, isItalic, fontSize, letterSpacing);

  /// Create a copy of FontSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FontSettingsImplCopyWith<_$FontSettingsImpl> get copyWith =>
      __$$FontSettingsImplCopyWithImpl<_$FontSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FontSettingsImplToJson(
      this,
    );
  }
}

abstract class _FontSettings implements FontSettings {
  const factory _FontSettings(
      {final String languageCode,
      final String fontFamily,
      final bool isItalic,
      final double fontSize,
      final double letterSpacing}) = _$FontSettingsImpl;

  factory _FontSettings.fromJson(Map<String, dynamic> json) =
      _$FontSettingsImpl.fromJson;

  @override
  String get languageCode;
  @override
  String get fontFamily;
  @override
  bool get isItalic;
  @override
  double get fontSize;
  @override
  double get letterSpacing;

  /// Create a copy of FontSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FontSettingsImplCopyWith<_$FontSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
