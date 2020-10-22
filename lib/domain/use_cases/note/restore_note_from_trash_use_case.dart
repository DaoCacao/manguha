import 'package:manguha/data/entities/note.dart';
import 'package:manguha/domain/use_cases/note/save_note_use_case.dart';

class RestoreNoteFromTrashUseCase {
  final SaveNoteUseCase _saveNoteUseCase;

  RestoreNoteFromTrashUseCase(this._saveNoteUseCase);

  Future restoreFromTrash(List<Note> notes) async {
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = false
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    _saveNoteUseCase.save(notes);
  }
}
