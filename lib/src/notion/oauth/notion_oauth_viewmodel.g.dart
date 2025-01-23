// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notion_oauth_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isAuthenticatedHash() => r'c264a31851cba76e0b25ceec03d1498df1f6004c';

/// See also [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeProvider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAuthenticatedRef = AutoDisposeProviderRef<bool>;
String _$notionOAuthViewModelHash() =>
    r'd32276b539cf96094e9c829c8097005ed58aeab2';

/// See also [NotionOAuthViewModel].
@ProviderFor(NotionOAuthViewModel)
final notionOAuthViewModelProvider = AutoDisposeAsyncNotifierProvider<
    NotionOAuthViewModel, NotionOAuth>.internal(
  NotionOAuthViewModel.new,
  name: r'notionOAuthViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notionOAuthViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotionOAuthViewModel = AutoDisposeAsyncNotifier<NotionOAuth>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
