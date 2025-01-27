// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Property _$PropertyFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'title':
      return TitleProperty.fromJson(json);
    case 'date':
      return DateProperty.fromJson(json);
    case 'checkbox':
      return CheckboxProperty.fromJson(json);
    case 'status':
      return StatusProperty.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Property',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Property {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @protected
  PropertyType get type => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String name, String title, @protected PropertyType type)
        title,
    required TResult Function(String id, String name, DateTime? date,
            @protected PropertyType type)
        date,
    required TResult Function(
            String id, String name, bool checked, @protected PropertyType type)
        checkbox,
    required TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)
        status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String name, String title, @protected PropertyType type)?
        title,
    TResult? Function(String id, String name, DateTime? date,
            @protected PropertyType type)?
        date,
    TResult? Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult? Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id, String name, String title, @protected PropertyType type)?
        title,
    TResult Function(String id, String name, DateTime? date,
            @protected PropertyType type)?
        date,
    TResult Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleProperty value) title,
    required TResult Function(DateProperty value) date,
    required TResult Function(CheckboxProperty value) checkbox,
    required TResult Function(StatusProperty value) status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TitleProperty value)? title,
    TResult? Function(DateProperty value)? date,
    TResult? Function(CheckboxProperty value)? checkbox,
    TResult? Function(StatusProperty value)? status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleProperty value)? title,
    TResult Function(DateProperty value)? date,
    TResult Function(CheckboxProperty value)? checkbox,
    TResult Function(StatusProperty value)? status,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Property to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PropertyCopyWith<Property> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropertyCopyWith<$Res> {
  factory $PropertyCopyWith(Property value, $Res Function(Property) then) =
      _$PropertyCopyWithImpl<$Res, Property>;
  @useResult
  $Res call({String id, String name, @protected PropertyType type});
}

/// @nodoc
class _$PropertyCopyWithImpl<$Res, $Val extends Property>
    implements $PropertyCopyWith<$Res> {
  _$PropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PropertyType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TitlePropertyImplCopyWith<$Res>
    implements $PropertyCopyWith<$Res> {
  factory _$$TitlePropertyImplCopyWith(
          _$TitlePropertyImpl value, $Res Function(_$TitlePropertyImpl) then) =
      __$$TitlePropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, String title, @protected PropertyType type});
}

/// @nodoc
class __$$TitlePropertyImplCopyWithImpl<$Res>
    extends _$PropertyCopyWithImpl<$Res, _$TitlePropertyImpl>
    implements _$$TitlePropertyImplCopyWith<$Res> {
  __$$TitlePropertyImplCopyWithImpl(
      _$TitlePropertyImpl _value, $Res Function(_$TitlePropertyImpl) _then)
      : super(_value, _then);

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = null,
    Object? type = null,
  }) {
    return _then(_$TitlePropertyImpl(
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
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PropertyType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TitlePropertyImpl implements TitleProperty {
  const _$TitlePropertyImpl(
      {required this.id,
      required this.name,
      required this.title,
      @protected this.type = PropertyType.title,
      final String? $type})
      : assert(type == PropertyType.title),
        $type = $type ?? 'title';

  factory _$TitlePropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$TitlePropertyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String title;
  @override
  @JsonKey()
  @protected
  final PropertyType type;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Property.title(id: $id, name: $name, title: $title, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TitlePropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, title, type);

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TitlePropertyImplCopyWith<_$TitlePropertyImpl> get copyWith =>
      __$$TitlePropertyImplCopyWithImpl<_$TitlePropertyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String name, String title, @protected PropertyType type)
        title,
    required TResult Function(String id, String name, DateTime? date,
            @protected PropertyType type)
        date,
    required TResult Function(
            String id, String name, bool checked, @protected PropertyType type)
        checkbox,
    required TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)
        status,
  }) {
    return title(id, name, this.title, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String name, String title, @protected PropertyType type)?
        title,
    TResult? Function(String id, String name, DateTime? date,
            @protected PropertyType type)?
        date,
    TResult? Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult? Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
  }) {
    return title?.call(id, name, this.title, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id, String name, String title, @protected PropertyType type)?
        title,
    TResult Function(String id, String name, DateTime? date,
            @protected PropertyType type)?
        date,
    TResult Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
    required TResult orElse(),
  }) {
    if (title != null) {
      return title(id, name, this.title, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleProperty value) title,
    required TResult Function(DateProperty value) date,
    required TResult Function(CheckboxProperty value) checkbox,
    required TResult Function(StatusProperty value) status,
  }) {
    return title(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TitleProperty value)? title,
    TResult? Function(DateProperty value)? date,
    TResult? Function(CheckboxProperty value)? checkbox,
    TResult? Function(StatusProperty value)? status,
  }) {
    return title?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleProperty value)? title,
    TResult Function(DateProperty value)? date,
    TResult Function(CheckboxProperty value)? checkbox,
    TResult Function(StatusProperty value)? status,
    required TResult orElse(),
  }) {
    if (title != null) {
      return title(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TitlePropertyImplToJson(
      this,
    );
  }
}

abstract class TitleProperty implements Property {
  const factory TitleProperty(
      {required final String id,
      required final String name,
      required final String title,
      @protected final PropertyType type}) = _$TitlePropertyImpl;

  factory TitleProperty.fromJson(Map<String, dynamic> json) =
      _$TitlePropertyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  String get title;
  @override
  @protected
  PropertyType get type;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TitlePropertyImplCopyWith<_$TitlePropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatePropertyImplCopyWith<$Res>
    implements $PropertyCopyWith<$Res> {
  factory _$$DatePropertyImplCopyWith(
          _$DatePropertyImpl value, $Res Function(_$DatePropertyImpl) then) =
      __$$DatePropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, DateTime? date, @protected PropertyType type});
}

/// @nodoc
class __$$DatePropertyImplCopyWithImpl<$Res>
    extends _$PropertyCopyWithImpl<$Res, _$DatePropertyImpl>
    implements _$$DatePropertyImplCopyWith<$Res> {
  __$$DatePropertyImplCopyWithImpl(
      _$DatePropertyImpl _value, $Res Function(_$DatePropertyImpl) _then)
      : super(_value, _then);

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? date = freezed,
    Object? type = null,
  }) {
    return _then(_$DatePropertyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PropertyType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DatePropertyImpl implements DateProperty {
  const _$DatePropertyImpl(
      {required this.id,
      required this.name,
      required this.date,
      @protected this.type = PropertyType.date,
      final String? $type})
      : assert(type == PropertyType.date),
        $type = $type ?? 'date';

  factory _$DatePropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$DatePropertyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime? date;
  @override
  @JsonKey()
  @protected
  final PropertyType type;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Property.date(id: $id, name: $name, date: $date, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatePropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, date, type);

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatePropertyImplCopyWith<_$DatePropertyImpl> get copyWith =>
      __$$DatePropertyImplCopyWithImpl<_$DatePropertyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String name, String title, @protected PropertyType type)
        title,
    required TResult Function(String id, String name, DateTime? date,
            @protected PropertyType type)
        date,
    required TResult Function(
            String id, String name, bool checked, @protected PropertyType type)
        checkbox,
    required TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)
        status,
  }) {
    return date(id, name, this.date, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String name, String title, @protected PropertyType type)?
        title,
    TResult? Function(String id, String name, DateTime? date,
            @protected PropertyType type)?
        date,
    TResult? Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult? Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
  }) {
    return date?.call(id, name, this.date, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id, String name, String title, @protected PropertyType type)?
        title,
    TResult Function(String id, String name, DateTime? date,
            @protected PropertyType type)?
        date,
    TResult Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
    required TResult orElse(),
  }) {
    if (date != null) {
      return date(id, name, this.date, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleProperty value) title,
    required TResult Function(DateProperty value) date,
    required TResult Function(CheckboxProperty value) checkbox,
    required TResult Function(StatusProperty value) status,
  }) {
    return date(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TitleProperty value)? title,
    TResult? Function(DateProperty value)? date,
    TResult? Function(CheckboxProperty value)? checkbox,
    TResult? Function(StatusProperty value)? status,
  }) {
    return date?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleProperty value)? title,
    TResult Function(DateProperty value)? date,
    TResult Function(CheckboxProperty value)? checkbox,
    TResult Function(StatusProperty value)? status,
    required TResult orElse(),
  }) {
    if (date != null) {
      return date(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DatePropertyImplToJson(
      this,
    );
  }
}

abstract class DateProperty implements Property {
  const factory DateProperty(
      {required final String id,
      required final String name,
      required final DateTime? date,
      @protected final PropertyType type}) = _$DatePropertyImpl;

  factory DateProperty.fromJson(Map<String, dynamic> json) =
      _$DatePropertyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  DateTime? get date;
  @override
  @protected
  PropertyType get type;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatePropertyImplCopyWith<_$DatePropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckboxPropertyImplCopyWith<$Res>
    implements $PropertyCopyWith<$Res> {
  factory _$$CheckboxPropertyImplCopyWith(_$CheckboxPropertyImpl value,
          $Res Function(_$CheckboxPropertyImpl) then) =
      __$$CheckboxPropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, bool checked, @protected PropertyType type});
}

/// @nodoc
class __$$CheckboxPropertyImplCopyWithImpl<$Res>
    extends _$PropertyCopyWithImpl<$Res, _$CheckboxPropertyImpl>
    implements _$$CheckboxPropertyImplCopyWith<$Res> {
  __$$CheckboxPropertyImplCopyWithImpl(_$CheckboxPropertyImpl _value,
      $Res Function(_$CheckboxPropertyImpl) _then)
      : super(_value, _then);

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? checked = null,
    Object? type = null,
  }) {
    return _then(_$CheckboxPropertyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      checked: null == checked
          ? _value.checked
          : checked // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PropertyType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckboxPropertyImpl implements CheckboxProperty {
  const _$CheckboxPropertyImpl(
      {required this.id,
      required this.name,
      required this.checked,
      @protected this.type = PropertyType.checkbox,
      final String? $type})
      : assert(type == PropertyType.checkbox),
        $type = $type ?? 'checkbox';

  factory _$CheckboxPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckboxPropertyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final bool checked;
  @override
  @JsonKey()
  @protected
  final PropertyType type;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Property.checkbox(id: $id, name: $name, checked: $checked, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckboxPropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.checked, checked) || other.checked == checked) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, checked, type);

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckboxPropertyImplCopyWith<_$CheckboxPropertyImpl> get copyWith =>
      __$$CheckboxPropertyImplCopyWithImpl<_$CheckboxPropertyImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String name, String title, @protected PropertyType type)
        title,
    required TResult Function(String id, String name, DateTime? date,
            @protected PropertyType type)
        date,
    required TResult Function(
            String id, String name, bool checked, @protected PropertyType type)
        checkbox,
    required TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)
        status,
  }) {
    return checkbox(id, name, checked, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String name, String title, @protected PropertyType type)?
        title,
    TResult? Function(String id, String name, DateTime? date,
            @protected PropertyType type)?
        date,
    TResult? Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult? Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
  }) {
    return checkbox?.call(id, name, checked, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id, String name, String title, @protected PropertyType type)?
        title,
    TResult Function(String id, String name, DateTime? date,
            @protected PropertyType type)?
        date,
    TResult Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
    required TResult orElse(),
  }) {
    if (checkbox != null) {
      return checkbox(id, name, checked, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleProperty value) title,
    required TResult Function(DateProperty value) date,
    required TResult Function(CheckboxProperty value) checkbox,
    required TResult Function(StatusProperty value) status,
  }) {
    return checkbox(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TitleProperty value)? title,
    TResult? Function(DateProperty value)? date,
    TResult? Function(CheckboxProperty value)? checkbox,
    TResult? Function(StatusProperty value)? status,
  }) {
    return checkbox?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleProperty value)? title,
    TResult Function(DateProperty value)? date,
    TResult Function(CheckboxProperty value)? checkbox,
    TResult Function(StatusProperty value)? status,
    required TResult orElse(),
  }) {
    if (checkbox != null) {
      return checkbox(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckboxPropertyImplToJson(
      this,
    );
  }
}

abstract class CheckboxProperty implements Property {
  const factory CheckboxProperty(
      {required final String id,
      required final String name,
      required final bool checked,
      @protected final PropertyType type}) = _$CheckboxPropertyImpl;

  factory CheckboxProperty.fromJson(Map<String, dynamic> json) =
      _$CheckboxPropertyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  bool get checked;
  @override
  @protected
  PropertyType get type;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckboxPropertyImplCopyWith<_$CheckboxPropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StatusPropertyImplCopyWith<$Res>
    implements $PropertyCopyWith<$Res> {
  factory _$$StatusPropertyImplCopyWith(_$StatusPropertyImpl value,
          $Res Function(_$StatusPropertyImpl) then) =
      __$$StatusPropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ({List<StatusGroup> groups, List<StatusOption> options}) status,
      StatusOption? todoOption,
      StatusOption? completeOption,
      @protected PropertyType type});

  $StatusOptionCopyWith<$Res>? get todoOption;
  $StatusOptionCopyWith<$Res>? get completeOption;
}

/// @nodoc
class __$$StatusPropertyImplCopyWithImpl<$Res>
    extends _$PropertyCopyWithImpl<$Res, _$StatusPropertyImpl>
    implements _$$StatusPropertyImplCopyWith<$Res> {
  __$$StatusPropertyImplCopyWithImpl(
      _$StatusPropertyImpl _value, $Res Function(_$StatusPropertyImpl) _then)
      : super(_value, _then);

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? todoOption = freezed,
    Object? completeOption = freezed,
    Object? type = null,
  }) {
    return _then(_$StatusPropertyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ({List<StatusGroup> groups, List<StatusOption> options}),
      todoOption: freezed == todoOption
          ? _value.todoOption
          : todoOption // ignore: cast_nullable_to_non_nullable
              as StatusOption?,
      completeOption: freezed == completeOption
          ? _value.completeOption
          : completeOption // ignore: cast_nullable_to_non_nullable
              as StatusOption?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PropertyType,
    ));
  }

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatusOptionCopyWith<$Res>? get todoOption {
    if (_value.todoOption == null) {
      return null;
    }

    return $StatusOptionCopyWith<$Res>(_value.todoOption!, (value) {
      return _then(_value.copyWith(todoOption: value));
    });
  }

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatusOptionCopyWith<$Res>? get completeOption {
    if (_value.completeOption == null) {
      return null;
    }

    return $StatusOptionCopyWith<$Res>(_value.completeOption!, (value) {
      return _then(_value.copyWith(completeOption: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusPropertyImpl implements StatusProperty {
  const _$StatusPropertyImpl(
      {required this.id,
      required this.name,
      required this.status,
      required this.todoOption,
      required this.completeOption,
      @protected this.type = PropertyType.status,
      final String? $type})
      : assert(type == PropertyType.status),
        $type = $type ?? 'status';

  factory _$StatusPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusPropertyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final ({List<StatusGroup> groups, List<StatusOption> options}) status;
  @override
  final StatusOption? todoOption;
  @override
  final StatusOption? completeOption;
  @override
  @JsonKey()
  @protected
  final PropertyType type;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Property.status(id: $id, name: $name, status: $status, todoOption: $todoOption, completeOption: $completeOption, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusPropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.todoOption, todoOption) ||
                other.todoOption == todoOption) &&
            (identical(other.completeOption, completeOption) ||
                other.completeOption == completeOption) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, status, todoOption, completeOption, type);

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusPropertyImplCopyWith<_$StatusPropertyImpl> get copyWith =>
      __$$StatusPropertyImplCopyWithImpl<_$StatusPropertyImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String name, String title, @protected PropertyType type)
        title,
    required TResult Function(String id, String name, DateTime? date,
            @protected PropertyType type)
        date,
    required TResult Function(
            String id, String name, bool checked, @protected PropertyType type)
        checkbox,
    required TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)
        status,
  }) {
    return status(id, name, this.status, todoOption, completeOption, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String name, String title, @protected PropertyType type)?
        title,
    TResult? Function(String id, String name, DateTime? date,
            @protected PropertyType type)?
        date,
    TResult? Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult? Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
  }) {
    return status?.call(
        id, name, this.status, todoOption, completeOption, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id, String name, String title, @protected PropertyType type)?
        title,
    TResult Function(String id, String name, DateTime? date,
            @protected PropertyType type)?
        date,
    TResult Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
    required TResult orElse(),
  }) {
    if (status != null) {
      return status(id, name, this.status, todoOption, completeOption, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleProperty value) title,
    required TResult Function(DateProperty value) date,
    required TResult Function(CheckboxProperty value) checkbox,
    required TResult Function(StatusProperty value) status,
  }) {
    return status(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TitleProperty value)? title,
    TResult? Function(DateProperty value)? date,
    TResult? Function(CheckboxProperty value)? checkbox,
    TResult? Function(StatusProperty value)? status,
  }) {
    return status?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleProperty value)? title,
    TResult Function(DateProperty value)? date,
    TResult Function(CheckboxProperty value)? checkbox,
    TResult Function(StatusProperty value)? status,
    required TResult orElse(),
  }) {
    if (status != null) {
      return status(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusPropertyImplToJson(
      this,
    );
  }
}

abstract class StatusProperty implements Property {
  const factory StatusProperty(
      {required final String id,
      required final String name,
      required final ({
        List<StatusGroup> groups,
        List<StatusOption> options
      }) status,
      required final StatusOption? todoOption,
      required final StatusOption? completeOption,
      @protected final PropertyType type}) = _$StatusPropertyImpl;

  factory StatusProperty.fromJson(Map<String, dynamic> json) =
      _$StatusPropertyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  ({List<StatusGroup> groups, List<StatusOption> options}) get status;
  StatusOption? get todoOption;
  StatusOption? get completeOption;
  @override
  @protected
  PropertyType get type;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusPropertyImplCopyWith<_$StatusPropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CompleteStatusProperty _$CompleteStatusPropertyFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'checkbox':
      return CheckboxCompleteStatusProperty.fromJson(json);
    case 'status':
      return StatusCompleteStatusProperty.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'CompleteStatusProperty',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$CompleteStatusProperty {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @protected
  PropertyType get type => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String name, bool checked, @protected PropertyType type)
        checkbox,
    required TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)
        status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult? Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckboxCompleteStatusProperty value) checkbox,
    required TResult Function(StatusCompleteStatusProperty value) status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckboxCompleteStatusProperty value)? checkbox,
    TResult? Function(StatusCompleteStatusProperty value)? status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckboxCompleteStatusProperty value)? checkbox,
    TResult Function(StatusCompleteStatusProperty value)? status,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this CompleteStatusProperty to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompleteStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompleteStatusPropertyCopyWith<CompleteStatusProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompleteStatusPropertyCopyWith<$Res> {
  factory $CompleteStatusPropertyCopyWith(CompleteStatusProperty value,
          $Res Function(CompleteStatusProperty) then) =
      _$CompleteStatusPropertyCopyWithImpl<$Res, CompleteStatusProperty>;
  @useResult
  $Res call({String id, String name, @protected PropertyType type});
}

/// @nodoc
class _$CompleteStatusPropertyCopyWithImpl<$Res,
        $Val extends CompleteStatusProperty>
    implements $CompleteStatusPropertyCopyWith<$Res> {
  _$CompleteStatusPropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompleteStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PropertyType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckboxCompleteStatusPropertyImplCopyWith<$Res>
    implements $CompleteStatusPropertyCopyWith<$Res> {
  factory _$$CheckboxCompleteStatusPropertyImplCopyWith(
          _$CheckboxCompleteStatusPropertyImpl value,
          $Res Function(_$CheckboxCompleteStatusPropertyImpl) then) =
      __$$CheckboxCompleteStatusPropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, bool checked, @protected PropertyType type});
}

/// @nodoc
class __$$CheckboxCompleteStatusPropertyImplCopyWithImpl<$Res>
    extends _$CompleteStatusPropertyCopyWithImpl<$Res,
        _$CheckboxCompleteStatusPropertyImpl>
    implements _$$CheckboxCompleteStatusPropertyImplCopyWith<$Res> {
  __$$CheckboxCompleteStatusPropertyImplCopyWithImpl(
      _$CheckboxCompleteStatusPropertyImpl _value,
      $Res Function(_$CheckboxCompleteStatusPropertyImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompleteStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? checked = null,
    Object? type = null,
  }) {
    return _then(_$CheckboxCompleteStatusPropertyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      checked: null == checked
          ? _value.checked
          : checked // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PropertyType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckboxCompleteStatusPropertyImpl
    implements CheckboxCompleteStatusProperty {
  const _$CheckboxCompleteStatusPropertyImpl(
      {required this.id,
      required this.name,
      required this.checked,
      @protected this.type = PropertyType.checkbox,
      final String? $type})
      : $type = $type ?? 'checkbox';

  factory _$CheckboxCompleteStatusPropertyImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CheckboxCompleteStatusPropertyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final bool checked;
  @override
  @JsonKey()
  @protected
  final PropertyType type;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CompleteStatusProperty.checkbox(id: $id, name: $name, checked: $checked, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckboxCompleteStatusPropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.checked, checked) || other.checked == checked) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, checked, type);

  /// Create a copy of CompleteStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckboxCompleteStatusPropertyImplCopyWith<
          _$CheckboxCompleteStatusPropertyImpl>
      get copyWith => __$$CheckboxCompleteStatusPropertyImplCopyWithImpl<
          _$CheckboxCompleteStatusPropertyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String name, bool checked, @protected PropertyType type)
        checkbox,
    required TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)
        status,
  }) {
    return checkbox(id, name, checked, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult? Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
  }) {
    return checkbox?.call(id, name, checked, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
    required TResult orElse(),
  }) {
    if (checkbox != null) {
      return checkbox(id, name, checked, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckboxCompleteStatusProperty value) checkbox,
    required TResult Function(StatusCompleteStatusProperty value) status,
  }) {
    return checkbox(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckboxCompleteStatusProperty value)? checkbox,
    TResult? Function(StatusCompleteStatusProperty value)? status,
  }) {
    return checkbox?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckboxCompleteStatusProperty value)? checkbox,
    TResult Function(StatusCompleteStatusProperty value)? status,
    required TResult orElse(),
  }) {
    if (checkbox != null) {
      return checkbox(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckboxCompleteStatusPropertyImplToJson(
      this,
    );
  }
}

abstract class CheckboxCompleteStatusProperty
    implements CompleteStatusProperty {
  const factory CheckboxCompleteStatusProperty(
          {required final String id,
          required final String name,
          required final bool checked,
          @protected final PropertyType type}) =
      _$CheckboxCompleteStatusPropertyImpl;

  factory CheckboxCompleteStatusProperty.fromJson(Map<String, dynamic> json) =
      _$CheckboxCompleteStatusPropertyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  bool get checked;
  @override
  @protected
  PropertyType get type;

  /// Create a copy of CompleteStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckboxCompleteStatusPropertyImplCopyWith<
          _$CheckboxCompleteStatusPropertyImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StatusCompleteStatusPropertyImplCopyWith<$Res>
    implements $CompleteStatusPropertyCopyWith<$Res> {
  factory _$$StatusCompleteStatusPropertyImplCopyWith(
          _$StatusCompleteStatusPropertyImpl value,
          $Res Function(_$StatusCompleteStatusPropertyImpl) then) =
      __$$StatusCompleteStatusPropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ({List<StatusGroup> groups, List<StatusOption> options}) status,
      StatusOption? todoOption,
      StatusOption? completeOption,
      @protected PropertyType type});

  $StatusOptionCopyWith<$Res>? get todoOption;
  $StatusOptionCopyWith<$Res>? get completeOption;
}

/// @nodoc
class __$$StatusCompleteStatusPropertyImplCopyWithImpl<$Res>
    extends _$CompleteStatusPropertyCopyWithImpl<$Res,
        _$StatusCompleteStatusPropertyImpl>
    implements _$$StatusCompleteStatusPropertyImplCopyWith<$Res> {
  __$$StatusCompleteStatusPropertyImplCopyWithImpl(
      _$StatusCompleteStatusPropertyImpl _value,
      $Res Function(_$StatusCompleteStatusPropertyImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompleteStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? todoOption = freezed,
    Object? completeOption = freezed,
    Object? type = null,
  }) {
    return _then(_$StatusCompleteStatusPropertyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ({List<StatusGroup> groups, List<StatusOption> options}),
      todoOption: freezed == todoOption
          ? _value.todoOption
          : todoOption // ignore: cast_nullable_to_non_nullable
              as StatusOption?,
      completeOption: freezed == completeOption
          ? _value.completeOption
          : completeOption // ignore: cast_nullable_to_non_nullable
              as StatusOption?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PropertyType,
    ));
  }

  /// Create a copy of CompleteStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatusOptionCopyWith<$Res>? get todoOption {
    if (_value.todoOption == null) {
      return null;
    }

    return $StatusOptionCopyWith<$Res>(_value.todoOption!, (value) {
      return _then(_value.copyWith(todoOption: value));
    });
  }

  /// Create a copy of CompleteStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatusOptionCopyWith<$Res>? get completeOption {
    if (_value.completeOption == null) {
      return null;
    }

    return $StatusOptionCopyWith<$Res>(_value.completeOption!, (value) {
      return _then(_value.copyWith(completeOption: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusCompleteStatusPropertyImpl
    implements StatusCompleteStatusProperty {
  const _$StatusCompleteStatusPropertyImpl(
      {required this.id,
      required this.name,
      required this.status,
      required this.todoOption,
      required this.completeOption,
      @protected this.type = PropertyType.status,
      final String? $type})
      : $type = $type ?? 'status';

  factory _$StatusCompleteStatusPropertyImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$StatusCompleteStatusPropertyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final ({List<StatusGroup> groups, List<StatusOption> options}) status;
  @override
  final StatusOption? todoOption;
  @override
  final StatusOption? completeOption;
  @override
  @JsonKey()
  @protected
  final PropertyType type;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CompleteStatusProperty.status(id: $id, name: $name, status: $status, todoOption: $todoOption, completeOption: $completeOption, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusCompleteStatusPropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.todoOption, todoOption) ||
                other.todoOption == todoOption) &&
            (identical(other.completeOption, completeOption) ||
                other.completeOption == completeOption) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, status, todoOption, completeOption, type);

  /// Create a copy of CompleteStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusCompleteStatusPropertyImplCopyWith<
          _$StatusCompleteStatusPropertyImpl>
      get copyWith => __$$StatusCompleteStatusPropertyImplCopyWithImpl<
          _$StatusCompleteStatusPropertyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String name, bool checked, @protected PropertyType type)
        checkbox,
    required TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)
        status,
  }) {
    return status(id, name, this.status, todoOption, completeOption, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult? Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
  }) {
    return status?.call(
        id, name, this.status, todoOption, completeOption, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id, String name, bool checked, @protected PropertyType type)?
        checkbox,
    TResult Function(
            String id,
            String name,
            ({List<StatusGroup> groups, List<StatusOption> options}) status,
            StatusOption? todoOption,
            StatusOption? completeOption,
            @protected PropertyType type)?
        status,
    required TResult orElse(),
  }) {
    if (status != null) {
      return status(id, name, this.status, todoOption, completeOption, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckboxCompleteStatusProperty value) checkbox,
    required TResult Function(StatusCompleteStatusProperty value) status,
  }) {
    return status(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckboxCompleteStatusProperty value)? checkbox,
    TResult? Function(StatusCompleteStatusProperty value)? status,
  }) {
    return status?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckboxCompleteStatusProperty value)? checkbox,
    TResult Function(StatusCompleteStatusProperty value)? status,
    required TResult orElse(),
  }) {
    if (status != null) {
      return status(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusCompleteStatusPropertyImplToJson(
      this,
    );
  }
}

abstract class StatusCompleteStatusProperty implements CompleteStatusProperty {
  const factory StatusCompleteStatusProperty(
      {required final String id,
      required final String name,
      required final ({
        List<StatusGroup> groups,
        List<StatusOption> options
      }) status,
      required final StatusOption? todoOption,
      required final StatusOption? completeOption,
      @protected final PropertyType type}) = _$StatusCompleteStatusPropertyImpl;

  factory StatusCompleteStatusProperty.fromJson(Map<String, dynamic> json) =
      _$StatusCompleteStatusPropertyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  ({List<StatusGroup> groups, List<StatusOption> options}) get status;
  StatusOption? get todoOption;
  StatusOption? get completeOption;
  @override
  @protected
  PropertyType get type;

  /// Create a copy of CompleteStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusCompleteStatusPropertyImplCopyWith<
          _$StatusCompleteStatusPropertyImpl>
      get copyWith => throw _privateConstructorUsedError;
}

StatusOption _$StatusOptionFromJson(Map<String, dynamic> json) {
  return _StatusOption.fromJson(json);
}

/// @nodoc
mixin _$StatusOption {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  /// Serializes this StatusOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusOptionCopyWith<StatusOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusOptionCopyWith<$Res> {
  factory $StatusOptionCopyWith(
          StatusOption value, $Res Function(StatusOption) then) =
      _$StatusOptionCopyWithImpl<$Res, StatusOption>;
  @useResult
  $Res call({String id, String name, String? color});
}

/// @nodoc
class _$StatusOptionCopyWithImpl<$Res, $Val extends StatusOption>
    implements $StatusOptionCopyWith<$Res> {
  _$StatusOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = freezed,
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
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusOptionImplCopyWith<$Res>
    implements $StatusOptionCopyWith<$Res> {
  factory _$$StatusOptionImplCopyWith(
          _$StatusOptionImpl value, $Res Function(_$StatusOptionImpl) then) =
      __$$StatusOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? color});
}

/// @nodoc
class __$$StatusOptionImplCopyWithImpl<$Res>
    extends _$StatusOptionCopyWithImpl<$Res, _$StatusOptionImpl>
    implements _$$StatusOptionImplCopyWith<$Res> {
  __$$StatusOptionImplCopyWithImpl(
      _$StatusOptionImpl _value, $Res Function(_$StatusOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = freezed,
  }) {
    return _then(_$StatusOptionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusOptionImpl implements _StatusOption {
  const _$StatusOptionImpl(
      {required this.id, required this.name, required this.color});

  factory _$StatusOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusOptionImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? color;

  @override
  String toString() {
    return 'StatusOption(id: $id, name: $name, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, color);

  /// Create a copy of StatusOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusOptionImplCopyWith<_$StatusOptionImpl> get copyWith =>
      __$$StatusOptionImplCopyWithImpl<_$StatusOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusOptionImplToJson(
      this,
    );
  }
}

abstract class _StatusOption implements StatusOption {
  const factory _StatusOption(
      {required final String id,
      required final String name,
      required final String? color}) = _$StatusOptionImpl;

  factory _StatusOption.fromJson(Map<String, dynamic> json) =
      _$StatusOptionImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get color;

  /// Create a copy of StatusOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusOptionImplCopyWith<_$StatusOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusGroup _$StatusGroupFromJson(Map<String, dynamic> json) {
  return _StatusGroup.fromJson(json);
}

/// @nodoc
mixin _$StatusGroup {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get color =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  List<String> get option_ids => throw _privateConstructorUsedError;

  /// Serializes this StatusGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusGroupCopyWith<StatusGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusGroupCopyWith<$Res> {
  factory $StatusGroupCopyWith(
          StatusGroup value, $Res Function(StatusGroup) then) =
      _$StatusGroupCopyWithImpl<$Res, StatusGroup>;
  @useResult
  $Res call({String id, String name, String? color, List<String> option_ids});
}

/// @nodoc
class _$StatusGroupCopyWithImpl<$Res, $Val extends StatusGroup>
    implements $StatusGroupCopyWith<$Res> {
  _$StatusGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = freezed,
    Object? option_ids = null,
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
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      option_ids: null == option_ids
          ? _value.option_ids
          : option_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusGroupImplCopyWith<$Res>
    implements $StatusGroupCopyWith<$Res> {
  factory _$$StatusGroupImplCopyWith(
          _$StatusGroupImpl value, $Res Function(_$StatusGroupImpl) then) =
      __$$StatusGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? color, List<String> option_ids});
}

/// @nodoc
class __$$StatusGroupImplCopyWithImpl<$Res>
    extends _$StatusGroupCopyWithImpl<$Res, _$StatusGroupImpl>
    implements _$$StatusGroupImplCopyWith<$Res> {
  __$$StatusGroupImplCopyWithImpl(
      _$StatusGroupImpl _value, $Res Function(_$StatusGroupImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = freezed,
    Object? option_ids = null,
  }) {
    return _then(_$StatusGroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      option_ids: null == option_ids
          ? _value._option_ids
          : option_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusGroupImpl implements _StatusGroup {
  const _$StatusGroupImpl(
      {required this.id,
      required this.name,
      required this.color,
      required final List<String> option_ids})
      : _option_ids = option_ids;

  factory _$StatusGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusGroupImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? color;
// ignore: non_constant_identifier_names
  final List<String> _option_ids;
// ignore: non_constant_identifier_names
  @override
  List<String> get option_ids {
    if (_option_ids is EqualUnmodifiableListView) return _option_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_option_ids);
  }

  @override
  String toString() {
    return 'StatusGroup(id: $id, name: $name, color: $color, option_ids: $option_ids)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality()
                .equals(other._option_ids, _option_ids));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, color,
      const DeepCollectionEquality().hash(_option_ids));

  /// Create a copy of StatusGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusGroupImplCopyWith<_$StatusGroupImpl> get copyWith =>
      __$$StatusGroupImplCopyWithImpl<_$StatusGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusGroupImplToJson(
      this,
    );
  }
}

abstract class _StatusGroup implements StatusGroup {
  const factory _StatusGroup(
      {required final String id,
      required final String name,
      required final String? color,
      required final List<String> option_ids}) = _$StatusGroupImpl;

  factory _StatusGroup.fromJson(Map<String, dynamic> json) =
      _$StatusGroupImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get color; // ignore: non_constant_identifier_names
  @override
  List<String> get option_ids;

  /// Create a copy of StatusGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusGroupImplCopyWith<_$StatusGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
