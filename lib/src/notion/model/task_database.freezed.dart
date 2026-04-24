// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_database.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskDatabase {

 String get id; String get name; TitleProperty get title; CompleteStatusProperty get status; DateProperty get date; SelectProperty? get priority; RelationProperty? get project;// その他のプロパティ（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: Property（任意のPropertyタイプ）
@JsonKey(defaultValue: {}) Map<String, Property>? get additionalProperties;
/// Create a copy of TaskDatabase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskDatabaseCopyWith<TaskDatabase> get copyWith => _$TaskDatabaseCopyWithImpl<TaskDatabase>(this as TaskDatabase, _$identity);

  /// Serializes this TaskDatabase to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDatabase&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.project, project) || other.project == project)&&const DeepCollectionEquality().equals(other.additionalProperties, additionalProperties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,title,status,date,priority,project,const DeepCollectionEquality().hash(additionalProperties));

@override
String toString() {
  return 'TaskDatabase(id: $id, name: $name, title: $title, status: $status, date: $date, priority: $priority, project: $project, additionalProperties: $additionalProperties)';
}


}

/// @nodoc
abstract mixin class $TaskDatabaseCopyWith<$Res>  {
  factory $TaskDatabaseCopyWith(TaskDatabase value, $Res Function(TaskDatabase) _then) = _$TaskDatabaseCopyWithImpl;
@useResult
$Res call({
 String id, String name, TitleProperty title, CompleteStatusProperty status, DateProperty date, SelectProperty? priority, RelationProperty? project,@JsonKey(defaultValue: {}) Map<String, Property>? additionalProperties
});




}
/// @nodoc
class _$TaskDatabaseCopyWithImpl<$Res>
    implements $TaskDatabaseCopyWith<$Res> {
  _$TaskDatabaseCopyWithImpl(this._self, this._then);

  final TaskDatabase _self;
  final $Res Function(TaskDatabase) _then;

/// Create a copy of TaskDatabase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? title = null,Object? status = null,Object? date = null,Object? priority = freezed,Object? project = freezed,Object? additionalProperties = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as TitleProperty,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CompleteStatusProperty,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateProperty,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as SelectProperty?,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as RelationProperty?,additionalProperties: freezed == additionalProperties ? _self.additionalProperties : additionalProperties // ignore: cast_nullable_to_non_nullable
as Map<String, Property>?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskDatabase].
extension TaskDatabasePatterns on TaskDatabase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskDatabase value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskDatabase() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskDatabase value)  $default,){
final _that = this;
switch (_that) {
case _TaskDatabase():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskDatabase value)?  $default,){
final _that = this;
switch (_that) {
case _TaskDatabase() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  TitleProperty title,  CompleteStatusProperty status,  DateProperty date,  SelectProperty? priority,  RelationProperty? project, @JsonKey(defaultValue: {})  Map<String, Property>? additionalProperties)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskDatabase() when $default != null:
return $default(_that.id,_that.name,_that.title,_that.status,_that.date,_that.priority,_that.project,_that.additionalProperties);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  TitleProperty title,  CompleteStatusProperty status,  DateProperty date,  SelectProperty? priority,  RelationProperty? project, @JsonKey(defaultValue: {})  Map<String, Property>? additionalProperties)  $default,) {final _that = this;
switch (_that) {
case _TaskDatabase():
return $default(_that.id,_that.name,_that.title,_that.status,_that.date,_that.priority,_that.project,_that.additionalProperties);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  TitleProperty title,  CompleteStatusProperty status,  DateProperty date,  SelectProperty? priority,  RelationProperty? project, @JsonKey(defaultValue: {})  Map<String, Property>? additionalProperties)?  $default,) {final _that = this;
switch (_that) {
case _TaskDatabase() when $default != null:
return $default(_that.id,_that.name,_that.title,_that.status,_that.date,_that.priority,_that.project,_that.additionalProperties);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _TaskDatabase implements TaskDatabase {
  const _TaskDatabase({required this.id, required this.name, required this.title, required this.status, required this.date, this.priority, this.project, @JsonKey(defaultValue: {}) final  Map<String, Property>? additionalProperties}): _additionalProperties = additionalProperties;
  factory _TaskDatabase.fromJson(Map<String, dynamic> json) => _$TaskDatabaseFromJson(json);

@override final  String id;
@override final  String name;
@override final  TitleProperty title;
@override final  CompleteStatusProperty status;
@override final  DateProperty date;
@override final  SelectProperty? priority;
@override final  RelationProperty? project;
// その他のプロパティ（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: Property（任意のPropertyタイプ）
 final  Map<String, Property>? _additionalProperties;
// その他のプロパティ（固定フィールド以外の追加プロパティ）
// key: プロパティID, value: Property（任意のPropertyタイプ）
@override@JsonKey(defaultValue: {}) Map<String, Property>? get additionalProperties {
  final value = _additionalProperties;
  if (value == null) return null;
  if (_additionalProperties is EqualUnmodifiableMapView) return _additionalProperties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of TaskDatabase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskDatabaseCopyWith<_TaskDatabase> get copyWith => __$TaskDatabaseCopyWithImpl<_TaskDatabase>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskDatabaseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskDatabase&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.project, project) || other.project == project)&&const DeepCollectionEquality().equals(other._additionalProperties, _additionalProperties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,title,status,date,priority,project,const DeepCollectionEquality().hash(_additionalProperties));

@override
String toString() {
  return 'TaskDatabase(id: $id, name: $name, title: $title, status: $status, date: $date, priority: $priority, project: $project, additionalProperties: $additionalProperties)';
}


}

/// @nodoc
abstract mixin class _$TaskDatabaseCopyWith<$Res> implements $TaskDatabaseCopyWith<$Res> {
  factory _$TaskDatabaseCopyWith(_TaskDatabase value, $Res Function(_TaskDatabase) _then) = __$TaskDatabaseCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, TitleProperty title, CompleteStatusProperty status, DateProperty date, SelectProperty? priority, RelationProperty? project,@JsonKey(defaultValue: {}) Map<String, Property>? additionalProperties
});




}
/// @nodoc
class __$TaskDatabaseCopyWithImpl<$Res>
    implements _$TaskDatabaseCopyWith<$Res> {
  __$TaskDatabaseCopyWithImpl(this._self, this._then);

  final _TaskDatabase _self;
  final $Res Function(_TaskDatabase) _then;

/// Create a copy of TaskDatabase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? title = null,Object? status = null,Object? date = null,Object? priority = freezed,Object? project = freezed,Object? additionalProperties = freezed,}) {
  return _then(_TaskDatabase(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as TitleProperty,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CompleteStatusProperty,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateProperty,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as SelectProperty?,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as RelationProperty?,additionalProperties: freezed == additionalProperties ? _self._additionalProperties : additionalProperties // ignore: cast_nullable_to_non_nullable
as Map<String, Property>?,
  ));
}


}

// dart format on
