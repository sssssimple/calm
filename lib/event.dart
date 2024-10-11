import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

@freezed
class Event with _$Event {
  const Event._();
  const factory Event({
    required String id,
    required String title,
    required String day,
    @Default([]) List<String> tags,
    required int expenses,
    required int incomes,
  }) = _Event;

  @override
  String toString() => title;
  int get balance => incomes - expenses;
}
