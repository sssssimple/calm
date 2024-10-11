import 'package:calm/month_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class Timeline extends ConsumerWidget {
  const Timeline({super.key, required this.day});
  final DateTime day;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvents = ref.watch(eventsForDayProvider(day)).value!;

    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  DateFormat(('HH:mm')).format(
                    selectedEvents[index].day,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  selectedEvents[index].title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Text(
                  '${selectedEvents[index].balance}',
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
