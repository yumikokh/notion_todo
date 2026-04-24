// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_database_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskDatabaseRepository)
const taskDatabaseRepositoryProvider = TaskDatabaseRepositoryProvider._();

final class TaskDatabaseRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<TaskDatabaseRepository?>,
          TaskDatabaseRepository?,
          FutureOr<TaskDatabaseRepository?>
        >
    with
        $FutureModifier<TaskDatabaseRepository?>,
        $FutureProvider<TaskDatabaseRepository?> {
  const TaskDatabaseRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskDatabaseRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskDatabaseRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<TaskDatabaseRepository?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TaskDatabaseRepository?> create(Ref ref) {
    return taskDatabaseRepository(ref);
  }
}

String _$taskDatabaseRepositoryHash() =>
    r'53e854631f45ed042c554b6078fce9be9e3e64f6';
