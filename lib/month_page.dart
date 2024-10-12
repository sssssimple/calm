import 'package:calm/event.dart';
import 'package:calm/main.dart';
import 'package:calm/timeline.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

part 'month_page.g.dart';

final _today = DateTime.now();

@riverpod
Stream<void> eventChanged(EventChangedRef ref) {
  final isar = ref.watch(isarProvider);
  return isar.events.watchLazy();
}

@riverpod
FutureOr<List<Event>> eventsForDay(EventsForDayRef ref, DateTime day) async {
  final events = await ref.watch(eventsProvider.future);
  return events.where((event) => isSameDay(day, event.day)).toList();
}

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

class MonthPage extends ConsumerStatefulWidget {
  const MonthPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MonthPageState();
}

class _MonthPageState extends ConsumerState<MonthPage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final _firstDay = DateTime(_today.year - 5, _today.month, _today.day);
  final _lastDay = DateTime(_today.year + 5, _today.month, _today.day);

  DateTime _focusedDay = _today;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
  }

  void _ondaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final focusedEvents = ref.watch(eventsForDayProvider(_focusedDay));
    final deleteEvent = ref.watch(eventsProvider.notifier).deleteEvent;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: _firstDay,
              lastDay: _lastDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              onDaySelected: _ondaySelected,
              onPageChanged: (forcusedDay) {
                _focusedDay = forcusedDay;
              },
            ),
            Expanded(
              child: Timeline(
                focusedEvents.value ?? [],
                onPressedIcon: deleteEvent,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push('/edit');
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
