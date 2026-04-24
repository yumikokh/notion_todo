// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskViewModel)
const taskViewModelProvider = TaskViewModelFamily._();

final class TaskViewModelProvider
    extends $AsyncNotifierProvider<TaskViewModel, List<Task>> {
  const TaskViewModelProvider._({
    required TaskViewModelFamily super.from,
    required FilterType super.argument,
  }) : super(
         retry: null,
         name: r'taskViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$taskViewModelHash();

  @override
  String toString() {
    return r'taskViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TaskViewModel create() => TaskViewModel();

  @override
  bool operator ==(Object other) {
    return other is TaskViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$taskViewModelHash() => r'f6b4a579aaf6f008fe42c29e341c2577d910dd2c';

final class TaskViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          TaskViewModel,
          AsyncValue<List<Task>>,
          List<Task>,
          FutureOr<List<Task>>,
          FilterType
        > {
  const TaskViewModelFamily._()
    : super(
        retry: null,
        name: r'taskViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  TaskViewModelProvider call({FilterType filterType = FilterType.all}) =>
      TaskViewModelProvider._(argument: filterType, from: this);

  @override
  String toString() => r'taskViewModelProvider';
}

abstract class _$TaskViewModel extends $AsyncNotifier<List<Task>> {
  late final _$args = ref.$arg as FilterType;
  FilterType get filterType => _$args;

  FutureOr<List<Task>> build({FilterType filterType = FilterType.all});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(filterType: _$args);
    final ref = this.ref as $Ref<AsyncValue<List<Task>>, List<Task>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Task>>, List<Task>>,
              AsyncValue<List<Task>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
