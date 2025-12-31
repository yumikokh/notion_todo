// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SubscriptionViewModel)
const subscriptionViewModelProvider = SubscriptionViewModelProvider._();

final class SubscriptionViewModelProvider
    extends $AsyncNotifierProvider<SubscriptionViewModel, SubscriptionStatus> {
  const SubscriptionViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionViewModelHash();

  @$internal
  @override
  SubscriptionViewModel create() => SubscriptionViewModel();
}

String _$subscriptionViewModelHash() =>
    r'286c54335bf4af13a145e3ae7e5b4b456daa0ed3';

abstract class _$SubscriptionViewModel
    extends $AsyncNotifier<SubscriptionStatus> {
  FutureOr<SubscriptionStatus> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<SubscriptionStatus>, SubscriptionStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SubscriptionStatus>, SubscriptionStatus>,
              AsyncValue<SubscriptionStatus>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
