import 'package:manguha/data/entities/note.dart';
import 'package:manguha/domain/use_cases/save_note_use_case.dart';

class UnpinNoteUseCase {
  final SaveNoteUseCase _saveNoteUseCase;

  UnpinNoteUseCase(this._saveNoteUseCase);

  Future unpin(List<Note> notes) async {
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
