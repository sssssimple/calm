import 'package:calm/data/event_presenter.dart';
import 'package:calm/component/timeline.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

final _today = DateTime.now();

class MonthPage extends ConsumerStatefulWidget {
  const MonthPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MonthPageState();
}

class _MonthPageState extends ConsumerState<MonthPage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final _firstDay = DateTime(_today.year - 20, _today.month, _today.day);
  final _lastDay = _today;

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
