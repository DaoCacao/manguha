import 'dart:async';

import 'package:manguha/data/entities/note.dart';
import 'package:manguha/data/repository/note_repository.dart';

class GetDeletedNotesUseCase {
  final NoteRepository _notes;

  GetDeletedNotesUseCase(this._notes);

  Future<List<Note>> get() => _notes.getDeleted();
}
