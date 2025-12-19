// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'font_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FontSettings {

 String get languageCode; String get fontFamily; bool get isItalic; bool get isBold; double get fontSize; double get letterSpacing;
/// Create a copy of FontSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FontSettingsCopyWith<FontSettings> get copyWith => _$FontSettingsCopyWithImpl<FontSettings>(this as FontSettings, _$identity);

  /// Serializes this FontSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FontSettings&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.isItalic, isItalic) || other.isItalic == isItalic)&&(identical(other.isBold, isBold) || other.isBold == isBold)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.letterSpacing, letterSpacing) || other.letterSpacing == letterSpacing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,languageCode,fontFamily,isItalic,isBold,fontSize,letterSpacing);

@override
String toString() {
  return 'FontSettings(languageCode: $languageCode, fontFamily: $fontFamily, isItalic: $isItalic, isBold: $isBold, fontSize: $fontSize, letterSpacing: $letterSpacing)';
}


}

/// @nodoc
abstract mixin class $FontSettingsCopyWith<$Res>  {
  factory $FontSettingsCopyWith(FontSettings value, $Res Function(FontSettings) _then) = _$FontSettingsCopyWithImpl;
@useResult
$Res call({
 String languageCode, String fontFamily, bool isItalic, bool isBold, double fontSize, double letterSpacing
});




}
/// @nodoc
class _$FontSettingsCopyWithImpl<$Res>
    implements $FontSettingsCopyWith<$Res> {
  _$FontSettingsCopyWithImpl(this._self, this._then);

  final FontSettings _self;
  final $Res Function(FontSettings) _then;

/// Create a copy of FontSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languageCode = null,Object? fontFamily = null,Object? isItalic = null,Object? isBold = null,Object? fontSize = null,Object? letterSpacing = null,}) {
  return _then(_self.copyWith(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,isItalic: null == isItalic ? _self.isItalic : isItalic // ignore: cast_nullable_to_non_nullable
as bool,isBold: null == isBold ? _self.isBold : isBold // ignore: cast_nullable_to_non_nullable
as bool,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,letterSpacing: null == letterSpacing ? _self.letterSpacing : letterSpacing // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FontSettings].
extension FontSettingsPatterns on FontSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FontSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FontSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FontSettings value)  $default,){
final _that = this;
switch (_that) {
case _FontSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FontSettings value)?  $default,){
final _that = this;
switch (_that) {
case _FontSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String languageCode,  String fontFamily,  bool isItalic,  bool isBold,  double fontSize,  double letterSpacing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FontSettings() when $default != null:
return $default(_that.languageCode,_that.fontFamily,_that.isItalic,_that.isBold,_that.fontSize,_that.letterSpacing);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String languageCode,  String fontFamily,  bool isItalic,  bool isBold,  double fontSize,  double letterSpacing)  $default,) {final _that = this;
switch (_that) {
case _FontSettings():
return $default(_that.languageCode,_that.fontFamily,_that.isItalic,_that.isBold,_that.fontSize,_that.letterSpacing);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String languageCode,  String fontFamily,  bool isItalic,  bool isBold,  double fontSize,  double letterSpacing)?  $default,) {final _that = this;
switch (_that) {
case _FontSettings() when $default != null:
return $default(_that.languageCode,_that.fontFamily,_that.isItalic,_that.isBold,_that.fontSize,_that.letterSpacing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FontSettings implements FontSettings {
  const _FontSettings({this.languageCode = 'en', this.fontFamily = 'Bodoni Moda', this.isItalic = true, this.isBold = false, this.fontSize = 28, this.letterSpacing = -0.8});
  factory _FontSettings.fromJson(Map<String, dynamic> json) => _$FontSettingsFromJson(json);

@override@JsonKey() final  String languageCode;
@override@JsonKey() final  String fontFamily;
@override@JsonKey() final  bool isItalic;
@override@JsonKey() final  bool isBold;
@override@JsonKey() final  double fontSize;
@override@JsonKey() final  double letterSpacing;

/// Create a copy of FontSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FontSettingsCopyWith<_FontSettings> get copyWith => __$FontSettingsCopyWithImpl<_FontSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FontSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FontSettings&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.isItalic, isItalic) || other.isItalic == isItalic)&&(identical(other.isBold, isBold) || other.isBold == isBold)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.letterSpacing, letterSpacing) || other.letterSpacing == letterSpacing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,languageCode,fontFamily,isItalic,isBold,fontSize,letterSpacing);

@override
String toString() {
  return 'FontSettings(languageCode: $languageCode, fontFamily: $fontFamily, isItalic: $isItalic, isBold: $isBold, fontSize: $fontSize, letterSpacing: $letterSpacing)';
}


}

/// @nodoc
abstract mixin class _$FontSettingsCopyWith<$Res> implements $FontSettingsCopyWith<$Res> {
  factory _$FontSettingsCopyWith(_FontSettings value, $Res Function(_FontSettings) _then) = __$FontSettingsCopyWithImpl;
@override @useResult
$Res call({
 String languageCode, String fontFamily, bool isItalic, bool isBold, double fontSize, double letterSpacing
});




}
/// @nodoc
class __$FontSettingsCopyWithImpl<$Res>
    implements _$FontSettingsCopyWith<$Res> {
  __$FontSettingsCopyWithImpl(this._self, this._then);

  final _FontSettings _self;
  final $Res Function(_FontSettings) _then;

/// Create a copy of FontSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languageCode = null,Object? fontFamily = null,Object? isItalic = null,Object? isBold = null,Object? fontSize = null,Object? letterSpacing = null,}) {
  return _then(_FontSettings(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,isItalic: null == isItalic ? _self.isItalic : isItalic // ignore: cast_nullable_to_non_nullable
as bool,isBold: null == isBold ? _self.isBold : isBold // ignore: cast_nullable_to_non_nullable
as bool,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,letterSpacing: null == letterSpacing ? _self.letterSpacing : letterSpacing // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
