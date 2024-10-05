// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventsForDayHash() => r'355e7f094724bab73377294afa63e4ca2b3df2da';

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
class EventsForDayFamily extends Family<List<Event>> {
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
class EventsForDayProvider extends AutoDisposeProvider<List<Event>> {
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
    List<Event> Function(EventsForDayRef provider) create,
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
  AutoDisposeProviderElement<List<Event>> createElement() {
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

mixin EventsForDayRef on AutoDisposeProviderRef<List<Event>> {
  /// The parameter `day` of this provider.
  DateTime get day;
}

class _EventsForDayProviderElement
    extends AutoDisposeProviderElement<List<Event>> with EventsForDayRef {
  _EventsForDayProviderElement(super.provider);

  @override
  DateTime get day => (origin as EventsForDayProvider).day;
}

String _$eventsHash() => r'165faf2ffafd40f041e91bca69611cbe23d911f7';

/// See also [events].
@ProviderFor(events)
final eventsProvider =
    AutoDisposeFutureProvider<LinkedHashMap<DateTime, List<Event>>>.internal(
  events,
  name: r'eventsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$eventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EventsRef
    = AutoDisposeFutureProviderRef<LinkedHashMap<DateTime, List<Event>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
