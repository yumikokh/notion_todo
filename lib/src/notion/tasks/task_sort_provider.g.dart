// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_sort_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskSortServiceHash() => r'171f4f0d04b9f0f266d8a62a6c008a756e31e03c';

/// See also [taskSortService].
@ProviderFor(taskSortService)
final taskSortServiceProvider = Provider<TaskSortService>.internal(
  taskSortService,
  name: r'taskSortServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskSortServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskSortServiceRef = ProviderRef<TaskSortService>;
String _$currentSortTypeHash() => r'595c6c972cdcfc00cb72e7b02793ec5ea3e31963';

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

/// See also [currentSortType].
@ProviderFor(currentSortType)
const currentSortTypeProvider = CurrentSortTypeFamily();

/// See also [currentSortType].
class CurrentSortTypeFamily extends Family<SortType> {
  /// See also [currentSortType].
  const CurrentSortTypeFamily();

  /// See also [currentSortType].
  CurrentSortTypeProvider call(
    FilterType filterType,
  ) {
    return CurrentSortTypeProvider(
      filterType,
    );
  }

  @override
  CurrentSortTypeProvider getProviderOverride(
    covariant CurrentSortTypeProvider provider,
  ) {
    return call(
      provider.filterType,
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
  String? get name => r'currentSortTypeProvider';
}

/// See also [currentSortType].
class CurrentSortTypeProvider extends AutoDisposeProvider<SortType> {
  /// See also [currentSortType].
  CurrentSortTypeProvider(
    FilterType filterType,
  ) : this._internal(
          (ref) => currentSortType(
            ref as CurrentSortTypeRef,
            filterType,
          ),
          from: currentSortTypeProvider,
          name: r'currentSortTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentSortTypeHash,
          dependencies: CurrentSortTypeFamily._dependencies,
          allTransitiveDependencies:
              CurrentSortTypeFamily._allTransitiveDependencies,
          filterType: filterType,
        );

  CurrentSortTypeProvider._internal(
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
  Override overrideWith(
    SortType Function(CurrentSortTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CurrentSortTypeProvider._internal(
        (ref) => create(ref as CurrentSortTypeRef),
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
  AutoDisposeProviderElement<SortType> createElement() {
    return _CurrentSortTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentSortTypeProvider && other.filterType == filterType;
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
mixin CurrentSortTypeRef on AutoDisposeProviderRef<SortType> {
  /// The parameter `filterType` of this provider.
  FilterType get filterType;
}

class _CurrentSortTypeProviderElement
    extends AutoDisposeProviderElement<SortType> with CurrentSortTypeRef {
  _CurrentSortTypeProviderElement(super.provider);

  @override
  FilterType get filterType => (origin as CurrentSortTypeProvider).filterType;
}

String _$taskSortHash() => r'93586cc150fc3e26617dbd6efbc05e81c6ba0e4d';

/// See also [TaskSort].
@ProviderFor(TaskSort)
final taskSortProvider = AutoDisposeAsyncNotifierProvider<TaskSort,
    Map<FilterType, SortType>>.internal(
  TaskSort.new,
  name: r'taskSortProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskSortHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskSort = AutoDisposeAsyncNotifier<Map<FilterType, SortType>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
