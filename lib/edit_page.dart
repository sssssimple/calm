import 'package:calm/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:textfield_tags/textfield_tags.dart';

part 'edit_page.g.dart';

@riverpod
Future<List<String>> inputTitles(InputTitlesRef ref) async {
  return [
    'aardvark',
    'bobcat',
    'chameleon',
    'カメレオン',
  ];
}

@riverpod
Future<List<String>> inputTags(InputTagsRef ref) async {
  return [
    'aardvark',
    'bobcat',
    'chameleon',
    'カメレオン',
  ];
}

class EditPage extends ConsumerWidget {
  EditPage({
    super.key,
    this.event,
  });
  final Event? event;
  final _tagController = StringTagController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('edit'),
      ),
      body: Column(
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
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now().add(const Duration(days: -365)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                },
                child: const Text('day'),
              ),
              InkWell(
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    initialEntryMode: TimePickerEntryMode.inputOnly,
                  );
                },
                child: const Text('time'),
              ),
            ],
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'expenses'),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'incomes'),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          TextFieldTags(
            textfieldTagsController: _tagController,
            initialTags: const ['java', 'python'],
            textSeparators: const ['', ''],
            inputFieldBuilder: (context, inputFieldValues) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                onTap: () {
                  _tagController.getFocusNode?.requestFocus();
                },
                controller: inputFieldValues.textEditingController,
                focusNode: inputFieldValues.focusNode,
                decoration: InputDecoration(
                  isDense: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 74, 137, 92),
                      width: 3.0,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 74, 137, 92),
                      width: 3.0,
                    ),
                  ),
                  helperText: 'Enter language...',
                  helperStyle: const TextStyle(
                    color: Color.fromARGB(255, 74, 137, 92),
                  ),
                  hintText:
                      inputFieldValues.tags.isNotEmpty ? '' : "Enter tag...",
                  errorText: inputFieldValues.error,
                  // prefixIconConstraints:
                  //     BoxConstraints(maxWidth: _distanceToField * 0.8),
                  prefixIcon: inputFieldValues.tags.isNotEmpty
                      ? TagField(
                          scrollController:
                              inputFieldValues.tagScrollController,
                          tags: inputFieldValues.tags,
                          onTagRemoved: inputFieldValues.onTagRemoved,
                        )
                      : null,
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
              },
              child: const Text('submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class TagField extends StatelessWidget {
  const TagField({
    super.key,
    required this.scrollController,
    required this.tags,
    required this.onTagRemoved,
  });
  final ScrollController scrollController;
  final List<String> tags;
  final Function(String) onTagRemoved;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 8,
        ),
        child: Wrap(
            runSpacing: 4.0,
            spacing: 4.0,
            children: tags.map(
              (String tag) {
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    color: Color.fromARGB(255, 74, 137, 92),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Tag(
                    text: tag,
                    onTapRemoved: () => onTagRemoved(tag),
                  ),
                );
              },
            ).toList()),
      ),
    );
  }
}

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.text,
    required this.onTapRemoved,
  });
  final String text;
  final Function onTapRemoved;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: Text(
            '#$text',
            style: const TextStyle(color: Colors.white),
          ),
          onTap: () {
            //print("$tag selected");
          },
        ),
        const SizedBox(width: 4.0),
        InkWell(
          onTap: () => onTapRemoved(),
          child: const Icon(
            Icons.cancel,
            size: 14.0,
            color: Color.fromARGB(255, 233, 233, 233),
          ),
        )
      ],
    );
  }
}
