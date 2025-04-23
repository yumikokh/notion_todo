// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskServiceHash() => r'667960f51ff6875bab9c730e1dbccae2663a4389';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [taskService].
@ProviderFor(taskService)
const taskServiceProvider = TaskServiceFamily();

/// See also [taskService].
class TaskServiceFamily extends Family<AsyncValue<TaskService?>> {
  /// See also [taskService].
  const TaskServiceFamily();

  /// See also [taskService].
  TaskServiceProvider call(
    TaskDatabase? taskDatabase,
  ) {
    return TaskServiceProvider(
      taskDatabase,
    );
  }

  @override
  TaskServiceProvider getProviderOverride(
    covariant TaskServiceProvider provider,
  ) {
    return call(
      provider.taskDatabase,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'taskServiceProvider';
}

/// See also [taskService].
class TaskServiceProvider extends AutoDisposeFutureProvider<TaskService?> {
  /// See also [taskService].
  TaskServiceProvider(
    TaskDatabase? taskDatabase,
  ) : this._internal(
          (ref) => taskService(
            ref as TaskServiceRef,
            taskDatabase,
          ),
          from: taskServiceProvider,
          name: r'taskServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskServiceHash,
          dependencies: TaskServiceFamily._dependencies,
          allTransitiveDependencies:
              TaskServiceFamily._allTransitiveDependencies,
          taskDatabase: taskDatabase,
        );

  TaskServiceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskDatabase,
  }) : super.internal();

  final TaskDatabase? taskDatabase;

  @override
  Override overrideWith(
    FutureOr<TaskService?> Function(TaskServiceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TaskServiceProvider._internal(
        (ref) => create(ref as TaskServiceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskDatabase: taskDatabase,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TaskService?> createElement() {
    return _TaskServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskServiceProvider && other.taskDatabase == taskDatabase;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskDatabase.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TaskServiceRef on AutoDisposeFutureProviderRef<TaskService?> {
  /// The parameter `taskDatabase` of this provider.
  TaskDatabase? get taskDatabase;
}

class _TaskServiceProviderElement
    extends AutoDisposeFutureProviderElement<TaskService?> with TaskServiceRef {
  _TaskServiceProviderElement(super.provider);

  @override
  TaskDatabase? get taskDatabase =>
      (origin as TaskServiceProvider).taskDatabase;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
