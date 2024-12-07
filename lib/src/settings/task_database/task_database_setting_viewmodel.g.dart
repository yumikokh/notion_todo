// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_database_setting_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accessibleDatabasesHash() =>
    r'0eb3666f800c81d8e42f948e35980c44114cd813';

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
String _$selectedDatabaseViewModelHash() =>
    r'f4727fa4ea116f380ff65694a099752bc177127b';

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
