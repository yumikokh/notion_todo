// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_database_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accessibleDatabasesHash() =>
    r'd7b73696d1fd86e85aab0fad3ba9663c76271d61';

/// See also [accessibleDatabases].
@ProviderFor(accessibleDatabases)
final accessibleDatabasesProvider =
    AutoDisposeFutureProvider<List<Database>>.internal(
  accessibleDatabases,
  name: r'accessibleDatabasesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accessibleDatabasesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AccessibleDatabasesRef = AutoDisposeFutureProviderRef<List<Database>>;
String _$propertiesHash() => r'1ab362671e568958d33660daa76f44f82a7974f9';

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

/// See also [properties].
@ProviderFor(properties)
const propertiesProvider = PropertiesFamily();

/// See also [properties].
class PropertiesFamily extends Family<AsyncValue<List<Property>>> {
  /// See also [properties].
  const PropertiesFamily();

  /// See also [properties].
  PropertiesProvider call(
    SettingPropertyType type,
  ) {
    return PropertiesProvider(
      type,
    );
  }

  @override
  PropertiesProvider getProviderOverride(
    covariant PropertiesProvider provider,
  ) {
    return call(
      provider.type,
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
  String? get name => r'propertiesProvider';
}

/// See also [properties].
class PropertiesProvider extends AutoDisposeFutureProvider<List<Property>> {
  /// See also [properties].
  PropertiesProvider(
    SettingPropertyType type,
  ) : this._internal(
          (ref) => properties(
            ref as PropertiesRef,
            type,
          ),
          from: propertiesProvider,
          name: r'propertiesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$propertiesHash,
          dependencies: PropertiesFamily._dependencies,
          allTransitiveDependencies:
              PropertiesFamily._allTransitiveDependencies,
          type: type,
        );

  PropertiesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final SettingPropertyType type;

  @override
  Override overrideWith(
    FutureOr<List<Property>> Function(PropertiesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PropertiesProvider._internal(
        (ref) => create(ref as PropertiesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Property>> createElement() {
    return _PropertiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PropertiesProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PropertiesRef on AutoDisposeFutureProviderRef<List<Property>> {
  /// The parameter `type` of this provider.
  SettingPropertyType get type;
}

class _PropertiesProviderElement
    extends AutoDisposeFutureProviderElement<List<Property>>
    with PropertiesRef {
  _PropertiesProviderElement(super.provider);

  @override
  SettingPropertyType get type => (origin as PropertiesProvider).type;
}

String _$selectedDatabaseViewModelHash() =>
    r'fa673275107b3ec733b006a3ffbb35e1bada7b2d';

/// See also [SelectedDatabaseViewModel].
@ProviderFor(SelectedDatabaseViewModel)
final selectedDatabaseViewModelProvider = AutoDisposeAsyncNotifierProvider<
    SelectedDatabaseViewModel, SelectedDatabaseState?>.internal(
  SelectedDatabaseViewModel.new,
  name: r'selectedDatabaseViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedDatabaseViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedDatabaseViewModel
    = AutoDisposeAsyncNotifier<SelectedDatabaseState?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
