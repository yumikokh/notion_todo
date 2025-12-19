// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notion_oauth_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotionOAuth {

 String? get accessToken;
/// Create a copy of NotionOAuth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotionOAuthCopyWith<NotionOAuth> get copyWith => _$NotionOAuthCopyWithImpl<NotionOAuth>(this as NotionOAuth, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotionOAuth&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken));
}


@override
int get hashCode => Object.hash(runtimeType,accessToken);

@override
String toString() {
  return 'NotionOAuth(accessToken: $accessToken)';
}


}

/// @nodoc
abstract mixin class $NotionOAuthCopyWith<$Res>  {
  factory $NotionOAuthCopyWith(NotionOAuth value, $Res Function(NotionOAuth) _then) = _$NotionOAuthCopyWithImpl;
@useResult
$Res call({
 String? accessToken
});




}
/// @nodoc
class _$NotionOAuthCopyWithImpl<$Res>
    implements $NotionOAuthCopyWith<$Res> {
  _$NotionOAuthCopyWithImpl(this._self, this._then);

  final NotionOAuth _self;
  final $Res Function(NotionOAuth) _then;

/// Create a copy of NotionOAuth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = freezed,}) {
  return _then(_self.copyWith(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotionOAuth].
extension NotionOAuthPatterns on NotionOAuth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotionOAuth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotionOAuth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotionOAuth value)  $default,){
final _that = this;
switch (_that) {
case _NotionOAuth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotionOAuth value)?  $default,){
final _that = this;
switch (_that) {
case _NotionOAuth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? accessToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotionOAuth() when $default != null:
return $default(_that.accessToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? accessToken)  $default,) {final _that = this;
switch (_that) {
case _NotionOAuth():
return $default(_that.accessToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? accessToken)?  $default,) {final _that = this;
switch (_that) {
case _NotionOAuth() when $default != null:
return $default(_that.accessToken);case _:
  return null;

}
}

}

/// @nodoc


class _NotionOAuth extends NotionOAuth {
  const _NotionOAuth({required this.accessToken}): super._();
  

@override final  String? accessToken;

/// Create a copy of NotionOAuth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotionOAuthCopyWith<_NotionOAuth> get copyWith => __$NotionOAuthCopyWithImpl<_NotionOAuth>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotionOAuth&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken));
}


@override
int get hashCode => Object.hash(runtimeType,accessToken);

@override
String toString() {
  return 'NotionOAuth(accessToken: $accessToken)';
}


}

/// @nodoc
abstract mixin class _$NotionOAuthCopyWith<$Res> implements $NotionOAuthCopyWith<$Res> {
  factory _$NotionOAuthCopyWith(_NotionOAuth value, $Res Function(_NotionOAuth) _then) = __$NotionOAuthCopyWithImpl;
@override @useResult
$Res call({
 String? accessToken
});




}
/// @nodoc
class __$NotionOAuthCopyWithImpl<$Res>
    implements _$NotionOAuthCopyWith<$Res> {
  __$NotionOAuthCopyWithImpl(this._self, this._then);

  final _NotionOAuth _self;
  final $Res Function(_NotionOAuth) _then;

/// Create a copy of NotionOAuth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = freezed,}) {
  return _then(_NotionOAuth(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
