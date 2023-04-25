import 'package:isar/isar.dart';

part 'mood_registration.g.dart';

@Collection()
class MoodRegistration {
  Id id = Isar.autoIncrement;

  List<Mood>? moods;

  DateTime? createdAt;
}

@Embedded()
class Mood {
  String? emote;
  String? emoteExplanation;
}
