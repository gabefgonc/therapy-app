import 'package:flutter/material.dart';
import 'package:mood_app/isar_service.dart';
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
                          isarService.createNote('test',
                              'Today I tested something that I should do beacause i like pigs');
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
                                    return Container(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data?[idx].title ?? ''),
                                          Text(
                                              '${snapshot.data?[idx].body?.substring(0, 24) ?? ""}...')
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
