import 'dart:async';

import 'package:manguha/data/entities/note.dart';
import 'package:manguha/data/repository/note_repository.dart';

class GetArchivedNotesByQueryUseCase {
  final NoteRepository _notes;

  GetArchivedNotesByQueryUseCase(this._notes);

  Future<List<Note>> get(String query) => _notes.getArchivedByQuery(query);
}
