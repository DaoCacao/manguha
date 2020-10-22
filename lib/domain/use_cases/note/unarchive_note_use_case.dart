import 'package:manguha/data/entities/note.dart';
import 'package:manguha/domain/use_cases/note/save_note_use_case.dart';

class UnarchiveNoteUseCase {
  final SaveNoteUseCase _saveNoteUseCase;

  UnarchiveNoteUseCase(this._saveNoteUseCase);

  Future unarchive(List<Note> notes) async {
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
