import 'package:flutter/material.dart';
import 'package:mood_app/widgets/emote.dart';

const moodEmotes = ['😄', '😢', '🤬', '😈', '🤡', '💩'];

class MoodSelector extends StatelessWidget {
  const MoodSelector({super.key});

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(70, 255, 255, 255)),
                child: Emote(moodEmotes[idx], 24)),
            itemCount: moodEmotes.length,
          ),
        )
      ],
    );
  }
}
