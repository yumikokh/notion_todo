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

NotionDateTime _$NotionDateTimeFromJson(Map<String, dynamic> json) {
  return _NotionDateTime.fromJson(json);
}

/// @nodoc
mixin _$NotionDateTime {
  DateTime get datetime => throw _privateConstructorUsedError;
  bool get isAllDay => throw _privateConstructorUsedError;

  /// Serializes this NotionDateTime to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotionDateTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotionDateTimeCopyWith<NotionDateTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotionDateTimeCopyWith<$Res> {
  factory $NotionDateTimeCopyWith(
          NotionDateTime value, $Res Function(NotionDateTime) then) =
      _$NotionDateTimeCopyWithImpl<$Res, NotionDateTime>;
  @useResult
  $Res call({DateTime datetime, bool isAllDay});
}

/// @nodoc
class _$NotionDateTimeCopyWithImpl<$Res, $Val extends NotionDateTime>
    implements $NotionDateTimeCopyWith<$Res> {
  _$NotionDateTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotionDateTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datetime = null,
    Object? isAllDay = null,
  }) {
    return _then(_value.copyWith(
      datetime: null == datetime
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotionDateTimeImplCopyWith<$Res>
    implements $NotionDateTimeCopyWith<$Res> {
  factory _$$NotionDateTimeImplCopyWith(_$NotionDateTimeImpl value,
          $Res Function(_$NotionDateTimeImpl) then) =
      __$$NotionDateTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime datetime, bool isAllDay});
}

/// @nodoc
class __$$NotionDateTimeImplCopyWithImpl<$Res>
    extends _$NotionDateTimeCopyWithImpl<$Res, _$NotionDateTimeImpl>
    implements _$$NotionDateTimeImplCopyWith<$Res> {
  __$$NotionDateTimeImplCopyWithImpl(
      _$NotionDateTimeImpl _value, $Res Function(_$NotionDateTimeImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotionDateTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datetime = null,
    Object? isAllDay = null,
  }) {
    return _then(_$NotionDateTimeImpl(
      datetime: null == datetime
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotionDateTimeImpl extends _NotionDateTime {
  const _$NotionDateTimeImpl({required this.datetime, required this.isAllDay})
      : super._();

  factory _$NotionDateTimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotionDateTimeImplFromJson(json);

  @override
  final DateTime datetime;
  @override
  final bool isAllDay;

  @override
  String toString() {
    return 'NotionDateTime(datetime: $datetime, isAllDay: $isAllDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotionDateTimeImpl &&
            (identical(other.datetime, datetime) ||
                other.datetime == datetime) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, datetime, isAllDay);

  /// Create a copy of NotionDateTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotionDateTimeImplCopyWith<_$NotionDateTimeImpl> get copyWith =>
      __$$NotionDateTimeImplCopyWithImpl<_$NotionDateTimeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotionDateTimeImplToJson(
      this,
    );
  }
}

abstract class _NotionDateTime extends NotionDateTime {
  const factory _NotionDateTime(
      {required final DateTime datetime,
      required final bool isAllDay}) = _$NotionDateTimeImpl;
  const _NotionDateTime._() : super._();

  factory _NotionDateTime.fromJson(Map<String, dynamic> json) =
      _$NotionDateTimeImpl.fromJson;

  @override
  DateTime get datetime;
  @override
  bool get isAllDay;

  /// Create a copy of NotionDateTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotionDateTimeImplCopyWith<_$NotionDateTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskDate _$TaskDateFromJson(Map<String, dynamic> json) {
  return _TaskDate.fromJson(json);
}

/// @nodoc
mixin _$TaskDate {
  NotionDateTime get start => throw _privateConstructorUsedError;
  NotionDateTime? get end => throw _privateConstructorUsedError;

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
  $Res call({NotionDateTime start, NotionDateTime? end});

  $NotionDateTimeCopyWith<$Res> get start;
  $NotionDateTimeCopyWith<$Res>? get end;
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
              as NotionDateTime,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as NotionDateTime?,
    ) as $Val);
  }

  /// Create a copy of TaskDate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotionDateTimeCopyWith<$Res> get start {
    return $NotionDateTimeCopyWith<$Res>(_value.start, (value) {
      return _then(_value.copyWith(start: value) as $Val);
    });
  }

  /// Create a copy of TaskDate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotionDateTimeCopyWith<$Res>? get end {
    if (_value.end == null) {
      return null;
    }

    return $NotionDateTimeCopyWith<$Res>(_value.end!, (value) {
      return _then(_value.copyWith(end: value) as $Val);
    });
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
  $Res call({NotionDateTime start, NotionDateTime? end});

  @override
  $NotionDateTimeCopyWith<$Res> get start;
  @override
  $NotionDateTimeCopyWith<$Res>? get end;
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
              as NotionDateTime,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as NotionDateTime?,
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
  final NotionDateTime start;
  @override
  final NotionDateTime? end;

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
  const factory _TaskDate(
      {required final NotionDateTime start,
      final NotionDateTime? end}) = _$TaskDateImpl;

  factory _TaskDate.fromJson(Map<String, dynamic> json) =
      _$TaskDateImpl.fromJson;

  @override
  NotionDateTime get start;
  @override
  NotionDateTime? get end;

  /// Create a copy of TaskDate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskDateImplCopyWith<_$TaskDateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskStatus _$TaskStatusFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'checkbox':
      return TaskStatusCheckbox.fromJson(json);
    case 'status':
      return TaskStatusStatus.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'TaskStatus',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$TaskStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool checkbox) checkbox,
    required TResult Function(StatusGroup? group, StatusOption? option) status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool checkbox)? checkbox,
    TResult? Function(StatusGroup? group, StatusOption? option)? status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool checkbox)? checkbox,
    TResult Function(StatusGroup? group, StatusOption? option)? status,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskStatusCheckbox value) checkbox,
    required TResult Function(TaskStatusStatus value) status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskStatusCheckbox value)? checkbox,
    TResult? Function(TaskStatusStatus value)? status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskStatusCheckbox value)? checkbox,
    TResult Function(TaskStatusStatus value)? status,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this TaskStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskStatusCopyWith<$Res> {
  factory $TaskStatusCopyWith(
          TaskStatus value, $Res Function(TaskStatus) then) =
      _$TaskStatusCopyWithImpl<$Res, TaskStatus>;
}

/// @nodoc
class _$TaskStatusCopyWithImpl<$Res, $Val extends TaskStatus>
    implements $TaskStatusCopyWith<$Res> {
  _$TaskStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TaskStatusCheckboxImplCopyWith<$Res> {
  factory _$$TaskStatusCheckboxImplCopyWith(_$TaskStatusCheckboxImpl value,
          $Res Function(_$TaskStatusCheckboxImpl) then) =
      __$$TaskStatusCheckboxImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool checkbox});
}

/// @nodoc
class __$$TaskStatusCheckboxImplCopyWithImpl<$Res>
    extends _$TaskStatusCopyWithImpl<$Res, _$TaskStatusCheckboxImpl>
    implements _$$TaskStatusCheckboxImplCopyWith<$Res> {
  __$$TaskStatusCheckboxImplCopyWithImpl(_$TaskStatusCheckboxImpl _value,
      $Res Function(_$TaskStatusCheckboxImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkbox = null,
  }) {
    return _then(_$TaskStatusCheckboxImpl(
      checkbox: null == checkbox
          ? _value.checkbox
          : checkbox // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskStatusCheckboxImpl implements TaskStatusCheckbox {
  const _$TaskStatusCheckboxImpl({required this.checkbox, final String? $type})
      : $type = $type ?? 'checkbox';

  factory _$TaskStatusCheckboxImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskStatusCheckboxImplFromJson(json);

  @override
  final bool checkbox;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TaskStatus.checkbox(checkbox: $checkbox)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskStatusCheckboxImpl &&
            (identical(other.checkbox, checkbox) ||
                other.checkbox == checkbox));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, checkbox);

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskStatusCheckboxImplCopyWith<_$TaskStatusCheckboxImpl> get copyWith =>
      __$$TaskStatusCheckboxImplCopyWithImpl<_$TaskStatusCheckboxImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool checkbox) checkbox,
    required TResult Function(StatusGroup? group, StatusOption? option) status,
  }) {
    return checkbox(this.checkbox);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool checkbox)? checkbox,
    TResult? Function(StatusGroup? group, StatusOption? option)? status,
  }) {
    return checkbox?.call(this.checkbox);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool checkbox)? checkbox,
    TResult Function(StatusGroup? group, StatusOption? option)? status,
    required TResult orElse(),
  }) {
    if (checkbox != null) {
      return checkbox(this.checkbox);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskStatusCheckbox value) checkbox,
    required TResult Function(TaskStatusStatus value) status,
  }) {
    return checkbox(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskStatusCheckbox value)? checkbox,
    TResult? Function(TaskStatusStatus value)? status,
  }) {
    return checkbox?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskStatusCheckbox value)? checkbox,
    TResult Function(TaskStatusStatus value)? status,
    required TResult orElse(),
  }) {
    if (checkbox != null) {
      return checkbox(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskStatusCheckboxImplToJson(
      this,
    );
  }
}

abstract class TaskStatusCheckbox implements TaskStatus {
  const factory TaskStatusCheckbox({required final bool checkbox}) =
      _$TaskStatusCheckboxImpl;

  factory TaskStatusCheckbox.fromJson(Map<String, dynamic> json) =
      _$TaskStatusCheckboxImpl.fromJson;

  bool get checkbox;

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskStatusCheckboxImplCopyWith<_$TaskStatusCheckboxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskStatusStatusImplCopyWith<$Res> {
  factory _$$TaskStatusStatusImplCopyWith(_$TaskStatusStatusImpl value,
          $Res Function(_$TaskStatusStatusImpl) then) =
      __$$TaskStatusStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StatusGroup? group, StatusOption? option});
}

/// @nodoc
class __$$TaskStatusStatusImplCopyWithImpl<$Res>
    extends _$TaskStatusCopyWithImpl<$Res, _$TaskStatusStatusImpl>
    implements _$$TaskStatusStatusImplCopyWith<$Res> {
  __$$TaskStatusStatusImplCopyWithImpl(_$TaskStatusStatusImpl _value,
      $Res Function(_$TaskStatusStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = freezed,
    Object? option = freezed,
  }) {
    return _then(_$TaskStatusStatusImpl(
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as StatusGroup?,
      option: freezed == option
          ? _value.option
          : option // ignore: cast_nullable_to_non_nullable
              as StatusOption?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskStatusStatusImpl implements TaskStatusStatus {
  const _$TaskStatusStatusImpl(
      {required this.group, required this.option, final String? $type})
      : $type = $type ?? 'status';

  factory _$TaskStatusStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskStatusStatusImplFromJson(json);

  @override
  final StatusGroup? group;
  @override
  final StatusOption? option;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TaskStatus.status(group: $group, option: $option)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskStatusStatusImpl &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.option, option) || other.option == option));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, group, option);

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskStatusStatusImplCopyWith<_$TaskStatusStatusImpl> get copyWith =>
      __$$TaskStatusStatusImplCopyWithImpl<_$TaskStatusStatusImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool checkbox) checkbox,
    required TResult Function(StatusGroup? group, StatusOption? option) status,
  }) {
    return status(group, option);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool checkbox)? checkbox,
    TResult? Function(StatusGroup? group, StatusOption? option)? status,
  }) {
    return status?.call(group, option);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool checkbox)? checkbox,
    TResult Function(StatusGroup? group, StatusOption? option)? status,
    required TResult orElse(),
  }) {
    if (status != null) {
      return status(group, option);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskStatusCheckbox value) checkbox,
    required TResult Function(TaskStatusStatus value) status,
  }) {
    return status(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskStatusCheckbox value)? checkbox,
    TResult? Function(TaskStatusStatus value)? status,
  }) {
    return status?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskStatusCheckbox value)? checkbox,
    TResult Function(TaskStatusStatus value)? status,
    required TResult orElse(),
  }) {
    if (status != null) {
      return status(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskStatusStatusImplToJson(
      this,
    );
  }
}

abstract class TaskStatusStatus implements TaskStatus {
  const factory TaskStatusStatus(
      {required final StatusGroup? group,
      required final StatusOption? option}) = _$TaskStatusStatusImpl;

  factory TaskStatusStatus.fromJson(Map<String, dynamic> json) =
      _$TaskStatusStatusImpl.fromJson;

  StatusGroup? get group;
  StatusOption? get option;

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskStatusStatusImplCopyWith<_$TaskStatusStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  TaskStatus get status => throw _privateConstructorUsedError;
  TaskDate? get dueDate => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  SelectOption? get priority => throw _privateConstructorUsedError;
  List<RelationOption>? get projects =>
      throw _privateConstructorUsedError; // 動的なプロパティ値（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: プロパティ値（dynamic）
  @JsonKey(defaultValue: {})
  Map<String, dynamic>? get additionalFields =>
      throw _privateConstructorUsedError;

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
      TaskStatus status,
      TaskDate? dueDate,
      String? url,
      SelectOption? priority,
      List<RelationOption>? projects,
      @JsonKey(defaultValue: {}) Map<String, dynamic>? additionalFields});

  $TaskStatusCopyWith<$Res> get status;
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
    Object? status = null,
    Object? dueDate = freezed,
    Object? url = freezed,
    Object? priority = freezed,
    Object? projects = freezed,
    Object? additionalFields = freezed,
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as TaskDate?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as SelectOption?,
      projects: freezed == projects
          ? _value.projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<RelationOption>?,
      additionalFields: freezed == additionalFields
          ? _value.additionalFields
          : additionalFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskStatusCopyWith<$Res> get status {
    return $TaskStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
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
      TaskStatus status,
      TaskDate? dueDate,
      String? url,
      SelectOption? priority,
      List<RelationOption>? projects,
      @JsonKey(defaultValue: {}) Map<String, dynamic>? additionalFields});

  @override
  $TaskStatusCopyWith<$Res> get status;
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
    Object? status = null,
    Object? dueDate = freezed,
    Object? url = freezed,
    Object? priority = freezed,
    Object? projects = freezed,
    Object? additionalFields = freezed,
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as TaskDate?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as SelectOption?,
      projects: freezed == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<RelationOption>?,
      additionalFields: freezed == additionalFields
          ? _value._additionalFields
          : additionalFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl extends _Task {
  const _$TaskImpl(
      {required this.id,
      required this.title,
      required this.status,
      required this.dueDate,
      required this.url,
      this.priority,
      final List<RelationOption>? projects,
      @JsonKey(defaultValue: {}) final Map<String, dynamic>? additionalFields})
      : _projects = projects,
        _additionalFields = additionalFields,
        super._();

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final TaskStatus status;
  @override
  final TaskDate? dueDate;
  @override
  final String? url;
  @override
  final SelectOption? priority;
  final List<RelationOption>? _projects;
  @override
  List<RelationOption>? get projects {
    final value = _projects;
    if (value == null) return null;
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// 動的なプロパティ値（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: プロパティ値（dynamic）
  final Map<String, dynamic>? _additionalFields;
// 動的なプロパティ値（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: プロパティ値（dynamic）
  @override
  @JsonKey(defaultValue: {})
  Map<String, dynamic>? get additionalFields {
    final value = _additionalFields;
    if (value == null) return null;
    if (_additionalFields is EqualUnmodifiableMapView) return _additionalFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, status: $status, dueDate: $dueDate, url: $url, priority: $priority, projects: $projects, additionalFields: $additionalFields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            const DeepCollectionEquality()
                .equals(other._additionalFields, _additionalFields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      status,
      dueDate,
      url,
      priority,
      const DeepCollectionEquality().hash(_projects),
      const DeepCollectionEquality().hash(_additionalFields));

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

abstract class _Task extends Task {
  const factory _Task(
      {required final String id,
      required final String title,
      required final TaskStatus status,
      required final TaskDate? dueDate,
      required final String? url,
      final SelectOption? priority,
      final List<RelationOption>? projects,
      @JsonKey(defaultValue: {})
      final Map<String, dynamic>? additionalFields}) = _$TaskImpl;
  const _Task._() : super._();

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  TaskStatus get status;
  @override
  TaskDate? get dueDate;
  @override
  String? get url;
  @override
  SelectOption? get priority;
  @override
  List<RelationOption>? get projects; // 動的なプロパティ値（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: プロパティ値（dynamic）
  @override
  @JsonKey(defaultValue: {})
  Map<String, dynamic>? get additionalFields;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
