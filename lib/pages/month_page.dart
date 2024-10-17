import 'package:calm/data/event_presenter.dart';
import 'package:calm/component/timeline.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class MonthPage extends ConsumerStatefulWidget {
  const MonthPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MonthPageState();
}

class _MonthPageState extends ConsumerState<MonthPage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final _today = DateTime.now();
  late final DateTime _firstDay;
  late final DateTime _lastDay;

  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _firstDay = DateTime(_today.year - 20, _today.month, _today.day);
    _lastDay = _today;
    _focusedDay = _today;
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
    final totalForMonth = ref.watch(totalForMonthProvider(_focusedDay));
    final l10n = L10n.of(context)!;
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
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  final total = ref.watch(totalForDayProvider(day));
                  return total != 0
                      ? Text(
                          '$total',
                        )
                      : null;
                },
              ),
            ),
            Expanded(
              child: Timeline(
                focusedEvents.value ?? [],
                onPressedIcon: deleteEvent,
              ),
            ),
            Row(
              children: [
                const Gap(16),
                Text(
                  '${DateFormat('MM/yyyy').format(_focusedDay)}, ${l10n.total}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const Expanded(
                  child: Gap(0),
                ),
                Text(
                  NumberFormat('#,###').format(totalForMonth),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const Gap(80),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push(
            '/edit',
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
