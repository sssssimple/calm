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
Future<List<Event>> eventsForDay(EventsForDayRef ref, DateTime day) async {
  final isar = ref.watch(isarProvider);
  final events = isar.events
      .filter()
      .dayBetween(
          day.copyWith(
            hour: 0,
            minute: 0,
            second: 0,
            millisecond: 0,
            microsecond: 0,
          ),
          day.copyWith(
            hour: 23,
            minute: 59,
            second: 59,
            millisecond: 999999,
            microsecond: 999999,
          ))
      .findAll();

  return events;
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
              child: Timeline(day: _focusedDay),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).push('/edit'),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
