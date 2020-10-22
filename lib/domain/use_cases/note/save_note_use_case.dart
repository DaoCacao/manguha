import 'dart:async';

import 'package:manguha/data/entities/note.dart';
import 'package:manguha/data/repository/note_repository.dart';

class SaveNoteUseCase {
  final NoteRepository _notes;

  StreamController<List<int>> _controller;
  Stream<List<int>> onSaved;

  SaveNoteUseCase(this._notes) {
    _controller = StreamController.broadcast();
    onSaved = _controller.stream;
  }

  Future save(List<Note> notes) async {
    _notes.save(notes);
    _controller.add(notes.map((note) => note.id).toList());
  }
}
