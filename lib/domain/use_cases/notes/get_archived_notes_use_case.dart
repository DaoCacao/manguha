import 'dart:async';

import 'package:manguha/data/entities/note.dart';
import 'package:manguha/data/repository/note_repository.dart';

class GetArchivedNotesUseCase {
  final NoteRepository _notes;

  GetArchivedNotesUseCase(this._notes);

  Future<List<Note>> get() => _notes.getArchived();
}
