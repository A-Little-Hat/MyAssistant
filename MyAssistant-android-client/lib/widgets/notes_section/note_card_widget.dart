import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/notes_section/note.dart';
// import 'package:sqflite_database_example/model/note.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().format(note.createdTime);

    return Card(
      color: const Color.fromARGB(255, 85, 18, 241),
      child: Container(
        height: 110,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              note.description,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              time,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
