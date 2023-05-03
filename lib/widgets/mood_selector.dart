import 'package:flutter/material.dart';
import 'package:mood_app/isar_service.dart';
import 'package:mood_app/widgets/emote.dart';
import 'package:provider/provider.dart';

import '../models/mood_registration.dart';

final moods = [
  Mood(
    emote: '😃',
    emoteExplanation: 'I am feeeling happy',
    emoteName: 'Happy',
  ),
  Mood(emote: '😢', emoteExplanation: 'I feel sad', emoteName: 'Sad'),
  Mood(emote: '🤬', emoteExplanation: 'I am angry', emoteName: 'Angry'),
  Mood(emote: '🧠', emoteExplanation: 'I am feeling smart', emoteName: 'Smart'),
  Mood(
      emote: '💩', emoteExplanation: 'I am feeling a lot bad', emoteName: 'Bad')
];

class MoodSelector extends StatelessWidget {
  const MoodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final isarService = Provider.of<IsarService>(context);
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'How are you feeling?',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz, color: Colors.white))
          ],
        ),
        SizedBox(
          height: 86,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, idx) => Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(70, 255, 255, 255)),
                child: TextButton(
                    child: Emote(moods[idx].emote!, 24),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mood Registered!')));
                      final latestMoodRegistration =
                          isarService.getLatestMoodRegistration();
                      final now = DateTime.now();
                      if (latestMoodRegistration?.createdAt?.day == now.day &&
                          latestMoodRegistration?.createdAt?.month ==
                              now.month &&
                          latestMoodRegistration?.createdAt?.year == now.year) {
                        isarService.addMoodToDayRegister(
                            moods[idx], latestMoodRegistration!.id);
                      } else {
                        isarService.registerMood([moods[idx]]);
                      }
                    })),
            itemCount: moods.length,
          ),
        )
      ],
    );
  }
}
