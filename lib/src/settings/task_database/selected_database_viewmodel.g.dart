// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_database_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(accessibleDatabases)
const accessibleDatabasesProvider = AccessibleDatabasesProvider._();

final class AccessibleDatabasesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Database>>,
          List<Database>,
          FutureOr<List<Database>>
        >
    with $FutureModifier<List<Database>>, $FutureProvider<List<Database>> {
  const AccessibleDatabasesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accessibleDatabasesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accessibleDatabasesHash();

  @$internal
  @override
  $FutureProviderElement<List<Database>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Database>> create(Ref ref) {
    return accessibleDatabases(ref);
  }
}

String _$accessibleDatabasesHash() =>
    r'd7b73696d1fd86e85aab0fad3ba9663c76271d61';

@ProviderFor(properties)
const propertiesProvider = PropertiesFamily._();

final class PropertiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Property>>,
          List<Property>,
          FutureOr<List<Property>>
        >
    with $FutureModifier<List<Property>>, $FutureProvider<List<Property>> {
  const PropertiesProvider._({
    required PropertiesFamily super.from,
    required SettingPropertyType super.argument,
  }) : super(
         retry: null,
         name: r'propertiesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$propertiesHash();

  @override
  String toString() {
    return r'propertiesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Property>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Property>> create(Ref ref) {
    final argument = this.argument as SettingPropertyType;
    return properties(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PropertiesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$propertiesHash() => r'1ab362671e568958d33660daa76f44f82a7974f9';

final class PropertiesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Property>>,
          SettingPropertyType
        > {
  const PropertiesFamily._()
    : super(
        retry: null,
        name: r'propertiesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PropertiesProvider call(SettingPropertyType type) =>
      PropertiesProvider._(argument: type, from: this);

  @override
  String toString() => r'propertiesProvider';
}

@ProviderFor(SelectedDatabaseViewModel)
const selectedDatabaseViewModelProvider = SelectedDatabaseViewModelProvider._();

final class SelectedDatabaseViewModelProvider
    extends
        $AsyncNotifierProvider<
          SelectedDatabaseViewModel,
          SelectedDatabaseState?
        > {
  const SelectedDatabaseViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedDatabaseViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedDatabaseViewModelHash();

  @$internal
  @override
  SelectedDatabaseViewModel create() => SelectedDatabaseViewModel();
}

String _$selectedDatabaseViewModelHash() =>
    r'9e54487a92cda3ca07ddeb00ea36cfd5b9c54260';

abstract class _$SelectedDatabaseViewModel
    extends $AsyncNotifier<SelectedDatabaseState?> {
  FutureOr<SelectedDatabaseState?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<SelectedDatabaseState?>, SelectedDatabaseState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<SelectedDatabaseState?>,
                SelectedDatabaseState?
              >,
              AsyncValue<SelectedDatabaseState?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
