// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskViewModelHash() => r'33bdf0e32524a391803f2be0fe441d5e7d83423a';

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

abstract class _$TaskViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<Task>> {
  late final FilterType filterType;

  FutureOr<List<Task>> build({
    FilterType filterType = FilterType.all,
  });
}

/// See also [TaskViewModel].
@ProviderFor(TaskViewModel)
const taskViewModelProvider = TaskViewModelFamily();

/// See also [TaskViewModel].
class TaskViewModelFamily extends Family<AsyncValue<List<Task>>> {
  /// See also [TaskViewModel].
  const TaskViewModelFamily();

  /// See also [TaskViewModel].
  TaskViewModelProvider call({
    FilterType filterType = FilterType.all,
  }) {
    return TaskViewModelProvider(
      filterType: filterType,
    );
  }

  @override
  TaskViewModelProvider getProviderOverride(
    covariant TaskViewModelProvider provider,
  ) {
    return call(
      filterType: provider.filterType,
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
  String? get name => r'taskViewModelProvider';
}

/// See also [TaskViewModel].
class TaskViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TaskViewModel, List<Task>> {
  /// See also [TaskViewModel].
  TaskViewModelProvider({
    FilterType filterType = FilterType.all,
  }) : this._internal(
          () => TaskViewModel()..filterType = filterType,
          from: taskViewModelProvider,
          name: r'taskViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskViewModelHash,
          dependencies: TaskViewModelFamily._dependencies,
          allTransitiveDependencies:
              TaskViewModelFamily._allTransitiveDependencies,
          filterType: filterType,
        );

  TaskViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filterType,
  }) : super.internal();

  final FilterType filterType;

  @override
  FutureOr<List<Task>> runNotifierBuild(
    covariant TaskViewModel notifier,
  ) {
    return notifier.build(
      filterType: filterType,
    );
  }

  @override
  Override overrideWith(TaskViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskViewModelProvider._internal(
        () => create()..filterType = filterType,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filterType: filterType,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TaskViewModel, List<Task>>
      createElement() {
    return _TaskViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskViewModelProvider && other.filterType == filterType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filterType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TaskViewModelRef on AutoDisposeAsyncNotifierProviderRef<List<Task>> {
  /// The parameter `filterType` of this provider.
  FilterType get filterType;
}

class _TaskViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TaskViewModel, List<Task>>
    with TaskViewModelRef {
  _TaskViewModelProviderElement(super.provider);

  @override
  FilterType get filterType => (origin as TaskViewModelProvider).filterType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
