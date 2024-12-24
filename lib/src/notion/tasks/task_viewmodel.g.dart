// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskViewModelHash() => r'49c967801b559cf35e9b5aa4126d5207358e46be';

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
  late final BuildContext context;

  FutureOr<List<Task>> build({
    FilterType filterType = FilterType.all,
    required BuildContext context,
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
    required BuildContext context,
  }) {
    return TaskViewModelProvider(
      filterType: filterType,
      context: context,
    );
  }

  @override
  TaskViewModelProvider getProviderOverride(
    covariant TaskViewModelProvider provider,
  ) {
    return call(
      filterType: provider.filterType,
      context: provider.context,
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
    required BuildContext context,
  }) : this._internal(
          () => TaskViewModel()
            ..filterType = filterType
            ..context = context,
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
          context: context,
        );

  TaskViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filterType,
    required this.context,
  }) : super.internal();

  final FilterType filterType;
  final BuildContext context;

  @override
  FutureOr<List<Task>> runNotifierBuild(
    covariant TaskViewModel notifier,
  ) {
    return notifier.build(
      filterType: filterType,
      context: context,
    );
  }

  @override
  Override overrideWith(TaskViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskViewModelProvider._internal(
        () => create()
          ..filterType = filterType
          ..context = context,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filterType: filterType,
        context: context,
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
    return other is TaskViewModelProvider &&
        other.filterType == filterType &&
        other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filterType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TaskViewModelRef on AutoDisposeAsyncNotifierProviderRef<List<Task>> {
  /// The parameter `filterType` of this provider.
  FilterType get filterType;

  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _TaskViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TaskViewModel, List<Task>>
    with TaskViewModelRef {
  _TaskViewModelProviderElement(super.provider);

  @override
  FilterType get filterType => (origin as TaskViewModelProvider).filterType;
  @override
  BuildContext get context => (origin as TaskViewModelProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
