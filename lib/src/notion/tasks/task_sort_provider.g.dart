// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_sort_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskSortService)
const taskSortServiceProvider = TaskSortServiceProvider._();

final class TaskSortServiceProvider
    extends
        $FunctionalProvider<TaskSortService, TaskSortService, TaskSortService>
    with $Provider<TaskSortService> {
  const TaskSortServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskSortServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskSortServiceHash();

  @$internal
  @override
  $ProviderElement<TaskSortService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskSortService create(Ref ref) {
    return taskSortService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskSortService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskSortService>(value),
    );
  }
}

String _$taskSortServiceHash() => r'171f4f0d04b9f0f266d8a62a6c008a756e31e03c';

@ProviderFor(TaskSort)
const taskSortProvider = TaskSortProvider._();

final class TaskSortProvider
    extends $AsyncNotifierProvider<TaskSort, Map<FilterType, SortType>> {
  const TaskSortProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskSortProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskSortHash();

  @$internal
  @override
  TaskSort create() => TaskSort();
}

String _$taskSortHash() => r'cbc9476e569ac79978fc4b189a3fd63871326c34';

abstract class _$TaskSort extends $AsyncNotifier<Map<FilterType, SortType>> {
  FutureOr<Map<FilterType, SortType>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<FilterType, SortType>>,
              Map<FilterType, SortType>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<FilterType, SortType>>,
                Map<FilterType, SortType>
              >,
              AsyncValue<Map<FilterType, SortType>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(currentSortType)
const currentSortTypeProvider = CurrentSortTypeFamily._();

final class CurrentSortTypeProvider
    extends $FunctionalProvider<SortType, SortType, SortType>
    with $Provider<SortType> {
  const CurrentSortTypeProvider._({
    required CurrentSortTypeFamily super.from,
    required FilterType super.argument,
  }) : super(
         retry: null,
         name: r'currentSortTypeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentSortTypeHash();

  @override
  String toString() {
    return r'currentSortTypeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<SortType> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SortType create(Ref ref) {
    final argument = this.argument as FilterType;
    return currentSortType(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SortType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SortType>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentSortTypeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentSortTypeHash() => r'260f8a1f2bb85d8b97cbee325b5d8b1fe826afb9';

final class CurrentSortTypeFamily extends $Family
    with $FunctionalFamilyOverride<SortType, FilterType> {
  const CurrentSortTypeFamily._()
    : super(
        retry: null,
        name: r'currentSortTypeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CurrentSortTypeProvider call(FilterType filterType) =>
      CurrentSortTypeProvider._(argument: filterType, from: this);

  @override
  String toString() => r'currentSortTypeProvider';
}
