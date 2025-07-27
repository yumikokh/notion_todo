// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_group_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskGroupServiceHash() => r'58ed86a0edbb8be593bab176853d489db14f9a36';

/// See also [taskGroupService].
@ProviderFor(taskGroupService)
final taskGroupServiceProvider = Provider<TaskGroupService>.internal(
  taskGroupService,
  name: r'taskGroupServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskGroupServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskGroupServiceRef = ProviderRef<TaskGroupService>;
String _$currentGroupTypeHash() => r'bb0dc2172ecc55c395cccd52f8c2e83c68d16473';

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

/// See also [currentGroupType].
@ProviderFor(currentGroupType)
const currentGroupTypeProvider = CurrentGroupTypeFamily();

/// See also [currentGroupType].
class CurrentGroupTypeFamily extends Family<GroupType> {
  /// See also [currentGroupType].
  const CurrentGroupTypeFamily();

  /// See also [currentGroupType].
  CurrentGroupTypeProvider call(
    FilterType filterType,
  ) {
    return CurrentGroupTypeProvider(
      filterType,
    );
  }

  @override
  CurrentGroupTypeProvider getProviderOverride(
    covariant CurrentGroupTypeProvider provider,
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
  String? get name => r'currentGroupTypeProvider';
}

/// See also [currentGroupType].
class CurrentGroupTypeProvider extends AutoDisposeProvider<GroupType> {
  /// See also [currentGroupType].
  CurrentGroupTypeProvider(
    FilterType filterType,
  ) : this._internal(
          (ref) => currentGroupType(
            ref as CurrentGroupTypeRef,
            filterType,
          ),
          from: currentGroupTypeProvider,
          name: r'currentGroupTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentGroupTypeHash,
          dependencies: CurrentGroupTypeFamily._dependencies,
          allTransitiveDependencies:
              CurrentGroupTypeFamily._allTransitiveDependencies,
          filterType: filterType,
        );

  CurrentGroupTypeProvider._internal(
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
    GroupType Function(CurrentGroupTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CurrentGroupTypeProvider._internal(
        (ref) => create(ref as CurrentGroupTypeRef),
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
  AutoDisposeProviderElement<GroupType> createElement() {
    return _CurrentGroupTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentGroupTypeProvider && other.filterType == filterType;
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
mixin CurrentGroupTypeRef on AutoDisposeProviderRef<GroupType> {
  /// The parameter `filterType` of this provider.
  FilterType get filterType;
}

class _CurrentGroupTypeProviderElement
    extends AutoDisposeProviderElement<GroupType> with CurrentGroupTypeRef {
  _CurrentGroupTypeProviderElement(super.provider);

  @override
  FilterType get filterType => (origin as CurrentGroupTypeProvider).filterType;
}

String _$taskGroupHash() => r'b64c85bd5ec5e93652368af168bc99a4e87678b5';

/// See also [TaskGroup].
@ProviderFor(TaskGroup)
final taskGroupProvider = AutoDisposeAsyncNotifierProvider<TaskGroup,
    Map<FilterType, GroupType>>.internal(
  TaskGroup.new,
  name: r'taskGroupProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskGroupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskGroup = AutoDisposeAsyncNotifier<Map<FilterType, GroupType>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
