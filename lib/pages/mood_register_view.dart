import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:mood_app/models/mood_registration.dart';

import '../widgets/emote.dart';

class MoodRegisterView extends StatelessWidget {
  final List<Mood> moods;

  const MoodRegisterView({super.key, required this.moods});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.Hm();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black)),
        ),
        body: SafeArea(
            child: Container(
          color: Colors.grey.shade300,
          child: Center(
            child: ListView.builder(
                itemBuilder: (_, idx) {
                  final mood = moods[idx];
                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(children: [
                      Emote(mood.emote!, 32),
                      Expanded(child: Text(mood.emoteName!)),
                      Text(formatter.format(mood.createdAt))
                    ]),
                  );
                },
                itemCount: moods.length),
          ),
        )));
  }
}
