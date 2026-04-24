// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snackbar.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Snackbar)
const snackbarProvider = SnackbarProvider._();

final class SnackbarProvider
    extends $NotifierProvider<Snackbar, SnackbarState?> {
  const SnackbarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'snackbarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$snackbarHash();

  @$internal
  @override
  Snackbar create() => Snackbar();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SnackbarState? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SnackbarState?>(value),
    );
  }
}

String _$snackbarHash() => r'69238bdef18056df4ae8d7425ff0fd5e2a5d4be6';

abstract class _$Snackbar extends $Notifier<SnackbarState?> {
  SnackbarState? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SnackbarState?, SnackbarState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SnackbarState?, SnackbarState?>,
              SnackbarState?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
