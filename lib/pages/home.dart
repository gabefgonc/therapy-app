import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mood_app/tabs/mood.dart';
import 'package:mood_app/tabs/therapy_notes.dart';

const pages = <Widget>[MoodTab(), TherapyNotesTab(), MoodTab()];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        // this outer container keeps the border radius background transparent.
        color: Colors.grey.shade300,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15.0),
          decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: GNav(
              backgroundColor: Colors.blue.shade700,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.blue.shade400,
              gap: 8,
              padding: const EdgeInsets.all(16),
              selectedIndex: _selectedIndex,
              onTabChange: (index) => {
                    setState(() {
                      _selectedIndex = index;
                    })
                  },
              tabs: const [
                GButton(icon: Icons.emoji_emotions, text: 'Mood'),
                GButton(icon: Icons.chair, text: 'Therapy'),
                GButton(icon: Icons.camera_alt, text: 'Memories'),
              ]),
        ),
      ),
    );
  }
}
