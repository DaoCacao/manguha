import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/data/note_repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  void download(List<Note> notes, String type) async {
    //FIXME cant find saved file
    emit(ActionState.Default);

    if (await Permission.storage.request().isGranted)
      notes.forEach((note) => _saveNote(note, type));
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

  Future _saveNote(Note note, String type) {
    getExternalStorageDirectory()
        .then((dir) => dir.path)
        .then((path) => join(path, "${note.title}.$type"))
        .then((path) => File(path))
        .then((file) => file.writeAsString("${note.title}\n${note.content}"));
  }
}
