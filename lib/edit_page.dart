import 'package:calm/event.dart';
import 'package:calm/main.dart';
import 'package:calm/month_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:textfield_tags/textfield_tags.dart';

part 'edit_page.g.dart';

@riverpod
Future<List<String>> inputTitles(InputTitlesRef ref) async {
  final isar = ref.watch(isarProvider);
  final events = await isar.events.where().findAll();
  return events.map((event) => event.title).toSet().toList();
}

@riverpod
Future<List<String>> inputTags(InputTagsRef ref) async {
  final isar = ref.watch(isarProvider);
  final events = await isar.events.where().findAll();
  return events.map((event) => event.tags).expand((v) => v).toList();
}

class EditPage extends ConsumerWidget {
  EditPage({
    super.key,
    this.event,
  });
  final Event? event;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final expenesesController = TextEditingController();
  final incomesController = TextEditingController();
  final tagController = StringTagController();
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('edit'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) async {
                final titles = await ref.watch(inputTitlesProvider.future);
                return titles.where(
                  (title) => title.contains(
                    textEditingValue.text.toLowerCase(),
                  ),
                );
              },
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: const InputDecoration(hintText: 'Enter Title'),
                );
              },
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(),
                ),
              ),
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        date = await showDatePicker(
                              context: context,
                              firstDate: date.add(const Duration(days: -365)),
                              lastDate: date.add(const Duration(days: 365)),
                            ) ??
                            DateTime.now();
                      },
                      child: Text(DateFormat('MMM d').format(date)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        time = await showTimePicker(
                              context: context,
                              initialTime: time,
                              initialEntryMode: TimePickerEntryMode.inputOnly,
                            ) ??
                            TimeOfDay.now();
                      },
                      child: Text('${time.hour}:${time.minute}'),
                    ),
                  ],
                ),
              ),
            ),
            TextFormField(
              controller: expenesesController,
              decoration: const InputDecoration(hintText: 'expenses'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextFormField(
              controller: incomesController,
              decoration: const InputDecoration(hintText: 'incomes'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TagsField(
              tagController: tagController,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final title = titleController.text;
                  final expenses = int.parse(
                    expenesesController.text.isNotEmpty
                        ? expenesesController.text
                        : '0',
                  );
                  final incomes = int.parse(
                    incomesController.text.isNotEmpty
                        ? incomesController.text
                        : '0',
                  );
                  final tags = tagController.getTags;
                  final day = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  );
                  final newEvent = Event()
                    ..title = title
                    ..day = day
                    ..expenses = expenses
                    ..incomes = incomes
                    ..tags = tags ?? [];
                  final isar = ref.watch(isarProvider);
                  await isar
                      .writeTxn(() async => await isar.events.put(newEvent));
                  GoRouter.of(context).pop();
                },
                child: const Text('submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TagsField extends ConsumerWidget {
  const TagsField({
    required this.tagController,
    super.key,
  });

  final StringTagController tagController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Autocomplete<String>(
      onSelected: tagController.onTagSubmitted,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        final tags = await ref.watch(inputTagsProvider.future);
        return tags.where(
          (tag) =>
              tag.contains(textEditingValue.text.toLowerCase()) &&
              !tagController.getTags!.contains(tag),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: options
                    .map(
                      (option) => Tag(
                        text: option,
                        onTap: () => onSelected(option),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFieldTags<String>(
          textEditingController: textEditingController,
          textfieldTagsController: tagController,
          focusNode: focusNode,
          inputFieldBuilder: (context, textFieldTagValues) {
            return TextField(
              controller: textFieldTagValues.textEditingController,
              focusNode: textFieldTagValues.focusNode,
              decoration: InputDecoration(
                isDense: true,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 3.0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 3.0,
                  ),
                ),
                hintText:
                    textFieldTagValues.tags.isNotEmpty ? '' : "Enter tag...",
                errorText: textFieldTagValues.error,
                prefixIcon: textFieldTagValues.tags.isNotEmpty
                    ? SingleChildScrollView(
                        controller: textFieldTagValues.tagScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: textFieldTagValues.tags.map(
                            (String tag) {
                              return Tag(
                                text: tag,
                                onTap: () =>
                                    textFieldTagValues.onTagRemoved(tag),
                                isCancel: true,
                              );
                            },
                          ).toList(),
                        ),
                      )
                    : null,
              ),
              onChanged: textFieldTagValues.onTagChanged,
              onSubmitted: textFieldTagValues.onTagSubmitted,
            );
          },
        );
      },
    );
  }
}

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.text,
    required this.onTap,
    this.isCancel = false,
  });
  final String text;
  final Function()? onTap;
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '#$text',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 4,
            ),
            Icon(
              !isCancel ? Icons.add_circle : Icons.cancel,
              size: 14.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
