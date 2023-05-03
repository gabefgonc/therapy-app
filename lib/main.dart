import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mood_app/isar_service.dart';
import 'package:mood_app/models/mood_registration.dart';
import 'package:mood_app/models/therapy_note.dart';
import 'package:mood_app/pages/first_time.dart';
import 'package:mood_app/pages/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  final isar = await Isar.open([TherapyNoteSchema, MoodRegistrationSchema],
      directory: dir.path, inspector: true);
  runApp(MyApp(isar: isar));
}

class MyApp extends StatelessWidget {
  final Isar isar;

  const MyApp({super.key, required this.isar});

  Future<bool> _isFirstTime() {
    final Future<bool> isFirst =
        SharedPreferences.getInstance().then((instance) {
      return instance.getBool('first_time') ?? true;
    });

    return isFirst;
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => IsarService(isar: isar),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: FutureBuilder(
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Scaffold(
                        body: Center(child: Text('Loading...')));
                  }
                  if (snapshot.hasData && snapshot.data as bool) {
                    return FirstTime();
                  }
                  if (snapshot.hasError) {
                    return Scaffold(body: Text('${snapshot.error}'));
                  }
                  return const HomePage(tab: 0);
                },
                future: _isFirstTime())));
  }
}
