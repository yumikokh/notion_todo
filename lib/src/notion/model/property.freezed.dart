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
  PropertyType get type => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String name, PropertyType type, DateTime? date)
        date,
    required TResult Function(
            String id, String name, PropertyType type, bool checked)
        checkbox,
    required TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)
        status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String name, PropertyType type, DateTime? date)?
        date,
    TResult? Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult? Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String name, PropertyType type, DateTime? date)?
        date,
    TResult Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DateProperty value) date,
    required TResult Function(CheckboxProperty value) checkbox,
    required TResult Function(StatusProperty value) status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DateProperty value)? date,
    TResult? Function(CheckboxProperty value)? checkbox,
    TResult? Function(StatusProperty value)? status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
  $Res call({String id, String name, PropertyType type});
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
abstract class _$$DatePropertyImplCopyWith<$Res>
    implements $PropertyCopyWith<$Res> {
  factory _$$DatePropertyImplCopyWith(
          _$DatePropertyImpl value, $Res Function(_$DatePropertyImpl) then) =
      __$$DatePropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, PropertyType type, DateTime? date});
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
    Object? type = null,
    Object? date = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PropertyType,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DatePropertyImpl implements DateProperty {
  const _$DatePropertyImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.date,
      final String? $type})
      : $type = $type ?? 'date';

  factory _$DatePropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$DatePropertyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final PropertyType type;
// 省略したい
  @override
  final DateTime? date;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Property.date(id: $id, name: $name, type: $type, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatePropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, date);

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
            String id, String name, PropertyType type, DateTime? date)
        date,
    required TResult Function(
            String id, String name, PropertyType type, bool checked)
        checkbox,
    required TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)
        status,
  }) {
    return date(id, name, type, this.date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String name, PropertyType type, DateTime? date)?
        date,
    TResult? Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult? Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
  }) {
    return date?.call(id, name, type, this.date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String name, PropertyType type, DateTime? date)?
        date,
    TResult Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
    required TResult orElse(),
  }) {
    if (date != null) {
      return date(id, name, type, this.date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DateProperty value) date,
    required TResult Function(CheckboxProperty value) checkbox,
    required TResult Function(StatusProperty value) status,
  }) {
    return date(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DateProperty value)? date,
    TResult? Function(CheckboxProperty value)? checkbox,
    TResult? Function(StatusProperty value)? status,
  }) {
    return date?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
      required final PropertyType type,
      required final DateTime? date}) = _$DatePropertyImpl;

  factory DateProperty.fromJson(Map<String, dynamic> json) =
      _$DatePropertyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  PropertyType get type; // 省略したい
  DateTime? get date;

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
  $Res call({String id, String name, PropertyType type, bool checked});
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
    Object? type = null,
    Object? checked = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PropertyType,
      checked: null == checked
          ? _value.checked
          : checked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckboxPropertyImpl implements CheckboxProperty {
  const _$CheckboxPropertyImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.checked,
      final String? $type})
      : $type = $type ?? 'checkbox';

  factory _$CheckboxPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckboxPropertyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final PropertyType type;
  @override
  final bool checked;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Property.checkbox(id: $id, name: $name, type: $type, checked: $checked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckboxPropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.checked, checked) || other.checked == checked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, checked);

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
            String id, String name, PropertyType type, DateTime? date)
        date,
    required TResult Function(
            String id, String name, PropertyType type, bool checked)
        checkbox,
    required TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)
        status,
  }) {
    return checkbox(id, name, type, checked);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String name, PropertyType type, DateTime? date)?
        date,
    TResult? Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult? Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
  }) {
    return checkbox?.call(id, name, type, checked);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String name, PropertyType type, DateTime? date)?
        date,
    TResult Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
    required TResult orElse(),
  }) {
    if (checkbox != null) {
      return checkbox(id, name, type, checked);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DateProperty value) date,
    required TResult Function(CheckboxProperty value) checkbox,
    required TResult Function(StatusProperty value) status,
  }) {
    return checkbox(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DateProperty value)? date,
    TResult? Function(CheckboxProperty value)? checkbox,
    TResult? Function(StatusProperty value)? status,
  }) {
    return checkbox?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
      required final PropertyType type,
      required final bool checked}) = _$CheckboxPropertyImpl;

  factory CheckboxProperty.fromJson(Map<String, dynamic> json) =
      _$CheckboxPropertyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  PropertyType get type;
  bool get checked;

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
      PropertyType type,
      ({List<StatusGroup> groups, List<StatusOption> options}) status});
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
    Object? type = null,
    Object? status = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PropertyType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ({List<StatusGroup> groups, List<StatusOption> options}),
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusPropertyImpl implements StatusProperty {
  const _$StatusPropertyImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.status,
      final String? $type})
      : $type = $type ?? 'status';

  factory _$StatusPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusPropertyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final PropertyType type;
  @override
  final ({List<StatusGroup> groups, List<StatusOption> options}) status;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Property.status(id: $id, name: $name, type: $type, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusPropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, status);

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
            String id, String name, PropertyType type, DateTime? date)
        date,
    required TResult Function(
            String id, String name, PropertyType type, bool checked)
        checkbox,
    required TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)
        status,
  }) {
    return status(id, name, type, this.status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String name, PropertyType type, DateTime? date)?
        date,
    TResult? Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult? Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
  }) {
    return status?.call(id, name, type, this.status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String name, PropertyType type, DateTime? date)?
        date,
    TResult Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
    required TResult orElse(),
  }) {
    if (status != null) {
      return status(id, name, type, this.status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DateProperty value) date,
    required TResult Function(CheckboxProperty value) checkbox,
    required TResult Function(StatusProperty value) status,
  }) {
    return status(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DateProperty value)? date,
    TResult? Function(CheckboxProperty value)? checkbox,
    TResult? Function(StatusProperty value)? status,
  }) {
    return status?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
      required final PropertyType type,
      required final ({
        List<StatusGroup> groups,
        List<StatusOption> options
      }) status}) = _$StatusPropertyImpl;

  factory StatusProperty.fromJson(Map<String, dynamic> json) =
      _$StatusPropertyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  PropertyType get type;
  ({List<StatusGroup> groups, List<StatusOption> options}) get status;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusPropertyImplCopyWith<_$StatusPropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskDateProperty _$TaskDatePropertyFromJson(Map<String, dynamic> json) {
  return _TaskDateProperty.fromJson(json);
}

/// @nodoc
mixin _$TaskDateProperty {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  PropertyType get type => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;

  /// Serializes this TaskDateProperty to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskDateProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskDatePropertyCopyWith<TaskDateProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDatePropertyCopyWith<$Res> {
  factory $TaskDatePropertyCopyWith(
          TaskDateProperty value, $Res Function(TaskDateProperty) then) =
      _$TaskDatePropertyCopyWithImpl<$Res, TaskDateProperty>;
  @useResult
  $Res call({String id, String name, PropertyType type, DateTime? date});
}

/// @nodoc
class _$TaskDatePropertyCopyWithImpl<$Res, $Val extends TaskDateProperty>
    implements $TaskDatePropertyCopyWith<$Res> {
  _$TaskDatePropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskDateProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? date = freezed,
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
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskDatePropertyImplCopyWith<$Res>
    implements $TaskDatePropertyCopyWith<$Res> {
  factory _$$TaskDatePropertyImplCopyWith(_$TaskDatePropertyImpl value,
          $Res Function(_$TaskDatePropertyImpl) then) =
      __$$TaskDatePropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, PropertyType type, DateTime? date});
}

/// @nodoc
class __$$TaskDatePropertyImplCopyWithImpl<$Res>
    extends _$TaskDatePropertyCopyWithImpl<$Res, _$TaskDatePropertyImpl>
    implements _$$TaskDatePropertyImplCopyWith<$Res> {
  __$$TaskDatePropertyImplCopyWithImpl(_$TaskDatePropertyImpl _value,
      $Res Function(_$TaskDatePropertyImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskDateProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? date = freezed,
  }) {
    return _then(_$TaskDatePropertyImpl(
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
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskDatePropertyImpl implements _TaskDateProperty {
  const _$TaskDatePropertyImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.date});

  factory _$TaskDatePropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskDatePropertyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final PropertyType type;
  @override
  final DateTime? date;

  @override
  String toString() {
    return 'TaskDateProperty(id: $id, name: $name, type: $type, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskDatePropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, date);

  /// Create a copy of TaskDateProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDatePropertyImplCopyWith<_$TaskDatePropertyImpl> get copyWith =>
      __$$TaskDatePropertyImplCopyWithImpl<_$TaskDatePropertyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskDatePropertyImplToJson(
      this,
    );
  }
}

abstract class _TaskDateProperty implements TaskDateProperty {
  const factory _TaskDateProperty(
      {required final String id,
      required final String name,
      required final PropertyType type,
      required final DateTime? date}) = _$TaskDatePropertyImpl;

  factory _TaskDateProperty.fromJson(Map<String, dynamic> json) =
      _$TaskDatePropertyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  PropertyType get type;
  @override
  DateTime? get date;

  /// Create a copy of TaskDateProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskDatePropertyImplCopyWith<_$TaskDatePropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskStatusProperty _$TaskStatusPropertyFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'checkbox':
      return CheckboxTaskStatusProperty.fromJson(json);
    case 'status':
      return StatusTaskStatusProperty.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'TaskStatusProperty',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$TaskStatusProperty {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  PropertyType get type => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String name, PropertyType type, bool checked)
        checkbox,
    required TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)
        status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult? Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckboxTaskStatusProperty value) checkbox,
    required TResult Function(StatusTaskStatusProperty value) status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckboxTaskStatusProperty value)? checkbox,
    TResult? Function(StatusTaskStatusProperty value)? status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckboxTaskStatusProperty value)? checkbox,
    TResult Function(StatusTaskStatusProperty value)? status,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this TaskStatusProperty to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskStatusPropertyCopyWith<TaskStatusProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskStatusPropertyCopyWith<$Res> {
  factory $TaskStatusPropertyCopyWith(
          TaskStatusProperty value, $Res Function(TaskStatusProperty) then) =
      _$TaskStatusPropertyCopyWithImpl<$Res, TaskStatusProperty>;
  @useResult
  $Res call({String id, String name, PropertyType type});
}

/// @nodoc
class _$TaskStatusPropertyCopyWithImpl<$Res, $Val extends TaskStatusProperty>
    implements $TaskStatusPropertyCopyWith<$Res> {
  _$TaskStatusPropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskStatusProperty
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
abstract class _$$CheckboxTaskStatusPropertyImplCopyWith<$Res>
    implements $TaskStatusPropertyCopyWith<$Res> {
  factory _$$CheckboxTaskStatusPropertyImplCopyWith(
          _$CheckboxTaskStatusPropertyImpl value,
          $Res Function(_$CheckboxTaskStatusPropertyImpl) then) =
      __$$CheckboxTaskStatusPropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, PropertyType type, bool checked});
}

/// @nodoc
class __$$CheckboxTaskStatusPropertyImplCopyWithImpl<$Res>
    extends _$TaskStatusPropertyCopyWithImpl<$Res,
        _$CheckboxTaskStatusPropertyImpl>
    implements _$$CheckboxTaskStatusPropertyImplCopyWith<$Res> {
  __$$CheckboxTaskStatusPropertyImplCopyWithImpl(
      _$CheckboxTaskStatusPropertyImpl _value,
      $Res Function(_$CheckboxTaskStatusPropertyImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? checked = null,
  }) {
    return _then(_$CheckboxTaskStatusPropertyImpl(
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
      checked: null == checked
          ? _value.checked
          : checked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckboxTaskStatusPropertyImpl implements CheckboxTaskStatusProperty {
  const _$CheckboxTaskStatusPropertyImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.checked,
      final String? $type})
      : $type = $type ?? 'checkbox';

  factory _$CheckboxTaskStatusPropertyImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CheckboxTaskStatusPropertyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final PropertyType type;
  @override
  final bool checked;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TaskStatusProperty.checkbox(id: $id, name: $name, type: $type, checked: $checked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckboxTaskStatusPropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.checked, checked) || other.checked == checked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, checked);

  /// Create a copy of TaskStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckboxTaskStatusPropertyImplCopyWith<_$CheckboxTaskStatusPropertyImpl>
      get copyWith => __$$CheckboxTaskStatusPropertyImplCopyWithImpl<
          _$CheckboxTaskStatusPropertyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String name, PropertyType type, bool checked)
        checkbox,
    required TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)
        status,
  }) {
    return checkbox(id, name, type, checked);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult? Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
  }) {
    return checkbox?.call(id, name, type, checked);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
    required TResult orElse(),
  }) {
    if (checkbox != null) {
      return checkbox(id, name, type, checked);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckboxTaskStatusProperty value) checkbox,
    required TResult Function(StatusTaskStatusProperty value) status,
  }) {
    return checkbox(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckboxTaskStatusProperty value)? checkbox,
    TResult? Function(StatusTaskStatusProperty value)? status,
  }) {
    return checkbox?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckboxTaskStatusProperty value)? checkbox,
    TResult Function(StatusTaskStatusProperty value)? status,
    required TResult orElse(),
  }) {
    if (checkbox != null) {
      return checkbox(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckboxTaskStatusPropertyImplToJson(
      this,
    );
  }
}

abstract class CheckboxTaskStatusProperty implements TaskStatusProperty {
  const factory CheckboxTaskStatusProperty(
      {required final String id,
      required final String name,
      required final PropertyType type,
      required final bool checked}) = _$CheckboxTaskStatusPropertyImpl;

  factory CheckboxTaskStatusProperty.fromJson(Map<String, dynamic> json) =
      _$CheckboxTaskStatusPropertyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  PropertyType get type;
  bool get checked;

  /// Create a copy of TaskStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckboxTaskStatusPropertyImplCopyWith<_$CheckboxTaskStatusPropertyImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StatusTaskStatusPropertyImplCopyWith<$Res>
    implements $TaskStatusPropertyCopyWith<$Res> {
  factory _$$StatusTaskStatusPropertyImplCopyWith(
          _$StatusTaskStatusPropertyImpl value,
          $Res Function(_$StatusTaskStatusPropertyImpl) then) =
      __$$StatusTaskStatusPropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      PropertyType type,
      ({List<StatusGroup> groups, List<StatusOption> options}) status});
}

/// @nodoc
class __$$StatusTaskStatusPropertyImplCopyWithImpl<$Res>
    extends _$TaskStatusPropertyCopyWithImpl<$Res,
        _$StatusTaskStatusPropertyImpl>
    implements _$$StatusTaskStatusPropertyImplCopyWith<$Res> {
  __$$StatusTaskStatusPropertyImplCopyWithImpl(
      _$StatusTaskStatusPropertyImpl _value,
      $Res Function(_$StatusTaskStatusPropertyImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? status = null,
  }) {
    return _then(_$StatusTaskStatusPropertyImpl(
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ({List<StatusGroup> groups, List<StatusOption> options}),
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusTaskStatusPropertyImpl implements StatusTaskStatusProperty {
  const _$StatusTaskStatusPropertyImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.status,
      final String? $type})
      : $type = $type ?? 'status';

  factory _$StatusTaskStatusPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusTaskStatusPropertyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final PropertyType type;
  @override
  final ({List<StatusGroup> groups, List<StatusOption> options}) status;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TaskStatusProperty.status(id: $id, name: $name, type: $type, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusTaskStatusPropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, status);

  /// Create a copy of TaskStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusTaskStatusPropertyImplCopyWith<_$StatusTaskStatusPropertyImpl>
      get copyWith => __$$StatusTaskStatusPropertyImplCopyWithImpl<
          _$StatusTaskStatusPropertyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String name, PropertyType type, bool checked)
        checkbox,
    required TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)
        status,
  }) {
    return status(id, name, type, this.status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult? Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
  }) {
    return status?.call(id, name, type, this.status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String name, PropertyType type, bool checked)?
        checkbox,
    TResult Function(String id, String name, PropertyType type,
            ({List<StatusGroup> groups, List<StatusOption> options}) status)?
        status,
    required TResult orElse(),
  }) {
    if (status != null) {
      return status(id, name, type, this.status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckboxTaskStatusProperty value) checkbox,
    required TResult Function(StatusTaskStatusProperty value) status,
  }) {
    return status(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckboxTaskStatusProperty value)? checkbox,
    TResult? Function(StatusTaskStatusProperty value)? status,
  }) {
    return status?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckboxTaskStatusProperty value)? checkbox,
    TResult Function(StatusTaskStatusProperty value)? status,
    required TResult orElse(),
  }) {
    if (status != null) {
      return status(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusTaskStatusPropertyImplToJson(
      this,
    );
  }
}

abstract class StatusTaskStatusProperty implements TaskStatusProperty {
  const factory StatusTaskStatusProperty(
      {required final String id,
      required final String name,
      required final PropertyType type,
      required final ({
        List<StatusGroup> groups,
        List<StatusOption> options
      }) status}) = _$StatusTaskStatusPropertyImpl;

  factory StatusTaskStatusProperty.fromJson(Map<String, dynamic> json) =
      _$StatusTaskStatusPropertyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  PropertyType get type;
  ({List<StatusGroup> groups, List<StatusOption> options}) get status;

  /// Create a copy of TaskStatusProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusTaskStatusPropertyImplCopyWith<_$StatusTaskStatusPropertyImpl>
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
  String? get color => throw _privateConstructorUsedError;
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
  final List<String> _option_ids;
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
  String? get color;
  @override
  List<String> get option_ids;

  /// Create a copy of StatusGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusGroupImplCopyWith<_$StatusGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
