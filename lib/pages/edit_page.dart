import 'package:calm/entity/event.dart';
import 'package:calm/data/event_presenter.dart';
import 'package:calm/data/input_presenter.dart';
import 'package:calm/component/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class EditPage extends StatefulHookConsumerWidget {
  const EditPage({
    super.key,
    this.event,
  });

  final Event? event;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPageState();
}

class _EditPageState extends ConsumerState<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final expenesesController = TextEditingController();
  final incomesController = TextEditingController();
  final tagController = StringTagController();
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  late final bool isUpdate;
  @override
  void initState() {
    super.initState();
    final event = widget.event;
    isUpdate = event != null;
    if (!isUpdate) return;
    titleController.text = event!.title;
    date = event.day;
    time = TimeOfDay.fromDateTime(event.day);
    expenesesController.text = event.expenses.toString();
    incomesController.text = event.incomes.toString();
  }

  @override
  void dispose() {
    titleController.dispose();
    expenesesController.dispose();
    incomesController.dispose();
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.edit),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Autocomplete<String>(
              initialValue: titleController.value,
              optionsBuilder: (TextEditingValue textEditingValue) async {
                final titles = await ref.watch(inputTitlesProvider.future);
                titles.remove('');
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
                  decoration: InputDecoration(hintText: l10n.title),
                  onChanged: (value) => titleController.text = value,
                );
              },
              onSelected: (option) => titleController.text = option,
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
                        setState(() {});
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
                        setState(() {});
                      },
                      child: Text(time.format(context)),
                    ),
                  ],
                ),
              ),
            ),
            TextFormField(
              controller: expenesesController,
              decoration: InputDecoration(hintText: l10n.expenses),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextFormField(
              controller: incomesController,
              decoration: InputDecoration(hintText: l10n.incomes),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TagsField(
              tagController: tagController,
              initialTags: widget.event?.tags,
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
                  if (isUpdate) {
                    newEvent.id = widget.event!.id;
                  }
                  ref.read(eventsProvider.notifier).updateEvent(newEvent);
                  GoRouter.of(context).pop();
                },
                child: Text(l10n.submit),
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
    this.initialTags,
    super.key,
  });
  final StringTagController tagController;
  final List<String>? initialTags;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context)!;
    return Autocomplete<String>(
      onSelected: tagController.onTagSubmitted,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        final tags = await ref.watch(inputTagsProvider.future);
        return tags
            .where(
              (tag) =>
                  tag.contains(textEditingValue.text.toLowerCase()) &&
                  !tagController.getTags!.contains(tag),
            )
            .toSet()
            .toList();
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
          initialTags: initialTags,
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
                hintText: textFieldTagValues.tags.isNotEmpty ? '' : l10n.tags,
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
