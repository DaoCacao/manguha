import 'package:manguha/data/entities/note.dart';
import 'package:manguha/domain/use_cases/save_note_use_case.dart';

class MoveNoteToTrashUseCase {
  final SaveNoteUseCase _saveNoteUseCase;

  MoveNoteToTrashUseCase(this._saveNoteUseCase);

  Future moveToTrash(List<Note> notes) async {
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = false
        ..isDeleted = true
        ..lastUpdate = DateTime.now();
    });
    _saveNoteUseCase.save(notes);
  }
}
