// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_selection_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProjectSelectionViewModel)
const projectSelectionViewModelProvider = ProjectSelectionViewModelProvider._();

final class ProjectSelectionViewModelProvider
    extends
        $AsyncNotifierProvider<
          ProjectSelectionViewModel,
          List<RelationOption>
        > {
  const ProjectSelectionViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectSelectionViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectSelectionViewModelHash();

  @$internal
  @override
  ProjectSelectionViewModel create() => ProjectSelectionViewModel();
}

String _$projectSelectionViewModelHash() =>
    r'5f2e3c91cb5ba3b59a28ff077aca58ffb8bac179';

abstract class _$ProjectSelectionViewModel
    extends $AsyncNotifier<List<RelationOption>> {
  FutureOr<List<RelationOption>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<RelationOption>>, List<RelationOption>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<RelationOption>>,
                List<RelationOption>
              >,
              AsyncValue<List<RelationOption>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
