import 'package:isar/isar.dart';

part 'therapy_note.g.dart';

@Collection()
class TherapyNote {
  Id id = Isar.autoIncrement;

  String? title;
  String? body;

  DateTime? createdAt;
}
