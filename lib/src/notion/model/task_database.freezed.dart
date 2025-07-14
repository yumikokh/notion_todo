// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_database.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskDatabase _$TaskDatabaseFromJson(Map<String, dynamic> json) {
  return _TaskDatabase.fromJson(json);
}

/// @nodoc
mixin _$TaskDatabase {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  TitleProperty get title => throw _privateConstructorUsedError;
  CompleteStatusProperty get status => throw _privateConstructorUsedError;
  DateProperty get date => throw _privateConstructorUsedError;
  SelectProperty? get priority => throw _privateConstructorUsedError;
  RelationProperty? get project =>
      throw _privateConstructorUsedError; // その他のプロパティ（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: Property（任意のPropertyタイプ）
  @JsonKey(defaultValue: {})
  Map<String, Property>? get additionalProperties =>
      throw _privateConstructorUsedError;

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
      TitleProperty title,
      CompleteStatusProperty status,
      DateProperty date,
      SelectProperty? priority,
      RelationProperty? project,
      @JsonKey(defaultValue: {}) Map<String, Property>? additionalProperties});
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
    Object? title = null,
    Object? status = null,
    Object? date = null,
    Object? priority = freezed,
    Object? project = freezed,
    Object? additionalProperties = freezed,
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CompleteStatusProperty,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateProperty,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as SelectProperty?,
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as RelationProperty?,
      additionalProperties: freezed == additionalProperties
          ? _value.additionalProperties
          : additionalProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, Property>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskDatabaseImplCopyWith<$Res>
    implements $TaskDatabaseCopyWith<$Res> {
  factory _$$TaskDatabaseImplCopyWith(
          _$TaskDatabaseImpl value, $Res Function(_$TaskDatabaseImpl) then) =
      __$$TaskDatabaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      TitleProperty title,
      CompleteStatusProperty status,
      DateProperty date,
      SelectProperty? priority,
      RelationProperty? project,
      @JsonKey(defaultValue: {}) Map<String, Property>? additionalProperties});
}

/// @nodoc
class __$$TaskDatabaseImplCopyWithImpl<$Res>
    extends _$TaskDatabaseCopyWithImpl<$Res, _$TaskDatabaseImpl>
    implements _$$TaskDatabaseImplCopyWith<$Res> {
  __$$TaskDatabaseImplCopyWithImpl(
      _$TaskDatabaseImpl _value, $Res Function(_$TaskDatabaseImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskDatabase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = null,
    Object? status = null,
    Object? date = null,
    Object? priority = freezed,
    Object? project = freezed,
    Object? additionalProperties = freezed,
  }) {
    return _then(_$TaskDatabaseImpl(
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CompleteStatusProperty,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateProperty,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as SelectProperty?,
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as RelationProperty?,
      additionalProperties: freezed == additionalProperties
          ? _value._additionalProperties
          : additionalProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, Property>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TaskDatabaseImpl implements _TaskDatabase {
  const _$TaskDatabaseImpl(
      {required this.id,
      required this.name,
      required this.title,
      required this.status,
      required this.date,
      this.priority,
      this.project,
      @JsonKey(defaultValue: {})
      final Map<String, Property>? additionalProperties})
      : _additionalProperties = additionalProperties;

  factory _$TaskDatabaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskDatabaseImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final TitleProperty title;
  @override
  final CompleteStatusProperty status;
  @override
  final DateProperty date;
  @override
  final SelectProperty? priority;
  @override
  final RelationProperty? project;
// その他のプロパティ（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: Property（任意のPropertyタイプ）
  final Map<String, Property>? _additionalProperties;
// その他のプロパティ（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: Property（任意のPropertyタイプ）
  @override
  @JsonKey(defaultValue: {})
  Map<String, Property>? get additionalProperties {
    final value = _additionalProperties;
    if (value == null) return null;
    if (_additionalProperties is EqualUnmodifiableMapView)
      return _additionalProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'TaskDatabase(id: $id, name: $name, title: $title, status: $status, date: $date, priority: $priority, project: $project, additionalProperties: $additionalProperties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskDatabaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.project, project) || other.project == project) &&
            const DeepCollectionEquality()
                .equals(other._additionalProperties, _additionalProperties));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      title,
      status,
      date,
      priority,
      project,
      const DeepCollectionEquality().hash(_additionalProperties));

  /// Create a copy of TaskDatabase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDatabaseImplCopyWith<_$TaskDatabaseImpl> get copyWith =>
      __$$TaskDatabaseImplCopyWithImpl<_$TaskDatabaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskDatabaseImplToJson(
      this,
    );
  }
}

abstract class _TaskDatabase implements TaskDatabase {
  const factory _TaskDatabase(
      {required final String id,
      required final String name,
      required final TitleProperty title,
      required final CompleteStatusProperty status,
      required final DateProperty date,
      final SelectProperty? priority,
      final RelationProperty? project,
      @JsonKey(defaultValue: {})
      final Map<String, Property>? additionalProperties}) = _$TaskDatabaseImpl;

  factory _TaskDatabase.fromJson(Map<String, dynamic> json) =
      _$TaskDatabaseImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  TitleProperty get title;
  @override
  CompleteStatusProperty get status;
  @override
  DateProperty get date;
  @override
  SelectProperty? get priority;
  @override
  RelationProperty? get project; // その他のプロパティ（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: Property（任意のPropertyタイプ）
  @override
  @JsonKey(defaultValue: {})
  Map<String, Property>? get additionalProperties;

  /// Create a copy of TaskDatabase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskDatabaseImplCopyWith<_$TaskDatabaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
