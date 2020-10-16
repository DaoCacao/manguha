import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/data/note_repository.dart';

import 'action_state.dart';

class ActionCubit extends Cubit<ActionState> {
  final NoteRepository _notes;

  ActionCubit(this._notes) : super(ActionState.Default);

  void changeState(ActionState state) => emit(state);

  void pin(List<Note> notes) {
    emit(ActionState.Default);
    notes.forEach((note) {
      note
        ..isPinned = true
        ..isArchived = false
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    _notes.save(notes);
  }

  void unpin(List<Note> notes) {
    emit(ActionState.Default);
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = false
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    _notes.save(notes);
  }

  void archive(List<Note> notes) {
    emit(ActionState.Default);
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = true
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    _notes.save(notes);
  }

  void unarchive(List<Note> notes) {
    emit(ActionState.Default);
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = false
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    _notes.save(notes);
  }

  void download(List<Note> notes, String type) {
    emit(ActionState.Default);
    //TODO add download
  }

  void delete(List<Note> notes) {
    emit(ActionState.Default);
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = false
        ..isDeleted = true
        ..lastUpdate = DateTime.now();
    });
    _notes.save(notes);
  }

  void undelete(List<Note> notes) {
    emit(ActionState.Default);
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = false
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    _notes.save(notes);
  }

  void fullDelete(List<Note> notes) {
    emit(ActionState.Default);
    _notes.fullDelete(notes);
  }
}
