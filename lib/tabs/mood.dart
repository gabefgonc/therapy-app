import 'package:flutter/material.dart';
import 'package:mood_app/isar_service.dart';
import 'package:mood_app/pages/mood_register_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

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
    final isarService = Provider.of<IsarService>(context);
    final dateFormatter = DateFormat('MMMMd, y');

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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: StreamBuilder(
                stream: isarService.listenForMoodRegistrations(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error loading mood registrations'),
                    );
                  } else {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: false,
                          itemBuilder: (_, idx) {
                            final currentMood = snapshot.data![idx];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MoodRegisterView(
                                            moods: currentMood.moods!)));
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(50.0)),
                                          child: const Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Emote('🤑', 18))),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dateFormatter
                                                .format(currentMood.createdAt!)
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                              'The average mood that day was "Default" ')
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          },
                        );
                      default:
                        return const Center(
                          child: Text('loading...'),
                        );
                    }
                  }
                },
              )),
        )
      ]),
    );
  }
}
