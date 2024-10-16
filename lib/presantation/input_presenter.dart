import 'package:calm/data/isar.dart';
import 'package:calm/entity/event.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'input_presenter.g.dart';

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
