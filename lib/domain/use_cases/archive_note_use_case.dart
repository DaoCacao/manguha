import 'package:manguha/data/entities/note.dart';
import 'package:manguha/domain/use_cases/save_note_use_case.dart';

class ArchiveNoteUseCase {
  final SaveNoteUseCase _saveNoteUseCase;

  ArchiveNoteUseCase(this._saveNoteUseCase);

  Future archive(List<Note> notes) async {
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = true
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    _saveNoteUseCase.save(notes);
  }
}
