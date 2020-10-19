import 'package:manguha/data/entities/note.dart';
import 'package:manguha/data/repository/note_repository.dart';

class GetNoteUseCase {
  final NoteRepository _notes;

  GetNoteUseCase(this._notes);

  Future<Note> get(int noteId) async {
    return noteId == null ? Note.create() : _notes.get(noteId);
  }
}
