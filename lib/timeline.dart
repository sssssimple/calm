import 'package:calm/event.dart';
import 'package:calm/main.dart';
import 'package:calm/month_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class Timeline extends ConsumerWidget {
  const Timeline({super.key, required this.day});
  final DateTime day;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvents = ref.watch(eventsForDayProvider(day));
    return selectedEvents.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    label: 'delete',
                    onPressed: (context) async {
                      final isar = ref.watch(isarProvider);
                      await isar.writeTxn(
                        () async {
                          await isar.events.delete(data[index].id);
                        },
                      );
                      // ignore: unused_result
                      ref.refresh(eventsForDayProvider(day).future);
                    },
                  )
                ],
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        DateFormat(('HH:mm')).format(
                          data[index].day,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        data[index].title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${data[index].balance}',
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return const SizedBox.shrink();
      },
      loading: CircularProgressIndicator.adaptive,
    );
  }
}
