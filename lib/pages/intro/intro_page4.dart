import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class IntroPage4 extends StatelessWidget {
  final _controller = TextEditingController();

  IntroPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('So, let\'s start!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
      const Text(
        'What\'s your name?',
        style: TextStyle(fontSize: 24),
      ),
      Container(
          margin: const EdgeInsets.all(20.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0))),
          )),
      ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(20.0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)))),
          onPressed: () {
            final textNotEmpty = _controller.text.isNotEmpty;
            SharedPreferences.getInstance().then((prefs) {
              prefs.setBool("first_time", false);
              if (textNotEmpty) {
                prefs.setString("user_name", _controller.text);
              }
            });
            if (textNotEmpty) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage(tab: 0)));
            }
          },
          child: const Text('Let\'s go!')),
    ]);
  }
}
