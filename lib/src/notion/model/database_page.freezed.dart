// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'database_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DatabasePage {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  List<Property> get properties => throw _privateConstructorUsedError;

  /// Create a copy of DatabasePage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DatabasePageCopyWith<DatabasePage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatabasePageCopyWith<$Res> {
  factory $DatabasePageCopyWith(
          DatabasePage value, $Res Function(DatabasePage) then) =
      _$DatabasePageCopyWithImpl<$Res, DatabasePage>;
  @useResult
  $Res call({String id, String title, String url, List<Property> properties});
}

/// @nodoc
class _$DatabasePageCopyWithImpl<$Res, $Val extends DatabasePage>
    implements $DatabasePageCopyWith<$Res> {
  _$DatabasePageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DatabasePage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? properties = null,
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
abstract class _$$DatabasePageImplCopyWith<$Res>
    implements $DatabasePageCopyWith<$Res> {
  factory _$$DatabasePageImplCopyWith(
          _$DatabasePageImpl value, $Res Function(_$DatabasePageImpl) then) =
      __$$DatabasePageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String url, List<Property> properties});
}

/// @nodoc
class __$$DatabasePageImplCopyWithImpl<$Res>
    extends _$DatabasePageCopyWithImpl<$Res, _$DatabasePageImpl>
    implements _$$DatabasePageImplCopyWith<$Res> {
  __$$DatabasePageImplCopyWithImpl(
      _$DatabasePageImpl _value, $Res Function(_$DatabasePageImpl) _then)
      : super(_value, _then);

  /// Create a copy of DatabasePage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? properties = null,
  }) {
    return _then(_$DatabasePageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$DatabasePageImpl implements _DatabasePage {
  const _$DatabasePageImpl(
      {required this.id,
      required this.title,
      required this.url,
      required final List<Property> properties})
      : _properties = properties;

  @override
  final String id;
  @override
  final String title;
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
    return 'DatabasePage(id: $id, title: $title, url: $url, properties: $properties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabasePageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, url,
      const DeepCollectionEquality().hash(_properties));

  /// Create a copy of DatabasePage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabasePageImplCopyWith<_$DatabasePageImpl> get copyWith =>
      __$$DatabasePageImplCopyWithImpl<_$DatabasePageImpl>(this, _$identity);
}

abstract class _DatabasePage implements DatabasePage {
  const factory _DatabasePage(
      {required final String id,
      required final String title,
      required final String url,
      required final List<Property> properties}) = _$DatabasePageImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get url;
  @override
  List<Property> get properties;

  /// Create a copy of DatabasePage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabasePageImplCopyWith<_$DatabasePageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}