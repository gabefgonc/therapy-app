// TODO: implement registering mood and saving on storage
// TODO: Create tab navigation, so this class becomes the tabs container and its content goes to the 'Mood Tab' file

import 'package:flutter/material.dart';
import 'package:mood_app/widgets/emote.dart';
import 'package:mood_app/widgets/mood_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Hi, $userName!',
                style: const TextStyle(fontSize: 28, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              const MoodSelector()
            ])),
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
    ));
  }
}
