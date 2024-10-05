import 'package:calm/month_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Timeline extends ConsumerWidget {
  const Timeline({super.key, required this.day});
  final DateTime day;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvents = ref.watch(eventsForDayProvider(day));

    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  '${DateTime.parse(selectedEvents[index].day).hour.toString()}:${DateTime.parse(selectedEvents[index].day).second.toString()}',
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  selectedEvents[index].title,
                ),
              ),
              Text(
                '${selectedEvents[index].balance}',
              )
            ],
          ),
        );
      },
    );
  }
}
