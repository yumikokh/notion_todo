// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toggl_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TogglState {
  bool get isConfigured => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<TogglWorkspace> get workspaces => throw _privateConstructorUsedError;
  List<TogglProject> get projects => throw _privateConstructorUsedError;
  TogglTimeEntry? get currentTimeEntry => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get apiToken => throw _privateConstructorUsedError;
  int? get workspaceId => throw _privateConstructorUsedError;
  int? get projectId => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TogglStateCopyWith<TogglState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TogglStateCopyWith<$Res> {
  factory $TogglStateCopyWith(
          TogglState value, $Res Function(TogglState) then) =
      _$TogglStateCopyWithImpl<$Res, TogglState>;
  @useResult
  $Res call(
      {bool isConfigured,
      bool isLoading,
      List<TogglWorkspace> workspaces,
      List<TogglProject> projects,
      TogglTimeEntry? currentTimeEntry,
      String? error,
      String? apiToken,
      int? workspaceId,
      int? projectId,
      bool enabled});
}

/// @nodoc
class _$TogglStateCopyWithImpl<$Res, $Val extends TogglState>
    implements $TogglStateCopyWith<$Res> {
  _$TogglStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConfigured = null,
    Object? isLoading = null,
    Object? workspaces = null,
    Object? projects = null,
    Object? currentTimeEntry = freezed,
    Object? error = freezed,
    Object? apiToken = freezed,
    Object? workspaceId = freezed,
    Object? projectId = freezed,
    Object? enabled = null,
  }) {
    return _then(_value.copyWith(
      isConfigured: null == isConfigured
          ? _value.isConfigured
          : isConfigured // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      workspaces: null == workspaces
          ? _value.workspaces
          : workspaces // ignore: cast_nullable_to_non_nullable
              as List<TogglWorkspace>,
      projects: null == projects
          ? _value.projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<TogglProject>,
      currentTimeEntry: freezed == currentTimeEntry
          ? _value.currentTimeEntry
          : currentTimeEntry // ignore: cast_nullable_to_non_nullable
              as TogglTimeEntry?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      apiToken: freezed == apiToken
          ? _value.apiToken
          : apiToken // ignore: cast_nullable_to_non_nullable
              as String?,
      workspaceId: freezed == workspaceId
          ? _value.workspaceId
          : workspaceId // ignore: cast_nullable_to_non_nullable
              as int?,
      projectId: freezed == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int?,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TogglStateImplCopyWith<$Res>
    implements $TogglStateCopyWith<$Res> {
  factory _$$TogglStateImplCopyWith(
          _$TogglStateImpl value, $Res Function(_$TogglStateImpl) then) =
      __$$TogglStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isConfigured,
      bool isLoading,
      List<TogglWorkspace> workspaces,
      List<TogglProject> projects,
      TogglTimeEntry? currentTimeEntry,
      String? error,
      String? apiToken,
      int? workspaceId,
      int? projectId,
      bool enabled});
}

/// @nodoc
class __$$TogglStateImplCopyWithImpl<$Res>
    extends _$TogglStateCopyWithImpl<$Res, _$TogglStateImpl>
    implements _$$TogglStateImplCopyWith<$Res> {
  __$$TogglStateImplCopyWithImpl(
      _$TogglStateImpl _value, $Res Function(_$TogglStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConfigured = null,
    Object? isLoading = null,
    Object? workspaces = null,
    Object? projects = null,
    Object? currentTimeEntry = freezed,
    Object? error = freezed,
    Object? apiToken = freezed,
    Object? workspaceId = freezed,
    Object? projectId = freezed,
    Object? enabled = null,
  }) {
    return _then(_$TogglStateImpl(
      isConfigured: null == isConfigured
          ? _value.isConfigured
          : isConfigured // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      workspaces: null == workspaces
          ? _value._workspaces
          : workspaces // ignore: cast_nullable_to_non_nullable
              as List<TogglWorkspace>,
      projects: null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<TogglProject>,
      currentTimeEntry: freezed == currentTimeEntry
          ? _value.currentTimeEntry
          : currentTimeEntry // ignore: cast_nullable_to_non_nullable
              as TogglTimeEntry?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      apiToken: freezed == apiToken
          ? _value.apiToken
          : apiToken // ignore: cast_nullable_to_non_nullable
              as String?,
      workspaceId: freezed == workspaceId
          ? _value.workspaceId
          : workspaceId // ignore: cast_nullable_to_non_nullable
              as int?,
      projectId: freezed == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int?,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TogglStateImpl implements _TogglState {
  const _$TogglStateImpl(
      {this.isConfigured = false,
      this.isLoading = false,
      final List<TogglWorkspace> workspaces = const [],
      final List<TogglProject> projects = const [],
      this.currentTimeEntry,
      this.error,
      this.apiToken,
      this.workspaceId,
      this.projectId,
      this.enabled = false})
      : _workspaces = workspaces,
        _projects = projects;

  @override
  @JsonKey()
  final bool isConfigured;
  @override
  @JsonKey()
  final bool isLoading;
  final List<TogglWorkspace> _workspaces;
  @override
  @JsonKey()
  List<TogglWorkspace> get workspaces {
    if (_workspaces is EqualUnmodifiableListView) return _workspaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workspaces);
  }

  final List<TogglProject> _projects;
  @override
  @JsonKey()
  List<TogglProject> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  final TogglTimeEntry? currentTimeEntry;
  @override
  final String? error;
  @override
  final String? apiToken;
  @override
  final int? workspaceId;
  @override
  final int? projectId;
  @override
  @JsonKey()
  final bool enabled;

  @override
  String toString() {
    return 'TogglState(isConfigured: $isConfigured, isLoading: $isLoading, workspaces: $workspaces, projects: $projects, currentTimeEntry: $currentTimeEntry, error: $error, apiToken: $apiToken, workspaceId: $workspaceId, projectId: $projectId, enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TogglStateImpl &&
            (identical(other.isConfigured, isConfigured) ||
                other.isConfigured == isConfigured) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._workspaces, _workspaces) &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            (identical(other.currentTimeEntry, currentTimeEntry) ||
                other.currentTimeEntry == currentTimeEntry) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.apiToken, apiToken) ||
                other.apiToken == apiToken) &&
            (identical(other.workspaceId, workspaceId) ||
                other.workspaceId == workspaceId) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isConfigured,
      isLoading,
      const DeepCollectionEquality().hash(_workspaces),
      const DeepCollectionEquality().hash(_projects),
      currentTimeEntry,
      error,
      apiToken,
      workspaceId,
      projectId,
      enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TogglStateImplCopyWith<_$TogglStateImpl> get copyWith =>
      __$$TogglStateImplCopyWithImpl<_$TogglStateImpl>(this, _$identity);
}

abstract class _TogglState implements TogglState {
  const factory _TogglState(
      {final bool isConfigured,
      final bool isLoading,
      final List<TogglWorkspace> workspaces,
      final List<TogglProject> projects,
      final TogglTimeEntry? currentTimeEntry,
      final String? error,
      final String? apiToken,
      final int? workspaceId,
      final int? projectId,
      final bool enabled}) = _$TogglStateImpl;

  @override
  bool get isConfigured;
  @override
  bool get isLoading;
  @override
  List<TogglWorkspace> get workspaces;
  @override
  List<TogglProject> get projects;
  @override
  TogglTimeEntry? get currentTimeEntry;
  @override
  String? get error;
  @override
  String? get apiToken;
  @override
  int? get workspaceId;
  @override
  int? get projectId;
  @override
  bool get enabled;
  @override
  @JsonKey(ignore: true)
  _$$TogglStateImplCopyWith<_$TogglStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}