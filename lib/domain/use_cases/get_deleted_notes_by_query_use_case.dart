import 'dart:async';

import 'package:manguha/data/entities/note.dart';
import 'package:manguha/data/repository/note_repository.dart';

class GetDeletedNotesByQueryUseCase {
  final NoteRepository _notes;

  GetDeletedNotesByQueryUseCase(this._notes);

  Future<List<Note>> get(String query) => _notes.getDeletedByQuery(query);
}
