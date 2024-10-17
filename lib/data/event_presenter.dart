import 'package:calm/data/isar.dart';
import 'package:calm/entity/event.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

part 'event_presenter.g.dart';

@riverpod
class Events extends _$Events {
  late final Isar isar;
  @override
  FutureOr<List<Event>> build() async {
    isar = ref.watch(isarProvider);
    List<Event> events = await isar.events.where().findAll();
    return events;
  }

  Future<void> _loadData() async {
    state = const AsyncValue.loading();
    final events = await isar.events.where().findAll();
    state = AsyncData(events);
  }

  void updateEvent(Event event) async {
    await isar.writeTxn(() async => await isar.events.put(event));
    _loadData();
  }

  Future<void> deleteEvent(Event event) async {
    await isar.writeTxn(() async {
      await isar.events.delete(event.id);
    });
    _loadData();
  }
}

@riverpod
FutureOr<List<Event>> eventsForDay(EventsForDayRef ref, DateTime day) async {
  final events = await ref.watch(eventsProvider.future);
  return events.where((event) => isSameDay(day, event.day)).toList();
}

@riverpod
int totalForDay(TotalForDayRef ref, DateTime day) {
  final focusedEvents = ref.watch(eventsForDayProvider(day));
  return focusedEvents.value
          ?.map((e) => e.balance)
          .fold(0, (previous, current) => previous! + current) ??
      0;
}
