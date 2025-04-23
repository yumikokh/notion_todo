// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notion_task_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notionTaskRepositoryHash() =>
    r'047bb6a66b9085d71752efed2f0c9988fdb83c3d';

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

/// See also [notionTaskRepository].
@ProviderFor(notionTaskRepository)
const notionTaskRepositoryProvider = NotionTaskRepositoryFamily();

/// See also [notionTaskRepository].
class NotionTaskRepositoryFamily extends Family<NotionTaskRepository?> {
  /// See also [notionTaskRepository].
  const NotionTaskRepositoryFamily();

  /// See also [notionTaskRepository].
  NotionTaskRepositoryProvider call(
    TaskDatabase? taskDatabase,
  ) {
    return NotionTaskRepositoryProvider(
      taskDatabase,
    );
  }

  @override
  NotionTaskRepositoryProvider getProviderOverride(
    covariant NotionTaskRepositoryProvider provider,
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
  String? get name => r'notionTaskRepositoryProvider';
}

/// See also [notionTaskRepository].
class NotionTaskRepositoryProvider
    extends AutoDisposeProvider<NotionTaskRepository?> {
  /// See also [notionTaskRepository].
  NotionTaskRepositoryProvider(
    TaskDatabase? taskDatabase,
  ) : this._internal(
          (ref) => notionTaskRepository(
            ref as NotionTaskRepositoryRef,
            taskDatabase,
          ),
          from: notionTaskRepositoryProvider,
          name: r'notionTaskRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$notionTaskRepositoryHash,
          dependencies: NotionTaskRepositoryFamily._dependencies,
          allTransitiveDependencies:
              NotionTaskRepositoryFamily._allTransitiveDependencies,
          taskDatabase: taskDatabase,
        );

  NotionTaskRepositoryProvider._internal(
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
    NotionTaskRepository? Function(NotionTaskRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NotionTaskRepositoryProvider._internal(
        (ref) => create(ref as NotionTaskRepositoryRef),
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
  AutoDisposeProviderElement<NotionTaskRepository?> createElement() {
    return _NotionTaskRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NotionTaskRepositoryProvider &&
        other.taskDatabase == taskDatabase;
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
mixin NotionTaskRepositoryRef on AutoDisposeProviderRef<NotionTaskRepository?> {
  /// The parameter `taskDatabase` of this provider.
  TaskDatabase? get taskDatabase;
}

class _NotionTaskRepositoryProviderElement
    extends AutoDisposeProviderElement<NotionTaskRepository?>
    with NotionTaskRepositoryRef {
  _NotionTaskRepositoryProviderElement(super.provider);

  @override
  TaskDatabase? get taskDatabase =>
      (origin as NotionTaskRepositoryProvider).taskDatabase;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
