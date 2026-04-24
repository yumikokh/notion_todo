// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotionDateTime {

 DateTime get datetime; bool get isAllDay;
/// Create a copy of NotionDateTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotionDateTimeCopyWith<NotionDateTime> get copyWith => _$NotionDateTimeCopyWithImpl<NotionDateTime>(this as NotionDateTime, _$identity);

  /// Serializes this NotionDateTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotionDateTime&&(identical(other.datetime, datetime) || other.datetime == datetime)&&(identical(other.isAllDay, isAllDay) || other.isAllDay == isAllDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,datetime,isAllDay);

@override
String toString() {
  return 'NotionDateTime(datetime: $datetime, isAllDay: $isAllDay)';
}


}

/// @nodoc
abstract mixin class $NotionDateTimeCopyWith<$Res>  {
  factory $NotionDateTimeCopyWith(NotionDateTime value, $Res Function(NotionDateTime) _then) = _$NotionDateTimeCopyWithImpl;
@useResult
$Res call({
 DateTime datetime, bool isAllDay
});




}
/// @nodoc
class _$NotionDateTimeCopyWithImpl<$Res>
    implements $NotionDateTimeCopyWith<$Res> {
  _$NotionDateTimeCopyWithImpl(this._self, this._then);

  final NotionDateTime _self;
  final $Res Function(NotionDateTime) _then;

/// Create a copy of NotionDateTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? datetime = null,Object? isAllDay = null,}) {
  return _then(_self.copyWith(
datetime: null == datetime ? _self.datetime : datetime // ignore: cast_nullable_to_non_nullable
as DateTime,isAllDay: null == isAllDay ? _self.isAllDay : isAllDay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotionDateTime].
extension NotionDateTimePatterns on NotionDateTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotionDateTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotionDateTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotionDateTime value)  $default,){
final _that = this;
switch (_that) {
case _NotionDateTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotionDateTime value)?  $default,){
final _that = this;
switch (_that) {
case _NotionDateTime() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime datetime,  bool isAllDay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotionDateTime() when $default != null:
return $default(_that.datetime,_that.isAllDay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime datetime,  bool isAllDay)  $default,) {final _that = this;
switch (_that) {
case _NotionDateTime():
return $default(_that.datetime,_that.isAllDay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime datetime,  bool isAllDay)?  $default,) {final _that = this;
switch (_that) {
case _NotionDateTime() when $default != null:
return $default(_that.datetime,_that.isAllDay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotionDateTime extends NotionDateTime {
  const _NotionDateTime({required this.datetime, required this.isAllDay}): super._();
  factory _NotionDateTime.fromJson(Map<String, dynamic> json) => _$NotionDateTimeFromJson(json);

@override final  DateTime datetime;
@override final  bool isAllDay;

/// Create a copy of NotionDateTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotionDateTimeCopyWith<_NotionDateTime> get copyWith => __$NotionDateTimeCopyWithImpl<_NotionDateTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotionDateTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotionDateTime&&(identical(other.datetime, datetime) || other.datetime == datetime)&&(identical(other.isAllDay, isAllDay) || other.isAllDay == isAllDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,datetime,isAllDay);

@override
String toString() {
  return 'NotionDateTime(datetime: $datetime, isAllDay: $isAllDay)';
}


}

/// @nodoc
abstract mixin class _$NotionDateTimeCopyWith<$Res> implements $NotionDateTimeCopyWith<$Res> {
  factory _$NotionDateTimeCopyWith(_NotionDateTime value, $Res Function(_NotionDateTime) _then) = __$NotionDateTimeCopyWithImpl;
@override @useResult
$Res call({
 DateTime datetime, bool isAllDay
});




}
/// @nodoc
class __$NotionDateTimeCopyWithImpl<$Res>
    implements _$NotionDateTimeCopyWith<$Res> {
  __$NotionDateTimeCopyWithImpl(this._self, this._then);

  final _NotionDateTime _self;
  final $Res Function(_NotionDateTime) _then;

/// Create a copy of NotionDateTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? datetime = null,Object? isAllDay = null,}) {
  return _then(_NotionDateTime(
datetime: null == datetime ? _self.datetime : datetime // ignore: cast_nullable_to_non_nullable
as DateTime,isAllDay: null == isAllDay ? _self.isAllDay : isAllDay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TaskDate {

 NotionDateTime get start; NotionDateTime? get end;
/// Create a copy of TaskDate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskDateCopyWith<TaskDate> get copyWith => _$TaskDateCopyWithImpl<TaskDate>(this as TaskDate, _$identity);

  /// Serializes this TaskDate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDate&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'TaskDate(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $TaskDateCopyWith<$Res>  {
  factory $TaskDateCopyWith(TaskDate value, $Res Function(TaskDate) _then) = _$TaskDateCopyWithImpl;
@useResult
$Res call({
 NotionDateTime start, NotionDateTime? end
});


$NotionDateTimeCopyWith<$Res> get start;$NotionDateTimeCopyWith<$Res>? get end;

}
/// @nodoc
class _$TaskDateCopyWithImpl<$Res>
    implements $TaskDateCopyWith<$Res> {
  _$TaskDateCopyWithImpl(this._self, this._then);

  final TaskDate _self;
  final $Res Function(TaskDate) _then;

/// Create a copy of TaskDate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = freezed,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as NotionDateTime,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as NotionDateTime?,
  ));
}
/// Create a copy of TaskDate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotionDateTimeCopyWith<$Res> get start {
  
  return $NotionDateTimeCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}/// Create a copy of TaskDate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotionDateTimeCopyWith<$Res>? get end {
    if (_self.end == null) {
    return null;
  }

  return $NotionDateTimeCopyWith<$Res>(_self.end!, (value) {
    return _then(_self.copyWith(end: value));
  });
}
}


/// Adds pattern-matching-related methods to [TaskDate].
extension TaskDatePatterns on TaskDate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskDate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskDate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskDate value)  $default,){
final _that = this;
switch (_that) {
case _TaskDate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskDate value)?  $default,){
final _that = this;
switch (_that) {
case _TaskDate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NotionDateTime start,  NotionDateTime? end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskDate() when $default != null:
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NotionDateTime start,  NotionDateTime? end)  $default,) {final _that = this;
switch (_that) {
case _TaskDate():
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NotionDateTime start,  NotionDateTime? end)?  $default,) {final _that = this;
switch (_that) {
case _TaskDate() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskDate implements TaskDate {
  const _TaskDate({required this.start, this.end});
  factory _TaskDate.fromJson(Map<String, dynamic> json) => _$TaskDateFromJson(json);

@override final  NotionDateTime start;
@override final  NotionDateTime? end;

/// Create a copy of TaskDate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskDateCopyWith<_TaskDate> get copyWith => __$TaskDateCopyWithImpl<_TaskDate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskDateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskDate&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'TaskDate(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$TaskDateCopyWith<$Res> implements $TaskDateCopyWith<$Res> {
  factory _$TaskDateCopyWith(_TaskDate value, $Res Function(_TaskDate) _then) = __$TaskDateCopyWithImpl;
@override @useResult
$Res call({
 NotionDateTime start, NotionDateTime? end
});


@override $NotionDateTimeCopyWith<$Res> get start;@override $NotionDateTimeCopyWith<$Res>? get end;

}
/// @nodoc
class __$TaskDateCopyWithImpl<$Res>
    implements _$TaskDateCopyWith<$Res> {
  __$TaskDateCopyWithImpl(this._self, this._then);

  final _TaskDate _self;
  final $Res Function(_TaskDate) _then;

/// Create a copy of TaskDate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = freezed,}) {
  return _then(_TaskDate(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as NotionDateTime,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as NotionDateTime?,
  ));
}

/// Create a copy of TaskDate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotionDateTimeCopyWith<$Res> get start {
  
  return $NotionDateTimeCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}/// Create a copy of TaskDate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotionDateTimeCopyWith<$Res>? get end {
    if (_self.end == null) {
    return null;
  }

  return $NotionDateTimeCopyWith<$Res>(_self.end!, (value) {
    return _then(_self.copyWith(end: value));
  });
}
}

TaskStatus _$TaskStatusFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'checkbox':
          return TaskStatusCheckbox.fromJson(
            json
          );
                case 'status':
          return TaskStatusStatus.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'TaskStatus',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$TaskStatus {



  /// Serializes this TaskStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskStatus);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskStatus()';
}


}

/// @nodoc
class $TaskStatusCopyWith<$Res>  {
$TaskStatusCopyWith(TaskStatus _, $Res Function(TaskStatus) __);
}


/// Adds pattern-matching-related methods to [TaskStatus].
extension TaskStatusPatterns on TaskStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TaskStatusCheckbox value)?  checkbox,TResult Function( TaskStatusStatus value)?  status,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TaskStatusCheckbox() when checkbox != null:
return checkbox(_that);case TaskStatusStatus() when status != null:
return status(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TaskStatusCheckbox value)  checkbox,required TResult Function( TaskStatusStatus value)  status,}){
final _that = this;
switch (_that) {
case TaskStatusCheckbox():
return checkbox(_that);case TaskStatusStatus():
return status(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TaskStatusCheckbox value)?  checkbox,TResult? Function( TaskStatusStatus value)?  status,}){
final _that = this;
switch (_that) {
case TaskStatusCheckbox() when checkbox != null:
return checkbox(_that);case TaskStatusStatus() when status != null:
return status(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool checkbox)?  checkbox,TResult Function( StatusGroup? group,  StatusOption? option)?  status,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TaskStatusCheckbox() when checkbox != null:
return checkbox(_that.checkbox);case TaskStatusStatus() when status != null:
return status(_that.group,_that.option);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool checkbox)  checkbox,required TResult Function( StatusGroup? group,  StatusOption? option)  status,}) {final _that = this;
switch (_that) {
case TaskStatusCheckbox():
return checkbox(_that.checkbox);case TaskStatusStatus():
return status(_that.group,_that.option);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool checkbox)?  checkbox,TResult? Function( StatusGroup? group,  StatusOption? option)?  status,}) {final _that = this;
switch (_that) {
case TaskStatusCheckbox() when checkbox != null:
return checkbox(_that.checkbox);case TaskStatusStatus() when status != null:
return status(_that.group,_that.option);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class TaskStatusCheckbox implements TaskStatus {
  const TaskStatusCheckbox({required this.checkbox, final  String? $type}): $type = $type ?? 'checkbox';
  factory TaskStatusCheckbox.fromJson(Map<String, dynamic> json) => _$TaskStatusCheckboxFromJson(json);

 final  bool checkbox;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TaskStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskStatusCheckboxCopyWith<TaskStatusCheckbox> get copyWith => _$TaskStatusCheckboxCopyWithImpl<TaskStatusCheckbox>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskStatusCheckboxToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskStatusCheckbox&&(identical(other.checkbox, checkbox) || other.checkbox == checkbox));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,checkbox);

@override
String toString() {
  return 'TaskStatus.checkbox(checkbox: $checkbox)';
}


}

/// @nodoc
abstract mixin class $TaskStatusCheckboxCopyWith<$Res> implements $TaskStatusCopyWith<$Res> {
  factory $TaskStatusCheckboxCopyWith(TaskStatusCheckbox value, $Res Function(TaskStatusCheckbox) _then) = _$TaskStatusCheckboxCopyWithImpl;
@useResult
$Res call({
 bool checkbox
});




}
/// @nodoc
class _$TaskStatusCheckboxCopyWithImpl<$Res>
    implements $TaskStatusCheckboxCopyWith<$Res> {
  _$TaskStatusCheckboxCopyWithImpl(this._self, this._then);

  final TaskStatusCheckbox _self;
  final $Res Function(TaskStatusCheckbox) _then;

/// Create a copy of TaskStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? checkbox = null,}) {
  return _then(TaskStatusCheckbox(
checkbox: null == checkbox ? _self.checkbox : checkbox // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TaskStatusStatus implements TaskStatus {
  const TaskStatusStatus({required this.group, required this.option, final  String? $type}): $type = $type ?? 'status';
  factory TaskStatusStatus.fromJson(Map<String, dynamic> json) => _$TaskStatusStatusFromJson(json);

 final  StatusGroup? group;
 final  StatusOption? option;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TaskStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskStatusStatusCopyWith<TaskStatusStatus> get copyWith => _$TaskStatusStatusCopyWithImpl<TaskStatusStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskStatusStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskStatusStatus&&(identical(other.group, group) || other.group == group)&&(identical(other.option, option) || other.option == option));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,group,option);

@override
String toString() {
  return 'TaskStatus.status(group: $group, option: $option)';
}


}

/// @nodoc
abstract mixin class $TaskStatusStatusCopyWith<$Res> implements $TaskStatusCopyWith<$Res> {
  factory $TaskStatusStatusCopyWith(TaskStatusStatus value, $Res Function(TaskStatusStatus) _then) = _$TaskStatusStatusCopyWithImpl;
@useResult
$Res call({
 StatusGroup? group, StatusOption? option
});




}
/// @nodoc
class _$TaskStatusStatusCopyWithImpl<$Res>
    implements $TaskStatusStatusCopyWith<$Res> {
  _$TaskStatusStatusCopyWithImpl(this._self, this._then);

  final TaskStatusStatus _self;
  final $Res Function(TaskStatusStatus) _then;

/// Create a copy of TaskStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? group = freezed,Object? option = freezed,}) {
  return _then(TaskStatusStatus(
group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as StatusGroup?,option: freezed == option ? _self.option : option // ignore: cast_nullable_to_non_nullable
as StatusOption?,
  ));
}


}


/// @nodoc
mixin _$Task {

 String get id; String get title; TaskStatus get status; TaskDate? get dueDate; String? get url; String? get icon; SelectOption? get priority; List<RelationOption>? get projects;// 動的なプロパティ値（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: プロパティ値（dynamic）
@JsonKey(defaultValue: {}) Map<String, dynamic>? get additionalFields;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.url, url) || other.url == url)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.priority, priority) || other.priority == priority)&&const DeepCollectionEquality().equals(other.projects, projects)&&const DeepCollectionEquality().equals(other.additionalFields, additionalFields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,status,dueDate,url,icon,priority,const DeepCollectionEquality().hash(projects),const DeepCollectionEquality().hash(additionalFields));

@override
String toString() {
  return 'Task(id: $id, title: $title, status: $status, dueDate: $dueDate, url: $url, icon: $icon, priority: $priority, projects: $projects, additionalFields: $additionalFields)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 String id, String title, TaskStatus status, TaskDate? dueDate, String? url, String? icon, SelectOption? priority, List<RelationOption>? projects,@JsonKey(defaultValue: {}) Map<String, dynamic>? additionalFields
});


$TaskStatusCopyWith<$Res> get status;$TaskDateCopyWith<$Res>? get dueDate;

}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? status = null,Object? dueDate = freezed,Object? url = freezed,Object? icon = freezed,Object? priority = freezed,Object? projects = freezed,Object? additionalFields = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as TaskDate?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as SelectOption?,projects: freezed == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<RelationOption>?,additionalFields: freezed == additionalFields ? _self.additionalFields : additionalFields // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskStatusCopyWith<$Res> get status {
  
  return $TaskStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskDateCopyWith<$Res>? get dueDate {
    if (_self.dueDate == null) {
    return null;
  }

  return $TaskDateCopyWith<$Res>(_self.dueDate!, (value) {
    return _then(_self.copyWith(dueDate: value));
  });
}
}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  TaskStatus status,  TaskDate? dueDate,  String? url,  String? icon,  SelectOption? priority,  List<RelationOption>? projects, @JsonKey(defaultValue: {})  Map<String, dynamic>? additionalFields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.dueDate,_that.url,_that.icon,_that.priority,_that.projects,_that.additionalFields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  TaskStatus status,  TaskDate? dueDate,  String? url,  String? icon,  SelectOption? priority,  List<RelationOption>? projects, @JsonKey(defaultValue: {})  Map<String, dynamic>? additionalFields)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.id,_that.title,_that.status,_that.dueDate,_that.url,_that.icon,_that.priority,_that.projects,_that.additionalFields);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  TaskStatus status,  TaskDate? dueDate,  String? url,  String? icon,  SelectOption? priority,  List<RelationOption>? projects, @JsonKey(defaultValue: {})  Map<String, dynamic>? additionalFields)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.dueDate,_that.url,_that.icon,_that.priority,_that.projects,_that.additionalFields);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Task extends Task {
  const _Task({required this.id, required this.title, required this.status, required this.dueDate, required this.url, this.icon, this.priority, final  List<RelationOption>? projects, @JsonKey(defaultValue: {}) final  Map<String, dynamic>? additionalFields}): _projects = projects,_additionalFields = additionalFields,super._();
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

@override final  String id;
@override final  String title;
@override final  TaskStatus status;
@override final  TaskDate? dueDate;
@override final  String? url;
@override final  String? icon;
@override final  SelectOption? priority;
 final  List<RelationOption>? _projects;
@override List<RelationOption>? get projects {
  final value = _projects;
  if (value == null) return null;
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// 動的なプロパティ値（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: プロパティ値（dynamic）
 final  Map<String, dynamic>? _additionalFields;
// 動的なプロパティ値（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: プロパティ値（dynamic）
@override@JsonKey(defaultValue: {}) Map<String, dynamic>? get additionalFields {
  final value = _additionalFields;
  if (value == null) return null;
  if (_additionalFields is EqualUnmodifiableMapView) return _additionalFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.url, url) || other.url == url)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.priority, priority) || other.priority == priority)&&const DeepCollectionEquality().equals(other._projects, _projects)&&const DeepCollectionEquality().equals(other._additionalFields, _additionalFields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,status,dueDate,url,icon,priority,const DeepCollectionEquality().hash(_projects),const DeepCollectionEquality().hash(_additionalFields));

@override
String toString() {
  return 'Task(id: $id, title: $title, status: $status, dueDate: $dueDate, url: $url, icon: $icon, priority: $priority, projects: $projects, additionalFields: $additionalFields)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, TaskStatus status, TaskDate? dueDate, String? url, String? icon, SelectOption? priority, List<RelationOption>? projects,@JsonKey(defaultValue: {}) Map<String, dynamic>? additionalFields
});


@override $TaskStatusCopyWith<$Res> get status;@override $TaskDateCopyWith<$Res>? get dueDate;

}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? status = null,Object? dueDate = freezed,Object? url = freezed,Object? icon = freezed,Object? priority = freezed,Object? projects = freezed,Object? additionalFields = freezed,}) {
  return _then(_Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as TaskDate?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as SelectOption?,projects: freezed == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<RelationOption>?,additionalFields: freezed == additionalFields ? _self._additionalFields : additionalFields // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskStatusCopyWith<$Res> get status {
  
  return $TaskStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskDateCopyWith<$Res>? get dueDate {
    if (_self.dueDate == null) {
    return null;
  }

  return $TaskDateCopyWith<$Res>(_self.dueDate!, (value) {
    return _then(_self.copyWith(dueDate: value));
  });
}
}

// dart format on
