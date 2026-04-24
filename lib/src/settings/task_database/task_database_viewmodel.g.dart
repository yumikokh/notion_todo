// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_database_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskDatabaseViewModel)
const taskDatabaseViewModelProvider = TaskDatabaseViewModelProvider._();

final class TaskDatabaseViewModelProvider
    extends $AsyncNotifierProvider<TaskDatabaseViewModel, TaskDatabase?> {
  const TaskDatabaseViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskDatabaseViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskDatabaseViewModelHash();

  @$internal
  @override
  TaskDatabaseViewModel create() => TaskDatabaseViewModel();
}

String _$taskDatabaseViewModelHash() =>
    r'56266986861f75003adb862b1e52a9f18043e88f';

abstract class _$TaskDatabaseViewModel extends $AsyncNotifier<TaskDatabase?> {
  FutureOr<TaskDatabase?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<TaskDatabase?>, TaskDatabase?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TaskDatabase?>, TaskDatabase?>,
              AsyncValue<TaskDatabase?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
