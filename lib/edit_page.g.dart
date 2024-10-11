// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inputTitlesHash() => r'c01c54a6d07e778a5841857ac5414ac3d5ec8300';

/// See also [inputTitles].
@ProviderFor(inputTitles)
final inputTitlesProvider = AutoDisposeFutureProvider<List<String>>.internal(
  inputTitles,
  name: r'inputTitlesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$inputTitlesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InputTitlesRef = AutoDisposeFutureProviderRef<List<String>>;
String _$inputTagsHash() => r'9aadb230d72531ea7d280db37d0de7540956df36';

/// See also [inputTags].
@ProviderFor(inputTags)
final inputTagsProvider = AutoDisposeFutureProvider<List<String>>.internal(
  inputTags,
  name: r'inputTagsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$inputTagsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InputTagsRef = AutoDisposeFutureProviderRef<List<String>>;
String _$saveEventHash() => r'61aed5bf5818092ee40af4bdc24b6c28abbeee5a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [saveEvent].
@ProviderFor(saveEvent)
const saveEventProvider = SaveEventFamily();

/// See also [saveEvent].
class SaveEventFamily extends Family<AsyncValue<void>> {
  /// See also [saveEvent].
  const SaveEventFamily();

  /// See also [saveEvent].
  SaveEventProvider call(
    Event event,
  ) {
    return SaveEventProvider(
      event,
    );
  }

  @override
  SaveEventProvider getProviderOverride(
    covariant SaveEventProvider provider,
  ) {
    return call(
      provider.event,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'saveEventProvider';
}

/// See also [saveEvent].
class SaveEventProvider extends AutoDisposeFutureProvider<void> {
  /// See also [saveEvent].
  SaveEventProvider(
    Event event,
  ) : this._internal(
          (ref) => saveEvent(
            ref as SaveEventRef,
            event,
          ),
          from: saveEventProvider,
          name: r'saveEventProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$saveEventHash,
          dependencies: SaveEventFamily._dependencies,
          allTransitiveDependencies: SaveEventFamily._allTransitiveDependencies,
          event: event,
        );

  SaveEventProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.event,
  }) : super.internal();

  final Event event;

  @override
  Override overrideWith(
    FutureOr<void> Function(SaveEventRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SaveEventProvider._internal(
        (ref) => create(ref as SaveEventRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        event: event,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SaveEventProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SaveEventProvider && other.event == event;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, event.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SaveEventRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `event` of this provider.
  Event get event;
}

class _SaveEventProviderElement extends AutoDisposeFutureProviderElement<void>
    with SaveEventRef {
  _SaveEventProviderElement(super.provider);

  @override
  Event get event => (origin as SaveEventProvider).event;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
