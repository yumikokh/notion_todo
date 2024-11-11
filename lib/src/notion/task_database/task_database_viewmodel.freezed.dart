// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_database_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaskDatabaseState {
  List<Database> get databases => throw _privateConstructorUsedError;
  TaskDatabase? get taskDatabase => throw _privateConstructorUsedError;
  TaskDatabase? get selectedTaskDatabase => throw _privateConstructorUsedError;

  /// Create a copy of TaskDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskDatabaseStateCopyWith<TaskDatabaseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDatabaseStateCopyWith<$Res> {
  factory $TaskDatabaseStateCopyWith(
          TaskDatabaseState value, $Res Function(TaskDatabaseState) then) =
      _$TaskDatabaseStateCopyWithImpl<$Res, TaskDatabaseState>;
  @useResult
  $Res call(
      {List<Database> databases,
      TaskDatabase? taskDatabase,
      TaskDatabase? selectedTaskDatabase});

  $TaskDatabaseCopyWith<$Res>? get taskDatabase;
  $TaskDatabaseCopyWith<$Res>? get selectedTaskDatabase;
}

/// @nodoc
class _$TaskDatabaseStateCopyWithImpl<$Res, $Val extends TaskDatabaseState>
    implements $TaskDatabaseStateCopyWith<$Res> {
  _$TaskDatabaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? databases = null,
    Object? taskDatabase = freezed,
    Object? selectedTaskDatabase = freezed,
  }) {
    return _then(_value.copyWith(
      databases: null == databases
          ? _value.databases
          : databases // ignore: cast_nullable_to_non_nullable
              as List<Database>,
      taskDatabase: freezed == taskDatabase
          ? _value.taskDatabase
          : taskDatabase // ignore: cast_nullable_to_non_nullable
              as TaskDatabase?,
      selectedTaskDatabase: freezed == selectedTaskDatabase
          ? _value.selectedTaskDatabase
          : selectedTaskDatabase // ignore: cast_nullable_to_non_nullable
              as TaskDatabase?,
    ) as $Val);
  }

  /// Create a copy of TaskDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskDatabaseCopyWith<$Res>? get taskDatabase {
    if (_value.taskDatabase == null) {
      return null;
    }

    return $TaskDatabaseCopyWith<$Res>(_value.taskDatabase!, (value) {
      return _then(_value.copyWith(taskDatabase: value) as $Val);
    });
  }

  /// Create a copy of TaskDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskDatabaseCopyWith<$Res>? get selectedTaskDatabase {
    if (_value.selectedTaskDatabase == null) {
      return null;
    }

    return $TaskDatabaseCopyWith<$Res>(_value.selectedTaskDatabase!, (value) {
      return _then(_value.copyWith(selectedTaskDatabase: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskDatabaseStateImplCopyWith<$Res>
    implements $TaskDatabaseStateCopyWith<$Res> {
  factory _$$TaskDatabaseStateImplCopyWith(_$TaskDatabaseStateImpl value,
          $Res Function(_$TaskDatabaseStateImpl) then) =
      __$$TaskDatabaseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Database> databases,
      TaskDatabase? taskDatabase,
      TaskDatabase? selectedTaskDatabase});

  @override
  $TaskDatabaseCopyWith<$Res>? get taskDatabase;
  @override
  $TaskDatabaseCopyWith<$Res>? get selectedTaskDatabase;
}

/// @nodoc
class __$$TaskDatabaseStateImplCopyWithImpl<$Res>
    extends _$TaskDatabaseStateCopyWithImpl<$Res, _$TaskDatabaseStateImpl>
    implements _$$TaskDatabaseStateImplCopyWith<$Res> {
  __$$TaskDatabaseStateImplCopyWithImpl(_$TaskDatabaseStateImpl _value,
      $Res Function(_$TaskDatabaseStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? databases = null,
    Object? taskDatabase = freezed,
    Object? selectedTaskDatabase = freezed,
  }) {
    return _then(_$TaskDatabaseStateImpl(
      databases: null == databases
          ? _value._databases
          : databases // ignore: cast_nullable_to_non_nullable
              as List<Database>,
      taskDatabase: freezed == taskDatabase
          ? _value.taskDatabase
          : taskDatabase // ignore: cast_nullable_to_non_nullable
              as TaskDatabase?,
      selectedTaskDatabase: freezed == selectedTaskDatabase
          ? _value.selectedTaskDatabase
          : selectedTaskDatabase // ignore: cast_nullable_to_non_nullable
              as TaskDatabase?,
    ));
  }
}

/// @nodoc

class _$TaskDatabaseStateImpl
    with DiagnosticableTreeMixin
    implements _TaskDatabaseState {
  _$TaskDatabaseStateImpl(
      {required final List<Database> databases,
      required this.taskDatabase,
      required this.selectedTaskDatabase})
      : _databases = databases;

  final List<Database> _databases;
  @override
  List<Database> get databases {
    if (_databases is EqualUnmodifiableListView) return _databases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_databases);
  }

  @override
  final TaskDatabase? taskDatabase;
  @override
  final TaskDatabase? selectedTaskDatabase;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TaskDatabaseState(databases: $databases, taskDatabase: $taskDatabase, selectedTaskDatabase: $selectedTaskDatabase)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TaskDatabaseState'))
      ..add(DiagnosticsProperty('databases', databases))
      ..add(DiagnosticsProperty('taskDatabase', taskDatabase))
      ..add(DiagnosticsProperty('selectedTaskDatabase', selectedTaskDatabase));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskDatabaseStateImpl &&
            const DeepCollectionEquality()
                .equals(other._databases, _databases) &&
            (identical(other.taskDatabase, taskDatabase) ||
                other.taskDatabase == taskDatabase) &&
            (identical(other.selectedTaskDatabase, selectedTaskDatabase) ||
                other.selectedTaskDatabase == selectedTaskDatabase));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_databases),
      taskDatabase,
      selectedTaskDatabase);

  /// Create a copy of TaskDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDatabaseStateImplCopyWith<_$TaskDatabaseStateImpl> get copyWith =>
      __$$TaskDatabaseStateImplCopyWithImpl<_$TaskDatabaseStateImpl>(
          this, _$identity);
}

abstract class _TaskDatabaseState implements TaskDatabaseState {
  factory _TaskDatabaseState(
          {required final List<Database> databases,
          required final TaskDatabase? taskDatabase,
          required final TaskDatabase? selectedTaskDatabase}) =
      _$TaskDatabaseStateImpl;

  @override
  List<Database> get databases;
  @override
  TaskDatabase? get taskDatabase;
  @override
  TaskDatabase? get selectedTaskDatabase;

  /// Create a copy of TaskDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskDatabaseStateImplCopyWith<_$TaskDatabaseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
