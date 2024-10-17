import 'package:calm/entity/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class Timeline extends ConsumerWidget {
  const Timeline(
    this.events, {
    super.key,
    this.onPressedIcon,
  });
  final List<Event> events;
  final Function(Event)? onPressedIcon;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context)!;
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                icon: Icons.delete,
                backgroundColor: Colors.red,
                label: l10n.delete,
                onPressed: (context) {
                  if (onPressedIcon == null) return;
                  onPressedIcon!(events[index]);
                },
              )
            ],
          ),
          child: ListTile(
            onTap: () {
              GoRouter.of(context).go('/edit', extra: events[index]);
            },
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat(('HH:mm')).format(
                      events[index].day,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    events[index].title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Text(
                    NumberFormat('#,###').format(events[index].balance),
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
