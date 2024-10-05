import 'dart:collection';

import 'package:calm/event.dart';
import 'package:calm/timeline.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

part 'month_page.g.dart';

final _today = DateTime.now();

@riverpod
List<Event> eventsForDay(EventsForDayRef ref, DateTime day) {
  final events = ref.watch(eventsProvider);
  return events.value?[day] ?? [];
}

@riverpod
Future<LinkedHashMap<DateTime, List<Event>>> events(EventsRef ref) async {
  // todo: getData by db
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  return LinkedHashMap(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll(
      {
        DateTime.now().copyWith(hour: 8): [
          Event(
            id: '1',
            title: 'Today\'s event 1',
            day: DateTime.now().copyWith(hour: 8).toIso8601String(),
            expenses: 10000,
            incomes: 30000,
          ),
          Event(
            id: '2',
            title: 'Today\'s event 2',
            day: DateTime.now().copyWith(hour: 18).toIso8601String(),
            expenses: 10000,
            incomes: 30000,
          ),
          Event(
            id: '3',
            title: 'Today\'s event 3',
            day: DateTime.now().copyWith(hour: 18).toIso8601String(),
            expenses: 10000,
            incomes: 30000,
          ),
          Event(
            id: '4',
            title: 'Today\'s event 4',
            day: DateTime.now().copyWith(hour: 18).toIso8601String(),
            expenses: 10000,
            incomes: 30000,
          ),
          Event(
            id: '5',
            title: 'Today\'s event 5',
            day: DateTime.now().copyWith(hour: 18).toIso8601String(),
            expenses: 10000,
            incomes: 30000,
          ),
          Event(
            id: '6',
            title: 'Today\'s event 6',
            day: DateTime.now().copyWith(hour: 18).toIso8601String(),
            expenses: 10000,
            incomes: 30000,
          ),
          Event(
            id: '7',
            title: 'Today\'s event 7',
            day: DateTime.now().copyWith(hour: 18).toIso8601String(),
            expenses: 10000,
            incomes: 30000,
          ),
          Event(
            id: '8',
            title: 'Today\'s event 8',
            day: DateTime.now().copyWith(hour: 18).toIso8601String(),
            expenses: 10000,
            incomes: 30000,
          ),
        ]
      },
    );
}

class MonthPage extends ConsumerStatefulWidget {
  const MonthPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MonthPageState();
}

class _MonthPageState extends ConsumerState<MonthPage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final _firstDay = DateTime(_today.year, _today.month - 3, _today.day);
  final _lastDay = DateTime(_today.year, _today.month + 3, _today.day);

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
    return Scaffold(
      body: Column(
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
            child: Timeline(day: _focusedDay),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/edit');
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
