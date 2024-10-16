// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_presenter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventsForDayHash() => r'4fb495335ca87d1391c5b65793bdc2c6daefa137';

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

/// See also [eventsForDay].
@ProviderFor(eventsForDay)
const eventsForDayProvider = EventsForDayFamily();

/// See also [eventsForDay].
class EventsForDayFamily extends Family<AsyncValue<List<Event>>> {
  /// See also [eventsForDay].
  const EventsForDayFamily();

  /// See also [eventsForDay].
  EventsForDayProvider call(
    DateTime day,
  ) {
    return EventsForDayProvider(
      day,
    );
  }

  @override
  EventsForDayProvider getProviderOverride(
    covariant EventsForDayProvider provider,
  ) {
    return call(
      provider.day,
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
  String? get name => r'eventsForDayProvider';
}

/// See also [eventsForDay].
class EventsForDayProvider extends AutoDisposeFutureProvider<List<Event>> {
  /// See also [eventsForDay].
  EventsForDayProvider(
    DateTime day,
  ) : this._internal(
          (ref) => eventsForDay(
            ref as EventsForDayRef,
            day,
          ),
          from: eventsForDayProvider,
          name: r'eventsForDayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventsForDayHash,
          dependencies: EventsForDayFamily._dependencies,
          allTransitiveDependencies:
              EventsForDayFamily._allTransitiveDependencies,
          day: day,
        );

  EventsForDayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.day,
  }) : super.internal();

  final DateTime day;

  @override
  Override overrideWith(
    FutureOr<List<Event>> Function(EventsForDayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventsForDayProvider._internal(
        (ref) => create(ref as EventsForDayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        day: day,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Event>> createElement() {
    return _EventsForDayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsForDayProvider && other.day == day;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, day.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EventsForDayRef on AutoDisposeFutureProviderRef<List<Event>> {
  /// The parameter `day` of this provider.
  DateTime get day;
}

class _EventsForDayProviderElement
    extends AutoDisposeFutureProviderElement<List<Event>> with EventsForDayRef {
  _EventsForDayProviderElement(super.provider);

  @override
  DateTime get day => (origin as EventsForDayProvider).day;
}

String _$totalForDayHash() => r'1e713daa6b180004879004193ae8cd3f88a153b5';

/// See also [totalForDay].
@ProviderFor(totalForDay)
const totalForDayProvider = TotalForDayFamily();

/// See also [totalForDay].
class TotalForDayFamily extends Family<int> {
  /// See also [totalForDay].
  const TotalForDayFamily();

  /// See also [totalForDay].
  TotalForDayProvider call(
    DateTime day,
  ) {
    return TotalForDayProvider(
      day,
    );
  }

  @override
  TotalForDayProvider getProviderOverride(
    covariant TotalForDayProvider provider,
  ) {
    return call(
      provider.day,
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
  String? get name => r'totalForDayProvider';
}

/// See also [totalForDay].
class TotalForDayProvider extends AutoDisposeProvider<int> {
  /// See also [totalForDay].
  TotalForDayProvider(
    DateTime day,
  ) : this._internal(
          (ref) => totalForDay(
            ref as TotalForDayRef,
            day,
          ),
          from: totalForDayProvider,
          name: r'totalForDayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$totalForDayHash,
          dependencies: TotalForDayFamily._dependencies,
          allTransitiveDependencies:
              TotalForDayFamily._allTransitiveDependencies,
          day: day,
        );

  TotalForDayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.day,
  }) : super.internal();

  final DateTime day;

  @override
  Override overrideWith(
    int Function(TotalForDayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TotalForDayProvider._internal(
        (ref) => create(ref as TotalForDayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        day: day,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _TotalForDayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TotalForDayProvider && other.day == day;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, day.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TotalForDayRef on AutoDisposeProviderRef<int> {
  /// The parameter `day` of this provider.
  DateTime get day;
}

class _TotalForDayProviderElement extends AutoDisposeProviderElement<int>
    with TotalForDayRef {
  _TotalForDayProviderElement(super.provider);

  @override
  DateTime get day => (origin as TotalForDayProvider).day;
}

String _$totalForMonthHash() => r'184c9dd55d9de33aee9e37ee14fff8b968e36834';

/// See also [totalForMonth].
@ProviderFor(totalForMonth)
const totalForMonthProvider = TotalForMonthFamily();

/// See also [totalForMonth].
class TotalForMonthFamily extends Family<int> {
  /// See also [totalForMonth].
  const TotalForMonthFamily();

  /// See also [totalForMonth].
  TotalForMonthProvider call(
    DateTime day,
  ) {
    return TotalForMonthProvider(
      day,
    );
  }

  @override
  TotalForMonthProvider getProviderOverride(
    covariant TotalForMonthProvider provider,
  ) {
    return call(
      provider.day,
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
  String? get name => r'totalForMonthProvider';
}

/// See also [totalForMonth].
class TotalForMonthProvider extends AutoDisposeProvider<int> {
  /// See also [totalForMonth].
  TotalForMonthProvider(
    DateTime day,
  ) : this._internal(
          (ref) => totalForMonth(
            ref as TotalForMonthRef,
            day,
          ),
          from: totalForMonthProvider,
          name: r'totalForMonthProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$totalForMonthHash,
          dependencies: TotalForMonthFamily._dependencies,
          allTransitiveDependencies:
              TotalForMonthFamily._allTransitiveDependencies,
          day: day,
        );

  TotalForMonthProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.day,
  }) : super.internal();

  final DateTime day;

  @override
  Override overrideWith(
    int Function(TotalForMonthRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TotalForMonthProvider._internal(
        (ref) => create(ref as TotalForMonthRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        day: day,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _TotalForMonthProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TotalForMonthProvider && other.day == day;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, day.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TotalForMonthRef on AutoDisposeProviderRef<int> {
  /// The parameter `day` of this provider.
  DateTime get day;
}

class _TotalForMonthProviderElement extends AutoDisposeProviderElement<int>
    with TotalForMonthRef {
  _TotalForMonthProviderElement(super.provider);

  @override
  DateTime get day => (origin as TotalForMonthProvider).day;
}

String _$eventsHash() => r'519625f377bac2395636657aa30a0ea043e60ec1';

/// See also [Events].
@ProviderFor(Events)
final eventsProvider =
    AutoDisposeAsyncNotifierProvider<Events, List<Event>>.internal(
  Events.new,
  name: r'eventsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$eventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Events = AutoDisposeAsyncNotifier<List<Event>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
