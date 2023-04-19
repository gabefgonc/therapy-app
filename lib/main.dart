import 'package:flutter/material.dart';
import 'package:mood_app/pages/first_time.dart';
import 'package:mood_app/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _isFirstTime() {
    final Future<bool> isFirst =
        SharedPreferences.getInstance().then((instance) {
      return instance.getBool('first_time') ?? true;
    });

    return isFirst;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Scaffold(body: Center(child: Text('Loading...')));
              }
              if (snapshot.hasData && snapshot.data as bool) {
                return FirstTime();
              }
              if (snapshot.hasError) {
                return Scaffold(body: Text('${snapshot.error}'));
              }
              return HomePage();
            },
            future: _isFirstTime()));
  }
}
