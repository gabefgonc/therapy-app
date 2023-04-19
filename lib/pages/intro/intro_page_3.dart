import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
      Text('🌟', style: TextStyle(fontSize: 112)),
      Text(
        '... And keeps track of your best memories in your life, so you remember them forever!',
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      )
    ]);
  }
}
