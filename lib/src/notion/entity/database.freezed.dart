// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'database.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Database {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  List<Property> get properties => throw _privateConstructorUsedError;

  /// Create a copy of Database
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DatabaseCopyWith<Database> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatabaseCopyWith<$Res> {
  factory $DatabaseCopyWith(Database value, $Res Function(Database) then) =
      _$DatabaseCopyWithImpl<$Res, Database>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? icon,
      String url,
      List<Property> properties});
}

/// @nodoc
class _$DatabaseCopyWithImpl<$Res, $Val extends Database>
    implements $DatabaseCopyWith<$Res> {
  _$DatabaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Database
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = freezed,
    Object? url = null,
    Object? properties = null,
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
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<Property>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DatabaseImplCopyWith<$Res>
    implements $DatabaseCopyWith<$Res> {
  factory _$$DatabaseImplCopyWith(
          _$DatabaseImpl value, $Res Function(_$DatabaseImpl) then) =
      __$$DatabaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? icon,
      String url,
      List<Property> properties});
}

/// @nodoc
class __$$DatabaseImplCopyWithImpl<$Res>
    extends _$DatabaseCopyWithImpl<$Res, _$DatabaseImpl>
    implements _$$DatabaseImplCopyWith<$Res> {
  __$$DatabaseImplCopyWithImpl(
      _$DatabaseImpl _value, $Res Function(_$DatabaseImpl) _then)
      : super(_value, _then);

  /// Create a copy of Database
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = freezed,
    Object? url = null,
    Object? properties = null,
  }) {
    return _then(_$DatabaseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<Property>,
    ));
  }
}

/// @nodoc

class _$DatabaseImpl implements _Database {
  const _$DatabaseImpl(
      {required this.id,
      required this.name,
      this.icon,
      required this.url,
      required final List<Property> properties})
      : _properties = properties;

  @override
  final String id;
  @override
  final String name;
  @override
  final String? icon;
  @override
  final String url;
  final List<Property> _properties;
  @override
  List<Property> get properties {
    if (_properties is EqualUnmodifiableListView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_properties);
  }

  @override
  String toString() {
    return 'Database(id: $id, name: $name, icon: $icon, url: $url, properties: $properties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, icon, url,
      const DeepCollectionEquality().hash(_properties));

  /// Create a copy of Database
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseImplCopyWith<_$DatabaseImpl> get copyWith =>
      __$$DatabaseImplCopyWithImpl<_$DatabaseImpl>(this, _$identity);
}

abstract class _Database implements Database {
  const factory _Database(
      {required final String id,
      required final String name,
      final String? icon,
      required final String url,
      required final List<Property> properties}) = _$DatabaseImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get icon;
  @override
  String get url;
  @override
  List<Property> get properties;

  /// Create a copy of Database
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseImplCopyWith<_$DatabaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
