import 'package:manguha/data/entities/note.dart';
import 'package:manguha/domain/use_cases/save_note_use_case.dart';

class PinNoteUseCase {
  final SaveNoteUseCase _saveNoteUseCase;

  PinNoteUseCase(this._saveNoteUseCase);

  Future pin(List<Note> notes) async {
    notes.forEach((note) {
      note
        ..isPinned = true
        ..isArchived = false
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    _saveNoteUseCase.save(notes);
  }
}
