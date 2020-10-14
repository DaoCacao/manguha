import 'package:flutter/material.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/widgets/note_list/note_item.dart';

class NoteListView extends StatelessWidget {
  final List<Note> notes;

  const NoteListView({Key key, this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16),
      itemCount: notes.length,
      separatorBuilder: (context, i) => SizedBox(height: 16),
      itemBuilder: (context, i) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: NoteListItem(note: notes[i]),
      ),
    );
  }
}
