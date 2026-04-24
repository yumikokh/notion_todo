// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appVersionViewModel)
const appVersionViewModelProvider = AppVersionViewModelProvider._();

final class AppVersionViewModelProvider
    extends
        $FunctionalProvider<
          AppVersionViewModel,
          AppVersionViewModel,
          AppVersionViewModel
        >
    with $Provider<AppVersionViewModel> {
  const AppVersionViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionViewModelHash();

  @$internal
  @override
  $ProviderElement<AppVersionViewModel> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppVersionViewModel create(Ref ref) {
    return appVersionViewModel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppVersionViewModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppVersionViewModel>(value),
    );
  }
}

String _$appVersionViewModelHash() =>
    r'1d3e90b2f73bb46e843d5659fa650b3ba337be5f';
