// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_database_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskDatabase _$TaskDatabaseFromJson(Map<String, dynamic> json) {
  return _SelectedTaskDatabase.fromJson(json);
}

/// @nodoc
mixin _$TaskDatabase {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Property? get status => throw _privateConstructorUsedError;
  Property? get date => throw _privateConstructorUsedError;

  /// Serializes this TaskDatabase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskDatabase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskDatabaseCopyWith<TaskDatabase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDatabaseCopyWith<$Res> {
  factory $TaskDatabaseCopyWith(
          TaskDatabase value, $Res Function(TaskDatabase) then) =
      _$TaskDatabaseCopyWithImpl<$Res, TaskDatabase>;
  @useResult
  $Res call({String id, String name, Property? status, Property? date});

  $PropertyCopyWith<$Res>? get status;
  $PropertyCopyWith<$Res>? get date;
}

/// @nodoc
class _$TaskDatabaseCopyWithImpl<$Res, $Val extends TaskDatabase>
    implements $TaskDatabaseCopyWith<$Res> {
  _$TaskDatabaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskDatabase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = freezed,
    Object? date = freezed,
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Property?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as Property?,
    ) as $Val);
  }

  /// Create a copy of TaskDatabase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PropertyCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $PropertyCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of TaskDatabase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PropertyCopyWith<$Res>? get date {
    if (_value.date == null) {
      return null;
    }

    return $PropertyCopyWith<$Res>(_value.date!, (value) {
      return _then(_value.copyWith(date: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SelectedTaskDatabaseImplCopyWith<$Res>
    implements $TaskDatabaseCopyWith<$Res> {
  factory _$$SelectedTaskDatabaseImplCopyWith(_$SelectedTaskDatabaseImpl value,
          $Res Function(_$SelectedTaskDatabaseImpl) then) =
      __$$SelectedTaskDatabaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, Property? status, Property? date});

  @override
  $PropertyCopyWith<$Res>? get status;
  @override
  $PropertyCopyWith<$Res>? get date;
}

/// @nodoc
class __$$SelectedTaskDatabaseImplCopyWithImpl<$Res>
    extends _$TaskDatabaseCopyWithImpl<$Res, _$SelectedTaskDatabaseImpl>
    implements _$$SelectedTaskDatabaseImplCopyWith<$Res> {
  __$$SelectedTaskDatabaseImplCopyWithImpl(_$SelectedTaskDatabaseImpl _value,
      $Res Function(_$SelectedTaskDatabaseImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskDatabase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = freezed,
    Object? date = freezed,
  }) {
    return _then(_$SelectedTaskDatabaseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Property?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as Property?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectedTaskDatabaseImpl implements _SelectedTaskDatabase {
  const _$SelectedTaskDatabaseImpl(
      {required this.id,
      required this.name,
      required this.status,
      required this.date});

  factory _$SelectedTaskDatabaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectedTaskDatabaseImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final Property? status;
  @override
  final Property? date;

  @override
  String toString() {
    return 'TaskDatabase(id: $id, name: $name, status: $status, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedTaskDatabaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, status, date);

  /// Create a copy of TaskDatabase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedTaskDatabaseImplCopyWith<_$SelectedTaskDatabaseImpl>
      get copyWith =>
          __$$SelectedTaskDatabaseImplCopyWithImpl<_$SelectedTaskDatabaseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SelectedTaskDatabaseImplToJson(
      this,
    );
  }
}

abstract class _SelectedTaskDatabase implements TaskDatabase {
  const factory _SelectedTaskDatabase(
      {required final String id,
      required final String name,
      required final Property? status,
      required final Property? date}) = _$SelectedTaskDatabaseImpl;

  factory _SelectedTaskDatabase.fromJson(Map<String, dynamic> json) =
      _$SelectedTaskDatabaseImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  Property? get status;
  @override
  Property? get date;

  /// Create a copy of TaskDatabase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedTaskDatabaseImplCopyWith<_$SelectedTaskDatabaseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
