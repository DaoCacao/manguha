import 'dart:async';

import 'package:manguha/data/entities/note.dart';
import 'package:manguha/data/repository/note_repository.dart';

class GetAllNotesByQueryUseCase {
  final NoteRepository _notes;

  GetAllNotesByQueryUseCase(this._notes);

  Future<List<Note>> get(String query) => _notes.getAllByQuery(query);
}
