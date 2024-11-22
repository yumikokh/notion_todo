// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$completedTasksHash() => r'9b1573ba02068440c5abbc67bce1860551a725cb';

/// See also [completedTasks].
@ProviderFor(completedTasks)
final completedTasksProvider = AutoDisposeProvider<List<Task>>.internal(
  completedTasks,
  name: r'completedTasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$completedTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CompletedTasksRef = AutoDisposeProviderRef<List<Task>>;
String _$notCompletedTasksHash() => r'6ab13f9e9f432e5006d8725f9cdd3f9c8fa94bb4';

/// See also [notCompletedTasks].
@ProviderFor(notCompletedTasks)
final notCompletedTasksProvider = AutoDisposeProvider<List<Task>>.internal(
  notCompletedTasks,
  name: r'notCompletedTasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notCompletedTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotCompletedTasksRef = AutoDisposeProviderRef<List<Task>>;
String _$taskViewModelHash() => r'6b03948518801eb3ca762ba4981b04061711a401';

/// See also [TaskViewModel].
@ProviderFor(TaskViewModel)
final taskViewModelProvider =
    AutoDisposeAsyncNotifierProvider<TaskViewModel, List<Task>>.internal(
  TaskViewModel.new,
  name: r'taskViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskViewModel = AutoDisposeAsyncNotifier<List<Task>>;
String _$taskFilterTypeHash() => r'0aac10c1d66b0393902c04228fd0e98dbe8f3456';

/// See also [TaskFilterType].
@ProviderFor(TaskFilterType)
final taskFilterTypeProvider =
    AutoDisposeNotifierProvider<TaskFilterType, FilterType>.internal(
  TaskFilterType.new,
  name: r'taskFilterTypeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskFilterTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskFilterType = AutoDisposeNotifier<FilterType>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
