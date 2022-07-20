import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../constants.dart';
import '../../database/notes_database.dart';
import '../../models/notes_section/note.dart';
import '../../widgets/notes_section/note_card_widget.dart';
import 'edit_note_page.dart';
import 'note_detail_page.dart'; // import 'package:sqflite_database_example/db/notes_database.dart';
// import 'package:sqflite_database_example/model/note.dart';
// import 'package:sqflite_database_example/page/edit_note_page.dart';
// import 'package:sqflite_database_example/page/note_detail_page.dart';
// import 'package:sqflite_database_example/widget/note_card_widget.dart';

class NotesSection extends StatefulWidget {
  const NotesSection({Key? key}) : super(key: key);

  @override
  _NotesSectionState createState() => _NotesSectionState();
}

class _NotesSectionState extends State<NotesSection> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    // NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'MyNotes',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: const Color(0xFFfdfbfb),
        ),
        body: Container(
          decoration: screenBackground,
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : notes.isEmpty
                    ? const Text(
                        'No Notes',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : buildNotes(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 85, 18, 241),
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => MasonryGridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: notes.length,
        // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
