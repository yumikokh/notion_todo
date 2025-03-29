// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_database_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectedDatabaseState {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  TitleProperty get title => throw _privateConstructorUsedError;
  CompleteStatusProperty? get status => throw _privateConstructorUsedError;
  DateProperty? get date => throw _privateConstructorUsedError;
  StatusCompleteStatusProperty? get priority =>
      throw _privateConstructorUsedError;

  /// Create a copy of SelectedDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectedDatabaseStateCopyWith<SelectedDatabaseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedDatabaseStateCopyWith<$Res> {
  factory $SelectedDatabaseStateCopyWith(SelectedDatabaseState value,
          $Res Function(SelectedDatabaseState) then) =
      _$SelectedDatabaseStateCopyWithImpl<$Res, SelectedDatabaseState>;
  @useResult
  $Res call(
      {String id,
      String name,
      TitleProperty title,
      CompleteStatusProperty? status,
      DateProperty? date,
      StatusCompleteStatusProperty? priority});
}

/// @nodoc
class _$SelectedDatabaseStateCopyWithImpl<$Res,
        $Val extends SelectedDatabaseState>
    implements $SelectedDatabaseStateCopyWith<$Res> {
  _$SelectedDatabaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectedDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = null,
    Object? status = freezed,
    Object? date = freezed,
    Object? priority = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as TitleProperty,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CompleteStatusProperty?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateProperty?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as StatusCompleteStatusProperty?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectedDatabaseStateImplCopyWith<$Res>
    implements $SelectedDatabaseStateCopyWith<$Res> {
  factory _$$SelectedDatabaseStateImplCopyWith(
          _$SelectedDatabaseStateImpl value,
          $Res Function(_$SelectedDatabaseStateImpl) then) =
      __$$SelectedDatabaseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      TitleProperty title,
      CompleteStatusProperty? status,
      DateProperty? date,
      StatusCompleteStatusProperty? priority});
}

/// @nodoc
class __$$SelectedDatabaseStateImplCopyWithImpl<$Res>
    extends _$SelectedDatabaseStateCopyWithImpl<$Res,
        _$SelectedDatabaseStateImpl>
    implements _$$SelectedDatabaseStateImplCopyWith<$Res> {
  __$$SelectedDatabaseStateImplCopyWithImpl(_$SelectedDatabaseStateImpl _value,
      $Res Function(_$SelectedDatabaseStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectedDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = null,
    Object? status = freezed,
    Object? date = freezed,
    Object? priority = freezed,
  }) {
    return _then(_$SelectedDatabaseStateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as TitleProperty,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CompleteStatusProperty?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateProperty?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as StatusCompleteStatusProperty?,
    ));
  }
}

/// @nodoc

class _$SelectedDatabaseStateImpl
    with DiagnosticableTreeMixin
    implements _SelectedDatabaseState {
  const _$SelectedDatabaseStateImpl(
      {required this.id,
      required this.name,
      required this.title,
      required this.status,
      required this.date,
      this.priority});

  @override
  final String id;
  @override
  final String name;
  @override
  final TitleProperty title;
  @override
  final CompleteStatusProperty? status;
  @override
  final DateProperty? date;
  @override
  final StatusCompleteStatusProperty? priority;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectedDatabaseState(id: $id, name: $name, title: $title, status: $status, date: $date, priority: $priority)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectedDatabaseState'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('priority', priority));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedDatabaseStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, title, status, date, priority);

  /// Create a copy of SelectedDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedDatabaseStateImplCopyWith<_$SelectedDatabaseStateImpl>
      get copyWith => __$$SelectedDatabaseStateImplCopyWithImpl<
          _$SelectedDatabaseStateImpl>(this, _$identity);
}

abstract class _SelectedDatabaseState implements SelectedDatabaseState {
  const factory _SelectedDatabaseState(
          {required final String id,
          required final String name,
          required final TitleProperty title,
          required final CompleteStatusProperty? status,
          required final DateProperty? date,
          final StatusCompleteStatusProperty? priority}) =
      _$SelectedDatabaseStateImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  TitleProperty get title;
  @override
  CompleteStatusProperty? get status;
  @override
  DateProperty? get date;
  @override
  StatusCompleteStatusProperty? get priority;

  /// Create a copy of SelectedDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedDatabaseStateImplCopyWith<_$SelectedDatabaseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
