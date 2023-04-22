import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/emote.dart';
import '../widgets/mood_selector.dart';

class MoodTab extends StatefulWidget {
  const MoodTab({super.key});

  @override
  State<MoodTab> createState() => _MoodTabState();
}

class _MoodTabState extends State<MoodTab> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _initName();
  }

  void _initName() async {
    final instance = await SharedPreferences.getInstance();
    setState(() {
      userName = instance.getString('user_name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Container(
          color: Colors.grey[300],
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              padding: const EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, $userName!',
                      style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const MoodSelector()
                  ])),
        ),
        Expanded(
          child: Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: 6,
                shrinkWrap: false,
                itemBuilder: (_, __) => Container(
                    padding: const EdgeInsets.all(15.0),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50.0)),
                            child: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Emote('🤑', 18))),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'April 18th 2022',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text('The average mood that day was "Rich" ')
                          ],
                        )
                      ],
                    )),
              )),
        )
      ]),
    );
  }
}
