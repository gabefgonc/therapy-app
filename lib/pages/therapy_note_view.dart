import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mood_app/isar_service.dart';
import 'package:mood_app/pages/home.dart';
import 'package:provider/provider.dart';

class TherapyNoteViewPage extends StatelessWidget {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  final String? body;
  final String? title;
  final Id? id;

  TherapyNoteViewPage({super.key, this.body, this.title, this.id}) {
    _titleController = TextEditingController(text: title ?? '');
    _bodyController = TextEditingController(text: body ?? '');
  }

  Future<void> _showConfirmDialog(
      BuildContext context, void Function() whenConfirmed) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Are you sure you want to delete the note?'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No')),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    whenConfirmed();
                  },
                  child: const Text('Yes'),
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isarService = Provider.of<IsarService>(context);
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextField(
                    controller: _titleController,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24))),
            IconButton(
                onPressed: () {
                  if (id != null) {
                    isarService.editNote(
                        id!, _titleController.text, _bodyController.text);
                  } else {
                    isarService.createNote(
                        _titleController.text, _bodyController.text);
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage(tab: 1)));
                },
                icon: const Icon(Icons.done, color: Colors.green)),
            IconButton(
                onPressed: () {
                  _showConfirmDialog(context, () {
                    if (id != null) {
                      isarService.deleteNote(id!);
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(tab: 1)));
                  });
                },
                icon: const Icon(Icons.delete_sharp, color: Colors.red)),
          ],
        ),
        Expanded(
            child: TextField(
                controller: _bodyController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(border: InputBorder.none)))
      ],
    )));
  }
}
