import 'package:calm/event.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditPage extends ConsumerWidget {
  const EditPage({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('edit'),
      ),
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(hintText: 'title'),
          ),
          const TextField(
            decoration: InputDecoration(hintText: 'time'),
          ),
          const TextField(
            decoration: InputDecoration(hintText: 'expenses'),
          ),
          const TextField(
            decoration: InputDecoration(hintText: 'incomes'),
          ),
          const TextField(
            decoration: InputDecoration(hintText: 'tag'),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('submit'),
            ),
          ),
        ],
      ),
    );
  }
}
