import 'dart:async';

import 'package:manguha/data/entities/note.dart';
import 'package:manguha/data/repository/note_repository.dart';

class GetPinnedNotesUseCase {
  final NoteRepository _notes;

  GetPinnedNotesUseCase(this._notes);

  Future<List<Note>> get() => _notes.getPinned();
}
