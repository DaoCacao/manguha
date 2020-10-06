import 'package:flutter/material.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/widgets/note_item.dart';

class NoteListView extends StatelessWidget {
  final List<Note> notes;

  const NoteListView({Key key, this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, i) => Padding(
        //TODO why 28?
        padding: EdgeInsets.fromLTRB(
          28,
          i == 0 ? 16 : 8,
          28,
          i == notes.length - 1 ? 16 : 8,
        ),
        child: NoteListItem(note: notes[i]),
      ),
    );
  }
}
