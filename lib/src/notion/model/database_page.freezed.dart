// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'database_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DatabasePage {

 String get id; String get title; String get url; List<Property> get properties;
/// Create a copy of DatabasePage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatabasePageCopyWith<DatabasePage> get copyWith => _$DatabasePageCopyWithImpl<DatabasePage>(this as DatabasePage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatabasePage&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.properties, properties));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,url,const DeepCollectionEquality().hash(properties));

@override
String toString() {
  return 'DatabasePage(id: $id, title: $title, url: $url, properties: $properties)';
}


}

/// @nodoc
abstract mixin class $DatabasePageCopyWith<$Res>  {
  factory $DatabasePageCopyWith(DatabasePage value, $Res Function(DatabasePage) _then) = _$DatabasePageCopyWithImpl;
@useResult
$Res call({
 String id, String title, String url, List<Property> properties
});




}
/// @nodoc
class _$DatabasePageCopyWithImpl<$Res>
    implements $DatabasePageCopyWith<$Res> {
  _$DatabasePageCopyWithImpl(this._self, this._then);

  final DatabasePage _self;
  final $Res Function(DatabasePage) _then;

/// Create a copy of DatabasePage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? url = null,Object? properties = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as List<Property>,
  ));
}

}


/// Adds pattern-matching-related methods to [DatabasePage].
extension DatabasePagePatterns on DatabasePage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DatabasePage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DatabasePage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DatabasePage value)  $default,){
final _that = this;
switch (_that) {
case _DatabasePage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DatabasePage value)?  $default,){
final _that = this;
switch (_that) {
case _DatabasePage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String url,  List<Property> properties)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DatabasePage() when $default != null:
return $default(_that.id,_that.title,_that.url,_that.properties);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String url,  List<Property> properties)  $default,) {final _that = this;
switch (_that) {
case _DatabasePage():
return $default(_that.id,_that.title,_that.url,_that.properties);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String url,  List<Property> properties)?  $default,) {final _that = this;
switch (_that) {
case _DatabasePage() when $default != null:
return $default(_that.id,_that.title,_that.url,_that.properties);case _:
  return null;

}
}

}

/// @nodoc


class _DatabasePage implements DatabasePage {
  const _DatabasePage({required this.id, required this.title, required this.url, required final  List<Property> properties}): _properties = properties;
  

@override final  String id;
@override final  String title;
@override final  String url;
 final  List<Property> _properties;
@override List<Property> get properties {
  if (_properties is EqualUnmodifiableListView) return _properties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_properties);
}


/// Create a copy of DatabasePage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DatabasePageCopyWith<_DatabasePage> get copyWith => __$DatabasePageCopyWithImpl<_DatabasePage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DatabasePage&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._properties, _properties));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,url,const DeepCollectionEquality().hash(_properties));

@override
String toString() {
  return 'DatabasePage(id: $id, title: $title, url: $url, properties: $properties)';
}


}

/// @nodoc
abstract mixin class _$DatabasePageCopyWith<$Res> implements $DatabasePageCopyWith<$Res> {
  factory _$DatabasePageCopyWith(_DatabasePage value, $Res Function(_DatabasePage) _then) = __$DatabasePageCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String url, List<Property> properties
});




}
/// @nodoc
class __$DatabasePageCopyWithImpl<$Res>
    implements _$DatabasePageCopyWith<$Res> {
  __$DatabasePageCopyWithImpl(this._self, this._then);

  final _DatabasePage _self;
  final $Res Function(_DatabasePage) _then;

/// Create a copy of DatabasePage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? url = null,Object? properties = null,}) {
  return _then(_DatabasePage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,properties: null == properties ? _self._properties : properties // ignore: cast_nullable_to_non_nullable
as List<Property>,
  ));
}


}

// dart format on
