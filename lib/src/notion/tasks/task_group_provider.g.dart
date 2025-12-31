// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_group_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskGroupService)
const taskGroupServiceProvider = TaskGroupServiceProvider._();

final class TaskGroupServiceProvider
    extends
        $FunctionalProvider<
          TaskGroupService,
          TaskGroupService,
          TaskGroupService
        >
    with $Provider<TaskGroupService> {
  const TaskGroupServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskGroupServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskGroupServiceHash();

  @$internal
  @override
  $ProviderElement<TaskGroupService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskGroupService create(Ref ref) {
    return taskGroupService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskGroupService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskGroupService>(value),
    );
  }
}

String _$taskGroupServiceHash() => r'58ed86a0edbb8be593bab176853d489db14f9a36';

@ProviderFor(TaskGroup)
const taskGroupProvider = TaskGroupProvider._();

final class TaskGroupProvider
    extends $AsyncNotifierProvider<TaskGroup, Map<FilterType, GroupType>> {
  const TaskGroupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskGroupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskGroupHash();

  @$internal
  @override
  TaskGroup create() => TaskGroup();
}

String _$taskGroupHash() => r'662d5a60d2f2e92472d9d24a7e18526bd021eb62';

abstract class _$TaskGroup extends $AsyncNotifier<Map<FilterType, GroupType>> {
  FutureOr<Map<FilterType, GroupType>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<FilterType, GroupType>>,
              Map<FilterType, GroupType>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<FilterType, GroupType>>,
                Map<FilterType, GroupType>
              >,
              AsyncValue<Map<FilterType, GroupType>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(currentGroupType)
const currentGroupTypeProvider = CurrentGroupTypeFamily._();

final class CurrentGroupTypeProvider
    extends $FunctionalProvider<GroupType, GroupType, GroupType>
    with $Provider<GroupType> {
  const CurrentGroupTypeProvider._({
    required CurrentGroupTypeFamily super.from,
    required FilterType super.argument,
  }) : super(
         retry: null,
         name: r'currentGroupTypeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentGroupTypeHash();

  @override
  String toString() {
    return r'currentGroupTypeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<GroupType> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GroupType create(Ref ref) {
    final argument = this.argument as FilterType;
    return currentGroupType(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GroupType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GroupType>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentGroupTypeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentGroupTypeHash() => r'e5570a31719d7d451e8c9748170feb07d9b95ba7';

final class CurrentGroupTypeFamily extends $Family
    with $FunctionalFamilyOverride<GroupType, FilterType> {
  const CurrentGroupTypeFamily._()
    : super(
        retry: null,
        name: r'currentGroupTypeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CurrentGroupTypeProvider call(FilterType filterType) =>
      CurrentGroupTypeProvider._(argument: filterType, from: this);

  @override
  String toString() => r'currentGroupTypeProvider';
}

/// グループの展開状態を管理するプロバイダー

@ProviderFor(ExpandedGroups)
const expandedGroupsProvider = ExpandedGroupsFamily._();

/// グループの展開状態を管理するプロバイダー
final class ExpandedGroupsProvider
    extends $NotifierProvider<ExpandedGroups, Map<String, bool>> {
  /// グループの展開状態を管理するプロバイダー
  const ExpandedGroupsProvider._({
    required ExpandedGroupsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'expandedGroupsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$expandedGroupsHash();

  @override
  String toString() {
    return r'expandedGroupsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ExpandedGroups create() => ExpandedGroups();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, bool> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, bool>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ExpandedGroupsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$expandedGroupsHash() => r'024ba88bda3d445abe1fcd2b503abe2d672454c9';

/// グループの展開状態を管理するプロバイダー

final class ExpandedGroupsFamily extends $Family
    with
        $ClassFamilyOverride<
          ExpandedGroups,
          Map<String, bool>,
          Map<String, bool>,
          Map<String, bool>,
          String
        > {
  const ExpandedGroupsFamily._()
    : super(
        retry: null,
        name: r'expandedGroupsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// グループの展開状態を管理するプロバイダー

  ExpandedGroupsProvider call(String key) =>
      ExpandedGroupsProvider._(argument: key, from: this);

  @override
  String toString() => r'expandedGroupsProvider';
}

/// グループの展開状態を管理するプロバイダー

abstract class _$ExpandedGroups extends $Notifier<Map<String, bool>> {
  late final _$args = ref.$arg as String;
  String get key => _$args;

  Map<String, bool> build(String key);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<Map<String, bool>, Map<String, bool>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, bool>, Map<String, bool>>,
              Map<String, bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// 「完了タスク」セクションの展開状態を管理するプロバイダー

@ProviderFor(CompletedTasksSectionExpanded)
const completedTasksSectionExpandedProvider =
    CompletedTasksSectionExpandedFamily._();

/// 「完了タスク」セクションの展開状態を管理するプロバイダー
final class CompletedTasksSectionExpandedProvider
    extends $NotifierProvider<CompletedTasksSectionExpanded, bool> {
  /// 「完了タスク」セクションの展開状態を管理するプロバイダー
  const CompletedTasksSectionExpandedProvider._({
    required CompletedTasksSectionExpandedFamily super.from,
    required FilterType super.argument,
  }) : super(
         retry: null,
         name: r'completedTasksSectionExpandedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$completedTasksSectionExpandedHash();

  @override
  String toString() {
    return r'completedTasksSectionExpandedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CompletedTasksSectionExpanded create() => CompletedTasksSectionExpanded();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CompletedTasksSectionExpandedProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$completedTasksSectionExpandedHash() =>
    r'42e0d41d66034086cf5d3134c37ab79dcddb5cf5';

/// 「完了タスク」セクションの展開状態を管理するプロバイダー

final class CompletedTasksSectionExpandedFamily extends $Family
    with
        $ClassFamilyOverride<
          CompletedTasksSectionExpanded,
          bool,
          bool,
          bool,
          FilterType
        > {
  const CompletedTasksSectionExpandedFamily._()
    : super(
        retry: null,
        name: r'completedTasksSectionExpandedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 「完了タスク」セクションの展開状態を管理するプロバイダー

  CompletedTasksSectionExpandedProvider call(FilterType filterType) =>
      CompletedTasksSectionExpandedProvider._(argument: filterType, from: this);

  @override
  String toString() => r'completedTasksSectionExpandedProvider';
}

/// 「完了タスク」セクションの展開状態を管理するプロバイダー

abstract class _$CompletedTasksSectionExpanded extends $Notifier<bool> {
  late final _$args = ref.$arg as FilterType;
  FilterType get filterType => _$args;

  bool build(FilterType filterType);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
