import 'dart:async';

import 'package:manguha/data/entities/note.dart';
import 'package:manguha/data/repository/note_repository.dart';

class GetAllNotesUseCase {
  final NoteRepository _notes;

  GetAllNotesUseCase(this._notes);

  Future<List<Note>> get() => _notes.getAll();
}
