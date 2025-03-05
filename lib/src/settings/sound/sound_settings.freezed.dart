// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sound_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SoundSettings _$SoundSettingsFromJson(Map<String, dynamic> json) {
  return _SoundSettings.fromJson(json);
}

/// @nodoc
mixin _$SoundSettings {
  bool get enabled => throw _privateConstructorUsedError;
  String get soundType => throw _privateConstructorUsedError;

  /// Serializes this SoundSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SoundSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SoundSettingsCopyWith<SoundSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SoundSettingsCopyWith<$Res> {
  factory $SoundSettingsCopyWith(
          SoundSettings value, $Res Function(SoundSettings) then) =
      _$SoundSettingsCopyWithImpl<$Res, SoundSettings>;
  @useResult
  $Res call({bool enabled, String soundType});
}

/// @nodoc
class _$SoundSettingsCopyWithImpl<$Res, $Val extends SoundSettings>
    implements $SoundSettingsCopyWith<$Res> {
  _$SoundSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SoundSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? soundType = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      soundType: null == soundType
          ? _value.soundType
          : soundType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SoundSettingsImplCopyWith<$Res>
    implements $SoundSettingsCopyWith<$Res> {
  factory _$$SoundSettingsImplCopyWith(
          _$SoundSettingsImpl value, $Res Function(_$SoundSettingsImpl) then) =
      __$$SoundSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool enabled, String soundType});
}

/// @nodoc
class __$$SoundSettingsImplCopyWithImpl<$Res>
    extends _$SoundSettingsCopyWithImpl<$Res, _$SoundSettingsImpl>
    implements _$$SoundSettingsImplCopyWith<$Res> {
  __$$SoundSettingsImplCopyWithImpl(
      _$SoundSettingsImpl _value, $Res Function(_$SoundSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SoundSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? soundType = null,
  }) {
    return _then(_$SoundSettingsImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      soundType: null == soundType
          ? _value.soundType
          : soundType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SoundSettingsImpl implements _SoundSettings {
  const _$SoundSettingsImpl({this.enabled = true, this.soundType = 'cute'});

  factory _$SoundSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SoundSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final String soundType;

  @override
  String toString() {
    return 'SoundSettings(enabled: $enabled, soundType: $soundType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SoundSettingsImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.soundType, soundType) ||
                other.soundType == soundType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, enabled, soundType);

  /// Create a copy of SoundSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SoundSettingsImplCopyWith<_$SoundSettingsImpl> get copyWith =>
      __$$SoundSettingsImplCopyWithImpl<_$SoundSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SoundSettingsImplToJson(
      this,
    );
  }
}

abstract class _SoundSettings implements SoundSettings {
  const factory _SoundSettings({final bool enabled, final String soundType}) =
      _$SoundSettingsImpl;

  factory _SoundSettings.fromJson(Map<String, dynamic> json) =
      _$SoundSettingsImpl.fromJson;

  @override
  bool get enabled;
  @override
  String get soundType;

  /// Create a copy of SoundSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SoundSettingsImplCopyWith<_$SoundSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
