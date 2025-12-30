// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskRepository)
const taskRepositoryProvider = TaskRepositoryProvider._();

final class TaskRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<TaskRepository?>,
          TaskRepository?,
          FutureOr<TaskRepository?>
        >
    with $FutureModifier<TaskRepository?>, $FutureProvider<TaskRepository?> {
  const TaskRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<TaskRepository?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TaskRepository?> create(Ref ref) {
    return taskRepository(ref);
  }
}

String _$taskRepositoryHash() => r'7945ae5f184c6b8803ad669d2e837ae8fc072ee5';
