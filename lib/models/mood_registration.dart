import 'package:isar/isar.dart';

part 'mood_registration.g.dart';

@Collection()
class MoodRegistration {
  Id id = Isar.autoIncrement;

  List<Mood>? moods = List.empty(growable: true);

  DateTime? createdAt;
}

@Embedded()
class Mood {
  String? emote;
  String? emoteExplanation;
  String? emoteName;

  DateTime createdAt = DateTime.now();
  Mood({this.emote, this.emoteExplanation, this.emoteName});
}
