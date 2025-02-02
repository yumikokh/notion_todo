// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notion_oauth_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NotionOAuth {
  String? get accessToken => throw _privateConstructorUsedError;

  /// Create a copy of NotionOAuth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotionOAuthCopyWith<NotionOAuth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotionOAuthCopyWith<$Res> {
  factory $NotionOAuthCopyWith(
          NotionOAuth value, $Res Function(NotionOAuth) then) =
      _$NotionOAuthCopyWithImpl<$Res, NotionOAuth>;
  @useResult
  $Res call({String? accessToken});
}

/// @nodoc
class _$NotionOAuthCopyWithImpl<$Res, $Val extends NotionOAuth>
    implements $NotionOAuthCopyWith<$Res> {
  _$NotionOAuthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotionOAuth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotionOAuthImplCopyWith<$Res>
    implements $NotionOAuthCopyWith<$Res> {
  factory _$$NotionOAuthImplCopyWith(
          _$NotionOAuthImpl value, $Res Function(_$NotionOAuthImpl) then) =
      __$$NotionOAuthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? accessToken});
}

/// @nodoc
class __$$NotionOAuthImplCopyWithImpl<$Res>
    extends _$NotionOAuthCopyWithImpl<$Res, _$NotionOAuthImpl>
    implements _$$NotionOAuthImplCopyWith<$Res> {
  __$$NotionOAuthImplCopyWithImpl(
      _$NotionOAuthImpl _value, $Res Function(_$NotionOAuthImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotionOAuth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
  }) {
    return _then(_$NotionOAuthImpl(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NotionOAuthImpl extends _NotionOAuth {
  const _$NotionOAuthImpl({required this.accessToken}) : super._();

  @override
  final String? accessToken;

  @override
  String toString() {
    return 'NotionOAuth(accessToken: $accessToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotionOAuthImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accessToken);

  /// Create a copy of NotionOAuth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotionOAuthImplCopyWith<_$NotionOAuthImpl> get copyWith =>
      __$$NotionOAuthImplCopyWithImpl<_$NotionOAuthImpl>(this, _$identity);
}

abstract class _NotionOAuth extends NotionOAuth {
  const factory _NotionOAuth({required final String? accessToken}) =
      _$NotionOAuthImpl;
  const _NotionOAuth._() : super._();

  @override
  String? get accessToken;

  /// Create a copy of NotionOAuth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotionOAuthImplCopyWith<_$NotionOAuthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
