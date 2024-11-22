// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snackbar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SnackbarState {
  String get message => throw _privateConstructorUsedError;
  SnackbarType get type => throw _privateConstructorUsedError;
  VoidCallback? get onUndo => throw _privateConstructorUsedError;

  /// Create a copy of SnackbarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnackbarStateCopyWith<SnackbarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnackbarStateCopyWith<$Res> {
  factory $SnackbarStateCopyWith(
          SnackbarState value, $Res Function(SnackbarState) then) =
      _$SnackbarStateCopyWithImpl<$Res, SnackbarState>;
  @useResult
  $Res call({String message, SnackbarType type, VoidCallback? onUndo});
}

/// @nodoc
class _$SnackbarStateCopyWithImpl<$Res, $Val extends SnackbarState>
    implements $SnackbarStateCopyWith<$Res> {
  _$SnackbarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnackbarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
    Object? onUndo = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SnackbarType,
      onUndo: freezed == onUndo
          ? _value.onUndo
          : onUndo // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnackbarStateImplCopyWith<$Res>
    implements $SnackbarStateCopyWith<$Res> {
  factory _$$SnackbarStateImplCopyWith(
          _$SnackbarStateImpl value, $Res Function(_$SnackbarStateImpl) then) =
      __$$SnackbarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, SnackbarType type, VoidCallback? onUndo});
}

/// @nodoc
class __$$SnackbarStateImplCopyWithImpl<$Res>
    extends _$SnackbarStateCopyWithImpl<$Res, _$SnackbarStateImpl>
    implements _$$SnackbarStateImplCopyWith<$Res> {
  __$$SnackbarStateImplCopyWithImpl(
      _$SnackbarStateImpl _value, $Res Function(_$SnackbarStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnackbarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
    Object? onUndo = freezed,
  }) {
    return _then(_$SnackbarStateImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SnackbarType,
      onUndo: freezed == onUndo
          ? _value.onUndo
          : onUndo // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
    ));
  }
}

/// @nodoc

class _$SnackbarStateImpl implements _SnackbarState {
  const _$SnackbarStateImpl(
      {required this.message, this.type = SnackbarType.info, this.onUndo});

  @override
  final String message;
  @override
  @JsonKey()
  final SnackbarType type;
  @override
  final VoidCallback? onUndo;

  @override
  String toString() {
    return 'SnackbarState(message: $message, type: $type, onUndo: $onUndo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnackbarStateImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.onUndo, onUndo) || other.onUndo == onUndo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, type, onUndo);

  /// Create a copy of SnackbarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnackbarStateImplCopyWith<_$SnackbarStateImpl> get copyWith =>
      __$$SnackbarStateImplCopyWithImpl<_$SnackbarStateImpl>(this, _$identity);
}

abstract class _SnackbarState implements SnackbarState {
  const factory _SnackbarState(
      {required final String message,
      final SnackbarType type,
      final VoidCallback? onUndo}) = _$SnackbarStateImpl;

  @override
  String get message;
  @override
  SnackbarType get type;
  @override
  VoidCallback? get onUndo;

  /// Create a copy of SnackbarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnackbarStateImplCopyWith<_$SnackbarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
