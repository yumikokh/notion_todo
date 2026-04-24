// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notion_oauth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notionOAuthRepository)
const notionOAuthRepositoryProvider = NotionOAuthRepositoryProvider._();

final class NotionOAuthRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotionOAuthRepository>,
          NotionOAuthRepository,
          FutureOr<NotionOAuthRepository>
        >
    with
        $FutureModifier<NotionOAuthRepository>,
        $FutureProvider<NotionOAuthRepository> {
  const NotionOAuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notionOAuthRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notionOAuthRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<NotionOAuthRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotionOAuthRepository> create(Ref ref) {
    return notionOAuthRepository(ref);
  }
}

String _$notionOAuthRepositoryHash() =>
    r'cdad3dde48c3c53f2d241741f5c229972a6c6e77';
