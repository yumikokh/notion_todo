// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(subscriptionRepository)
const subscriptionRepositoryProvider = SubscriptionRepositoryProvider._();

final class SubscriptionRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<SubscriptionRepository>,
          SubscriptionRepository,
          FutureOr<SubscriptionRepository>
        >
    with
        $FutureModifier<SubscriptionRepository>,
        $FutureProvider<SubscriptionRepository> {
  const SubscriptionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<SubscriptionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SubscriptionRepository> create(Ref ref) {
    return subscriptionRepository(ref);
  }
}

String _$subscriptionRepositoryHash() =>
    r'6245b5b5952363308fe3182bd53028dabe2bdb17';
