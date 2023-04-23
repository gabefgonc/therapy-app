import 'package:flutter/material.dart';
import 'package:mood_app/isar_service.dart';
import 'package:mood_app/pages/therapy_note_view.dart';
import 'package:mood_app/utils/limit_string_size.dart';
import 'package:provider/provider.dart';

class TherapyNotesTab extends StatelessWidget {
  const TherapyNotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isarService = Provider.of<IsarService>(context);

    return SafeArea(
        child: Column(
      children: <Widget>[
        Container(
            color: Colors.grey.shade300,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Therapy Notes',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(height: 20),
                  Text(
                      'You can register what has improved since your last therapy session, keep track of your goals and register what are your next steps to be a better person.',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            )),
        Expanded(
          child: Container(
            color: Colors.grey.shade300,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TherapyNoteViewPage()));
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
                Expanded(
                    child: StreamBuilder(
                        builder: (context_, snapshot) {
                          Widget widget;
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text('Error loading therapy notes'));
                          } else {
                            switch (snapshot.connectionState) {
                              case ConnectionState.active:
                                widget = ListView.builder(
                                  itemBuilder: (_, idx) {
                                    final data = snapshot.data![idx];
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  limitStringSize(
                                                      data.title!, 24),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22,
                                                  )),
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TherapyNoteViewPage(
                                                                    id: data.id,
                                                                    title: data
                                                                        .title,
                                                                    body: data
                                                                        .body)));
                                                  },
                                                  icon: Icon(Icons.edit,
                                                      color:
                                                          Colors.grey.shade800))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(limitStringSize(data.body!, 48))
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: snapshot.data!.length,
                                );
                                break;
                              default:
                                widget = const Center(
                                    child: CircularProgressIndicator());
                            }
                            return widget;
                          }
                        },
                        stream: isarService.listenToNotes()))
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
