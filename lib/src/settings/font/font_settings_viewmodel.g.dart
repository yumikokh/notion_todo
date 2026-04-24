// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'font_settings_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FontSettingsViewModel)
const fontSettingsViewModelProvider = FontSettingsViewModelProvider._();

final class FontSettingsViewModelProvider
    extends $AsyncNotifierProvider<FontSettingsViewModel, FontSettings> {
  const FontSettingsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fontSettingsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fontSettingsViewModelHash();

  @$internal
  @override
  FontSettingsViewModel create() => FontSettingsViewModel();
}

String _$fontSettingsViewModelHash() =>
    r'589ba20a33a477ae392f1ab0d59bc4d19e9e65eb';

abstract class _$FontSettingsViewModel extends $AsyncNotifier<FontSettings> {
  FutureOr<FontSettings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<FontSettings>, FontSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FontSettings>, FontSettings>,
              AsyncValue<FontSettings>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
