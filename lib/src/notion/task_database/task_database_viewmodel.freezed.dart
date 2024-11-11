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
mixin _$SelectedDatabase {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<Property> get properties => throw _privateConstructorUsedError;
  Property? get status => throw _privateConstructorUsedError;
  Property? get date => throw _privateConstructorUsedError;

  /// Create a copy of SelectedDatabase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectedDatabaseCopyWith<SelectedDatabase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedDatabaseCopyWith<$Res> {
  factory $SelectedDatabaseCopyWith(
          SelectedDatabase value, $Res Function(SelectedDatabase) then) =
      _$SelectedDatabaseCopyWithImpl<$Res, SelectedDatabase>;
  @useResult
  $Res call(
      {String id,
      String name,
      List<Property> properties,
      Property? status,
      Property? date});

  $PropertyCopyWith<$Res>? get status;
  $PropertyCopyWith<$Res>? get date;
}

/// @nodoc
class _$SelectedDatabaseCopyWithImpl<$Res, $Val extends SelectedDatabase>
    implements $SelectedDatabaseCopyWith<$Res> {
  _$SelectedDatabaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectedDatabase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? properties = null,
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
      properties: null == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<Property>,
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

  /// Create a copy of SelectedDatabase
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

  /// Create a copy of SelectedDatabase
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
abstract class _$$SelectedDatabaseImplCopyWith<$Res>
    implements $SelectedDatabaseCopyWith<$Res> {
  factory _$$SelectedDatabaseImplCopyWith(_$SelectedDatabaseImpl value,
          $Res Function(_$SelectedDatabaseImpl) then) =
      __$$SelectedDatabaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<Property> properties,
      Property? status,
      Property? date});

  @override
  $PropertyCopyWith<$Res>? get status;
  @override
  $PropertyCopyWith<$Res>? get date;
}

/// @nodoc
class __$$SelectedDatabaseImplCopyWithImpl<$Res>
    extends _$SelectedDatabaseCopyWithImpl<$Res, _$SelectedDatabaseImpl>
    implements _$$SelectedDatabaseImplCopyWith<$Res> {
  __$$SelectedDatabaseImplCopyWithImpl(_$SelectedDatabaseImpl _value,
      $Res Function(_$SelectedDatabaseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectedDatabase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? properties = null,
    Object? status = freezed,
    Object? date = freezed,
  }) {
    return _then(_$SelectedDatabaseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<Property>,
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

class _$SelectedDatabaseImpl
    with DiagnosticableTreeMixin
    implements _SelectedDatabase {
  const _$SelectedDatabaseImpl(
      {required this.id,
      required this.name,
      required final List<Property> properties,
      required this.status,
      required this.date})
      : _properties = properties;

  @override
  final String id;
  @override
  final String name;
  final List<Property> _properties;
  @override
  List<Property> get properties {
    if (_properties is EqualUnmodifiableListView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_properties);
  }

  @override
  final Property? status;
  @override
  final Property? date;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectedDatabase(id: $id, name: $name, properties: $properties, status: $status, date: $date)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectedDatabase'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('properties', properties))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('date', date));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedDatabaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name,
      const DeepCollectionEquality().hash(_properties), status, date);

  /// Create a copy of SelectedDatabase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedDatabaseImplCopyWith<_$SelectedDatabaseImpl> get copyWith =>
      __$$SelectedDatabaseImplCopyWithImpl<_$SelectedDatabaseImpl>(
          this, _$identity);
}

abstract class _SelectedDatabase implements SelectedDatabase {
  const factory _SelectedDatabase(
      {required final String id,
      required final String name,
      required final List<Property> properties,
      required final Property? status,
      required final Property? date}) = _$SelectedDatabaseImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  List<Property> get properties;
  @override
  Property? get status;
  @override
  Property? get date;

  /// Create a copy of SelectedDatabase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedDatabaseImplCopyWith<_$SelectedDatabaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TaskDatabaseState {
  List<Database> get databases => throw _privateConstructorUsedError;
  TaskDatabase? get taskDatabase => throw _privateConstructorUsedError;
  SelectedDatabase? get selectedTaskDatabase =>
      throw _privateConstructorUsedError;

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
      SelectedDatabase? selectedTaskDatabase});

  $TaskDatabaseCopyWith<$Res>? get taskDatabase;
  $SelectedDatabaseCopyWith<$Res>? get selectedTaskDatabase;
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
              as SelectedDatabase?,
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
  $SelectedDatabaseCopyWith<$Res>? get selectedTaskDatabase {
    if (_value.selectedTaskDatabase == null) {
      return null;
    }

    return $SelectedDatabaseCopyWith<$Res>(_value.selectedTaskDatabase!,
        (value) {
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
      SelectedDatabase? selectedTaskDatabase});

  @override
  $TaskDatabaseCopyWith<$Res>? get taskDatabase;
  @override
  $SelectedDatabaseCopyWith<$Res>? get selectedTaskDatabase;
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
              as SelectedDatabase?,
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
  final SelectedDatabase? selectedTaskDatabase;

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
          required final SelectedDatabase? selectedTaskDatabase}) =
      _$TaskDatabaseStateImpl;

  @override
  List<Database> get databases;
  @override
  TaskDatabase? get taskDatabase;
  @override
  SelectedDatabase? get selectedTaskDatabase;

  /// Create a copy of TaskDatabaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskDatabaseStateImplCopyWith<_$TaskDatabaseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
