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
  List<Property> get properties => throw _privateConstructorUsedError;
  String? get statusId => throw _privateConstructorUsedError;
  String? get dateId => throw _privateConstructorUsedError;

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
  $Res call(
      {String id,
      String name,
      List<Property> properties,
      String? statusId,
      String? dateId});
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
    Object? properties = null,
    Object? statusId = freezed,
    Object? dateId = freezed,
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
      statusId: freezed == statusId
          ? _value.statusId
          : statusId // ignore: cast_nullable_to_non_nullable
              as String?,
      dateId: freezed == dateId
          ? _value.dateId
          : dateId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
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
  $Res call(
      {String id,
      String name,
      List<Property> properties,
      String? statusId,
      String? dateId});
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
    Object? properties = null,
    Object? statusId = freezed,
    Object? dateId = freezed,
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
      properties: null == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<Property>,
      statusId: freezed == statusId
          ? _value.statusId
          : statusId // ignore: cast_nullable_to_non_nullable
              as String?,
      dateId: freezed == dateId
          ? _value.dateId
          : dateId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectedTaskDatabaseImpl implements _SelectedTaskDatabase {
  const _$SelectedTaskDatabaseImpl(
      {required this.id,
      required this.name,
      required final List<Property> properties,
      required this.statusId,
      required this.dateId})
      : _properties = properties;

  factory _$SelectedTaskDatabaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectedTaskDatabaseImplFromJson(json);

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
  final String? statusId;
  @override
  final String? dateId;

  @override
  String toString() {
    return 'TaskDatabase(id: $id, name: $name, properties: $properties, statusId: $statusId, dateId: $dateId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedTaskDatabaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties) &&
            (identical(other.statusId, statusId) ||
                other.statusId == statusId) &&
            (identical(other.dateId, dateId) || other.dateId == dateId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name,
      const DeepCollectionEquality().hash(_properties), statusId, dateId);

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
      required final List<Property> properties,
      required final String? statusId,
      required final String? dateId}) = _$SelectedTaskDatabaseImpl;

  factory _SelectedTaskDatabase.fromJson(Map<String, dynamic> json) =
      _$SelectedTaskDatabaseImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<Property> get properties;
  @override
  String? get statusId;
  @override
  String? get dateId;

  /// Create a copy of TaskDatabase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedTaskDatabaseImplCopyWith<_$SelectedTaskDatabaseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
