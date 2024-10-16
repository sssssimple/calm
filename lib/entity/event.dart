import 'package:isar/isar.dart';

part 'event.g.dart';

@collection
class Event {
  Id id = Isar.autoIncrement;
  late DateTime day;
  late String title;
  late List<String> tags;
  late int expenses;
  late int incomes;

  @override
  String toString() => title;
  int get balance => incomes - expenses;
}
