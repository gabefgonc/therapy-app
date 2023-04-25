import 'package:isar/isar.dart';
import 'package:mood_app/models/mood_registration.dart';
import 'package:mood_app/models/therapy_note.dart';

class IsarService {
  final Isar isar;
  IsarService({required this.isar});

  Stream<List<TherapyNote>> listenToNotes() async* {
    yield* isar.therapyNotes.where().watch(fireImmediately: true);
  }

  TherapyNote createNote(String title, String body) {
    final note = TherapyNote()
      ..title = title
      ..body = body
      ..createdAt = DateTime.now();
    isar.writeTxnSync(() => isar.therapyNotes.putSync(note));
    return note;
  }

  editNote(Id id, String newTitle, String newBody) {
    isar.writeTxnSync(() {
      final note = isar.therapyNotes.getSync(id);
      if (note != null) {
        note.body = newBody;
        note.title = newTitle;
        isar.therapyNotes.putSync(note);
      }
    });
  }

  deleteNote(Id id) {
    isar.writeTxnSync(() => isar.therapyNotes.deleteSync(id));
  }

  MoodRegistration registerMood(List<Mood> moods) {
    final reg = MoodRegistration()
      ..moods = moods
      ..createdAt = DateTime.now();
    isar.writeTxnSync(() => isar.moodRegistrations.putSync(reg));
    return reg;
  }

  Stream<List<MoodRegistration>> listenForMoodRegistrations() async* {
    yield* isar.moodRegistrations.where().watch(fireImmediately: true);
  }

  void addMoodToDayRegister(Mood mood, Id id) {
    final register = isar.moodRegistrations.getSync(id);
    if (register != null) {
      register.moods!.add(mood);
      isar.moodRegistrations.putSync(register);
    }
  }
}
