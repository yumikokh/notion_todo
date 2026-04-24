// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snackbar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SnackbarState {

 String get message; SnackbarType get type; VoidCallback? get onUndo; bool get isFloating;
/// Create a copy of SnackbarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnackbarStateCopyWith<SnackbarState> get copyWith => _$SnackbarStateCopyWithImpl<SnackbarState>(this as SnackbarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnackbarState&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.onUndo, onUndo) || other.onUndo == onUndo)&&(identical(other.isFloating, isFloating) || other.isFloating == isFloating));
}


@override
int get hashCode => Object.hash(runtimeType,message,type,onUndo,isFloating);

@override
String toString() {
  return 'SnackbarState(message: $message, type: $type, onUndo: $onUndo, isFloating: $isFloating)';
}


}

/// @nodoc
abstract mixin class $SnackbarStateCopyWith<$Res>  {
  factory $SnackbarStateCopyWith(SnackbarState value, $Res Function(SnackbarState) _then) = _$SnackbarStateCopyWithImpl;
@useResult
$Res call({
 String message, SnackbarType type, VoidCallback? onUndo, bool isFloating
});




}
/// @nodoc
class _$SnackbarStateCopyWithImpl<$Res>
    implements $SnackbarStateCopyWith<$Res> {
  _$SnackbarStateCopyWithImpl(this._self, this._then);

  final SnackbarState _self;
  final $Res Function(SnackbarState) _then;

/// Create a copy of SnackbarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? type = null,Object? onUndo = freezed,Object? isFloating = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SnackbarType,onUndo: freezed == onUndo ? _self.onUndo : onUndo // ignore: cast_nullable_to_non_nullable
as VoidCallback?,isFloating: null == isFloating ? _self.isFloating : isFloating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SnackbarState].
extension SnackbarStatePatterns on SnackbarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SnackbarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SnackbarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SnackbarState value)  $default,){
final _that = this;
switch (_that) {
case _SnackbarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SnackbarState value)?  $default,){
final _that = this;
switch (_that) {
case _SnackbarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  SnackbarType type,  VoidCallback? onUndo,  bool isFloating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SnackbarState() when $default != null:
return $default(_that.message,_that.type,_that.onUndo,_that.isFloating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  SnackbarType type,  VoidCallback? onUndo,  bool isFloating)  $default,) {final _that = this;
switch (_that) {
case _SnackbarState():
return $default(_that.message,_that.type,_that.onUndo,_that.isFloating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  SnackbarType type,  VoidCallback? onUndo,  bool isFloating)?  $default,) {final _that = this;
switch (_that) {
case _SnackbarState() when $default != null:
return $default(_that.message,_that.type,_that.onUndo,_that.isFloating);case _:
  return null;

}
}

}

/// @nodoc


class _SnackbarState implements SnackbarState {
  const _SnackbarState({required this.message, this.type = SnackbarType.info, this.onUndo, this.isFloating = false});
  

@override final  String message;
@override@JsonKey() final  SnackbarType type;
@override final  VoidCallback? onUndo;
@override@JsonKey() final  bool isFloating;

/// Create a copy of SnackbarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SnackbarStateCopyWith<_SnackbarState> get copyWith => __$SnackbarStateCopyWithImpl<_SnackbarState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SnackbarState&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.onUndo, onUndo) || other.onUndo == onUndo)&&(identical(other.isFloating, isFloating) || other.isFloating == isFloating));
}


@override
int get hashCode => Object.hash(runtimeType,message,type,onUndo,isFloating);

@override
String toString() {
  return 'SnackbarState(message: $message, type: $type, onUndo: $onUndo, isFloating: $isFloating)';
}


}

/// @nodoc
abstract mixin class _$SnackbarStateCopyWith<$Res> implements $SnackbarStateCopyWith<$Res> {
  factory _$SnackbarStateCopyWith(_SnackbarState value, $Res Function(_SnackbarState) _then) = __$SnackbarStateCopyWithImpl;
@override @useResult
$Res call({
 String message, SnackbarType type, VoidCallback? onUndo, bool isFloating
});




}
/// @nodoc
class __$SnackbarStateCopyWithImpl<$Res>
    implements _$SnackbarStateCopyWith<$Res> {
  __$SnackbarStateCopyWithImpl(this._self, this._then);

  final _SnackbarState _self;
  final $Res Function(_SnackbarState) _then;

/// Create a copy of SnackbarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? type = null,Object? onUndo = freezed,Object? isFloating = null,}) {
  return _then(_SnackbarState(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SnackbarType,onUndo: freezed == onUndo ? _self.onUndo : onUndo // ignore: cast_nullable_to_non_nullable
as VoidCallback?,isFloating: null == isFloating ? _self.isFloating : isFloating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
