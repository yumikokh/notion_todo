// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskDate _$TaskDateFromJson(Map<String, dynamic> json) {
  return _TaskDate.fromJson(json);
}

/// @nodoc
mixin _$TaskDate {
  String get start =>
      throw _privateConstructorUsedError; // TODO: DateTimeにして、時間指定があるかのフラグを追加する
  String? get end => throw _privateConstructorUsedError;

  /// Serializes this TaskDate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskDate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskDateCopyWith<TaskDate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDateCopyWith<$Res> {
  factory $TaskDateCopyWith(TaskDate value, $Res Function(TaskDate) then) =
      _$TaskDateCopyWithImpl<$Res, TaskDate>;
  @useResult
  $Res call({String start, String? end});
}

/// @nodoc
class _$TaskDateCopyWithImpl<$Res, $Val extends TaskDate>
    implements $TaskDateCopyWith<$Res> {
  _$TaskDateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskDate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = freezed,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskDateImplCopyWith<$Res>
    implements $TaskDateCopyWith<$Res> {
  factory _$$TaskDateImplCopyWith(
          _$TaskDateImpl value, $Res Function(_$TaskDateImpl) then) =
      __$$TaskDateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String start, String? end});
}

/// @nodoc
class __$$TaskDateImplCopyWithImpl<$Res>
    extends _$TaskDateCopyWithImpl<$Res, _$TaskDateImpl>
    implements _$$TaskDateImplCopyWith<$Res> {
  __$$TaskDateImplCopyWithImpl(
      _$TaskDateImpl _value, $Res Function(_$TaskDateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskDate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = freezed,
  }) {
    return _then(_$TaskDateImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskDateImpl implements _TaskDate {
  const _$TaskDateImpl({required this.start, this.end});

  factory _$TaskDateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskDateImplFromJson(json);

  @override
  final String start;
// TODO: DateTimeにして、時間指定があるかのフラグを追加する
  @override
  final String? end;

  @override
  String toString() {
    return 'TaskDate(start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskDateImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  /// Create a copy of TaskDate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDateImplCopyWith<_$TaskDateImpl> get copyWith =>
      __$$TaskDateImplCopyWithImpl<_$TaskDateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskDateImplToJson(
      this,
    );
  }
}

abstract class _TaskDate implements TaskDate {
  const factory _TaskDate({required final String start, final String? end}) =
      _$TaskDateImpl;

  factory _TaskDate.fromJson(Map<String, dynamic> json) =
      _$TaskDateImpl.fromJson;

  @override
  String get start; // TODO: DateTimeにして、時間指定があるかのフラグを追加する
  @override
  String? get end;

  /// Create a copy of TaskDate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskDateImplCopyWith<_$TaskDateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  TaskDate? get dueDate => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {String id,
      String title,
      bool isCompleted,
      TaskDate? dueDate,
      String? url});

  $TaskDateCopyWith<$Res>? get dueDate;
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? isCompleted = null,
    Object? dueDate = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as TaskDate?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskDateCopyWith<$Res>? get dueDate {
    if (_value.dueDate == null) {
      return null;
    }

    return $TaskDateCopyWith<$Res>(_value.dueDate!, (value) {
      return _then(_value.copyWith(dueDate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      bool isCompleted,
      TaskDate? dueDate,
      String? url});

  @override
  $TaskDateCopyWith<$Res>? get dueDate;
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? isCompleted = null,
    Object? dueDate = freezed,
    Object? url = freezed,
  }) {
    return _then(_$TaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as TaskDate?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl implements _Task {
  const _$TaskImpl(
      {required this.id,
      required this.title,
      required this.isCompleted,
      required this.dueDate,
      required this.url});

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final bool isCompleted;
  @override
  final TaskDate? dueDate;
  @override
  final String? url;

  @override
  String toString() {
    return 'Task(id: $id, title: $title, isCompleted: $isCompleted, dueDate: $dueDate, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, isCompleted, dueDate, url);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task implements Task {
  const factory _Task(
      {required final String id,
      required final String title,
      required final bool isCompleted,
      required final TaskDate? dueDate,
      required final String? url}) = _$TaskImpl;

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  bool get isCompleted;
  @override
  TaskDate? get dueDate;
  @override
  String? get url;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
