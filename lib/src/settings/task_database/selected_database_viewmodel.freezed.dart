// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_database_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectedDatabaseState implements DiagnosticableTreeMixin {

 String get id; String get name; TitleProperty get title; CompleteStatusProperty? get status; DateProperty? get date; SelectProperty? get priority; RelationProperty? get project;
/// Create a copy of SelectedDatabaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectedDatabaseStateCopyWith<SelectedDatabaseState> get copyWith => _$SelectedDatabaseStateCopyWithImpl<SelectedDatabaseState>(this as SelectedDatabaseState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SelectedDatabaseState'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('date', date))..add(DiagnosticsProperty('priority', priority))..add(DiagnosticsProperty('project', project));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedDatabaseState&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.project, project) || other.project == project));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,title,status,date,priority,project);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SelectedDatabaseState(id: $id, name: $name, title: $title, status: $status, date: $date, priority: $priority, project: $project)';
}


}

/// @nodoc
abstract mixin class $SelectedDatabaseStateCopyWith<$Res>  {
  factory $SelectedDatabaseStateCopyWith(SelectedDatabaseState value, $Res Function(SelectedDatabaseState) _then) = _$SelectedDatabaseStateCopyWithImpl;
@useResult
$Res call({
 String id, String name, TitleProperty title, CompleteStatusProperty? status, DateProperty? date, SelectProperty? priority, RelationProperty? project
});




}
/// @nodoc
class _$SelectedDatabaseStateCopyWithImpl<$Res>
    implements $SelectedDatabaseStateCopyWith<$Res> {
  _$SelectedDatabaseStateCopyWithImpl(this._self, this._then);

  final SelectedDatabaseState _self;
  final $Res Function(SelectedDatabaseState) _then;

/// Create a copy of SelectedDatabaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? title = null,Object? status = freezed,Object? date = freezed,Object? priority = freezed,Object? project = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as TitleProperty,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CompleteStatusProperty?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateProperty?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as SelectProperty?,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as RelationProperty?,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectedDatabaseState].
extension SelectedDatabaseStatePatterns on SelectedDatabaseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectedDatabaseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectedDatabaseState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectedDatabaseState value)  $default,){
final _that = this;
switch (_that) {
case _SelectedDatabaseState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectedDatabaseState value)?  $default,){
final _that = this;
switch (_that) {
case _SelectedDatabaseState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  TitleProperty title,  CompleteStatusProperty? status,  DateProperty? date,  SelectProperty? priority,  RelationProperty? project)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectedDatabaseState() when $default != null:
return $default(_that.id,_that.name,_that.title,_that.status,_that.date,_that.priority,_that.project);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  TitleProperty title,  CompleteStatusProperty? status,  DateProperty? date,  SelectProperty? priority,  RelationProperty? project)  $default,) {final _that = this;
switch (_that) {
case _SelectedDatabaseState():
return $default(_that.id,_that.name,_that.title,_that.status,_that.date,_that.priority,_that.project);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  TitleProperty title,  CompleteStatusProperty? status,  DateProperty? date,  SelectProperty? priority,  RelationProperty? project)?  $default,) {final _that = this;
switch (_that) {
case _SelectedDatabaseState() when $default != null:
return $default(_that.id,_that.name,_that.title,_that.status,_that.date,_that.priority,_that.project);case _:
  return null;

}
}

}

/// @nodoc


class _SelectedDatabaseState with DiagnosticableTreeMixin implements SelectedDatabaseState {
  const _SelectedDatabaseState({required this.id, required this.name, required this.title, required this.status, required this.date, this.priority, this.project});
  

@override final  String id;
@override final  String name;
@override final  TitleProperty title;
@override final  CompleteStatusProperty? status;
@override final  DateProperty? date;
@override final  SelectProperty? priority;
@override final  RelationProperty? project;

/// Create a copy of SelectedDatabaseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectedDatabaseStateCopyWith<_SelectedDatabaseState> get copyWith => __$SelectedDatabaseStateCopyWithImpl<_SelectedDatabaseState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SelectedDatabaseState'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('date', date))..add(DiagnosticsProperty('priority', priority))..add(DiagnosticsProperty('project', project));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectedDatabaseState&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.project, project) || other.project == project));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,title,status,date,priority,project);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SelectedDatabaseState(id: $id, name: $name, title: $title, status: $status, date: $date, priority: $priority, project: $project)';
}


}

/// @nodoc
abstract mixin class _$SelectedDatabaseStateCopyWith<$Res> implements $SelectedDatabaseStateCopyWith<$Res> {
  factory _$SelectedDatabaseStateCopyWith(_SelectedDatabaseState value, $Res Function(_SelectedDatabaseState) _then) = __$SelectedDatabaseStateCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, TitleProperty title, CompleteStatusProperty? status, DateProperty? date, SelectProperty? priority, RelationProperty? project
});




}
/// @nodoc
class __$SelectedDatabaseStateCopyWithImpl<$Res>
    implements _$SelectedDatabaseStateCopyWith<$Res> {
  __$SelectedDatabaseStateCopyWithImpl(this._self, this._then);

  final _SelectedDatabaseState _self;
  final $Res Function(_SelectedDatabaseState) _then;

/// Create a copy of SelectedDatabaseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? title = null,Object? status = freezed,Object? date = freezed,Object? priority = freezed,Object? project = freezed,}) {
  return _then(_SelectedDatabaseState(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as TitleProperty,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CompleteStatusProperty?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateProperty?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as SelectProperty?,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as RelationProperty?,
  ));
}


}

// dart format on
