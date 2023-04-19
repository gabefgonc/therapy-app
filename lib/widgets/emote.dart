import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Emote extends StatelessWidget {
  final String emote;
  final double size;

  const Emote(this.emote, this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(emote, style: TextStyle(fontSize: size));
  }
}
