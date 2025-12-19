// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'database.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Database {

 String get id; String get name; String? get icon; String get url; List<Property> get properties;
/// Create a copy of Database
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatabaseCopyWith<Database> get copyWith => _$DatabaseCopyWithImpl<Database>(this as Database, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Database&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.properties, properties));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,icon,url,const DeepCollectionEquality().hash(properties));

@override
String toString() {
  return 'Database(id: $id, name: $name, icon: $icon, url: $url, properties: $properties)';
}


}

/// @nodoc
abstract mixin class $DatabaseCopyWith<$Res>  {
  factory $DatabaseCopyWith(Database value, $Res Function(Database) _then) = _$DatabaseCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? icon, String url, List<Property> properties
});




}
/// @nodoc
class _$DatabaseCopyWithImpl<$Res>
    implements $DatabaseCopyWith<$Res> {
  _$DatabaseCopyWithImpl(this._self, this._then);

  final Database _self;
  final $Res Function(Database) _then;

/// Create a copy of Database
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? icon = freezed,Object? url = null,Object? properties = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as List<Property>,
  ));
}

}


/// Adds pattern-matching-related methods to [Database].
extension DatabasePatterns on Database {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Database value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Database() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Database value)  $default,){
final _that = this;
switch (_that) {
case _Database():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Database value)?  $default,){
final _that = this;
switch (_that) {
case _Database() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? icon,  String url,  List<Property> properties)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Database() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.url,_that.properties);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? icon,  String url,  List<Property> properties)  $default,) {final _that = this;
switch (_that) {
case _Database():
return $default(_that.id,_that.name,_that.icon,_that.url,_that.properties);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? icon,  String url,  List<Property> properties)?  $default,) {final _that = this;
switch (_that) {
case _Database() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.url,_that.properties);case _:
  return null;

}
}

}

/// @nodoc


class _Database implements Database {
  const _Database({required this.id, required this.name, this.icon, required this.url, required final  List<Property> properties}): _properties = properties;
  

@override final  String id;
@override final  String name;
@override final  String? icon;
@override final  String url;
 final  List<Property> _properties;
@override List<Property> get properties {
  if (_properties is EqualUnmodifiableListView) return _properties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_properties);
}


/// Create a copy of Database
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DatabaseCopyWith<_Database> get copyWith => __$DatabaseCopyWithImpl<_Database>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Database&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._properties, _properties));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,icon,url,const DeepCollectionEquality().hash(_properties));

@override
String toString() {
  return 'Database(id: $id, name: $name, icon: $icon, url: $url, properties: $properties)';
}


}

/// @nodoc
abstract mixin class _$DatabaseCopyWith<$Res> implements $DatabaseCopyWith<$Res> {
  factory _$DatabaseCopyWith(_Database value, $Res Function(_Database) _then) = __$DatabaseCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? icon, String url, List<Property> properties
});




}
/// @nodoc
class __$DatabaseCopyWithImpl<$Res>
    implements _$DatabaseCopyWith<$Res> {
  __$DatabaseCopyWithImpl(this._self, this._then);

  final _Database _self;
  final $Res Function(_Database) _then;

/// Create a copy of Database
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? icon = freezed,Object? url = null,Object? properties = null,}) {
  return _then(_Database(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,properties: null == properties ? _self._properties : properties // ignore: cast_nullable_to_non_nullable
as List<Property>,
  ));
}


}

// dart format on
