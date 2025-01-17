// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notion_oauth_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isAuthenticatedHash() => r'32ce45d615e77d96d6999aedf80fc306186eac64';

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
    r'd106ad7d10168f5b14773b5f467a1ce0f524553a';

/// See also [NotionOAuthViewModel].
@ProviderFor(NotionOAuthViewModel)
final notionOAuthViewModelProvider =
    AutoDisposeNotifierProvider<NotionOAuthViewModel, NotionOAuth>.internal(
  NotionOAuthViewModel.new,
  name: r'notionOAuthViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notionOAuthViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotionOAuthViewModel = AutoDisposeNotifier<NotionOAuth>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
