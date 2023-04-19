import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
      Text('🧠', style: TextStyle(fontSize: 112)),
      Text('It also helps you to keep track of your therapy session results.',
          textAlign: TextAlign.center, style: TextStyle(fontSize: 24))
    ]);
  }
}
