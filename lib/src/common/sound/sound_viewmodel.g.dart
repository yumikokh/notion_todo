// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(soundViewModel)
const soundViewModelProvider = SoundViewModelProvider._();

final class SoundViewModelProvider
    extends $FunctionalProvider<SoundViewModel, SoundViewModel, SoundViewModel>
    with $Provider<SoundViewModel> {
  const SoundViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'soundViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$soundViewModelHash();

  @$internal
  @override
  $ProviderElement<SoundViewModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SoundViewModel create(Ref ref) {
    return soundViewModel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SoundViewModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SoundViewModel>(value),
    );
  }
}

String _$soundViewModelHash() => r'cbd2e88b9fa532749fecdd17d346d37541d16fe2';
