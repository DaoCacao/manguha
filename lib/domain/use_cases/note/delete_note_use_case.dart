import 'dart:async';

import 'package:manguha/data/entities/note.dart';
import 'package:manguha/data/repository/note_repository.dart';

class DeleteNoteUseCase {
  final NoteRepository _notes;

  StreamController<List<int>> _controller;
  Stream<List<int>> onDeleted;

  DeleteNoteUseCase(this._notes) {
    _controller = StreamController.broadcast();
    onDeleted = _controller.stream;
  }

  Future delete(List<Note> notes) async {
    await _notes.fullDelete(notes);
    _controller.add(notes.map((note) => note.id).toList());
  }
}
