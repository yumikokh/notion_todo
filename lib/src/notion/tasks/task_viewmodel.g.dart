// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$completedTasksHash() => r'760d982d98463d633ad31d59e6f7accd9622b500';

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
String _$notCompletedTasksHash() => r'5476171d623acab97cbefa1492def954c8c3ca95';

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
String _$taskViewModelHash() => r'9b7baf3266ce989e90a5c7e1f1cab3147dad1c55';

/// See also [TaskViewModel].
@ProviderFor(TaskViewModel)
final taskViewModelProvider =
    AutoDisposeNotifierProvider<TaskViewModel, List<Task>>.internal(
  TaskViewModel.new,
  name: r'taskViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskViewModel = AutoDisposeNotifier<List<Task>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
