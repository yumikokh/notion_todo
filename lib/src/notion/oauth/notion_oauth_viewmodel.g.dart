// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notion_oauth_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotionOAuthViewModel)
const notionOAuthViewModelProvider = NotionOAuthViewModelProvider._();

final class NotionOAuthViewModelProvider
    extends $AsyncNotifierProvider<NotionOAuthViewModel, NotionOAuth> {
  const NotionOAuthViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notionOAuthViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notionOAuthViewModelHash();

  @$internal
  @override
  NotionOAuthViewModel create() => NotionOAuthViewModel();
}

String _$notionOAuthViewModelHash() =>
    r'eec687c067c95c34a3bb6e05b3b2775fef571d97';

abstract class _$NotionOAuthViewModel extends $AsyncNotifier<NotionOAuth> {
  FutureOr<NotionOAuth> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<NotionOAuth>, NotionOAuth>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NotionOAuth>, NotionOAuth>,
              AsyncValue<NotionOAuth>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
