import 'dart:async';

import 'package:manguha/data/entities/note.dart';
import 'package:manguha/data/repository/note_repository.dart';

class GetPinnedNotesByQueryUseCase {
  final NoteRepository _notes;

  GetPinnedNotesByQueryUseCase(this._notes);

  Future<List<Note>> get(String query) => _notes.getPinnedByQuery(query);
}
