import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
      Text('😃', style: TextStyle(fontSize: 128)),
      SizedBox(height: 30),
      Text('The Therapy App helps you register your mood during the day.',
          textAlign: TextAlign.center, style: TextStyle(fontSize: 24))
    ]);
  }
}
