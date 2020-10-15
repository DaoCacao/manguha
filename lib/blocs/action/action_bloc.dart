import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/notes_all/all_notes_bloc.dart';
import 'package:manguha/blocs/notes_all/all_notes_events.dart';
import 'package:manguha/blocs/notes_archived/archived_notes_bloc.dart';
import 'package:manguha/blocs/notes_archived/archived_notes_events.dart';
import 'package:manguha/blocs/notes_deleted/deleted_notes_bloc.dart';
import 'package:manguha/blocs/notes_deleted/deleted_notes_events.dart';
import 'package:manguha/blocs/notes_pinned/pinned_notes_bloc.dart';
import 'package:manguha/blocs/notes_pinned/pinned_notes_events.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/data/note_repository.dart';

import 'action_state.dart';

class ActionCubit extends Cubit<ActionState> {
  final NoteRepository _notes;
  final AllNotesBloc _allNotesBloc;
  final PinnedNotesBloc _pinnedNotesBloc;
  final ArchivedNotesBloc _archivedNotesBloc;
  final DeletedNotesBloc _deletedNotesBloc;

  ActionCubit(
    this._notes,
    this._allNotesBloc,
    this._pinnedNotesBloc,
    this._archivedNotesBloc,
    this._deletedNotesBloc,
  ) : super(ActionState.Default);

  ActionCubit.get(BuildContext c)
      : this(
          c.repository(),
          c.bloc(),
          c.bloc(),
          c.bloc(),
          c.bloc(),
        );

  void changeState(ActionState state) => emit(state);

  void pin(List<Note> notes) async {
    emit(ActionState.Default);
    notes.forEach((note) {
      note
        ..isPinned = true
        ..isArchived = false
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    await _notes.save(notes);
    _update();
  }

  void unpin(List<Note> notes) async {
    emit(ActionState.Default);
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = false
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    await _notes.save(notes);
    _update();
  }

  void archive(List<Note> notes) async {
    emit(ActionState.Default);
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = true
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    await _notes.save(notes);
    _update();
  }

  void unarchive(List<Note> notes) async {
    emit(ActionState.Default);
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = false
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    await _notes.save(notes);
    _update();
  }

  void download(List<Note> notes, String type) async {
    emit(ActionState.Default);
    //TODO add download
  }

  void delete(List<Note> notes) async {
    emit(ActionState.Default);
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = false
        ..isDeleted = true
        ..lastUpdate = DateTime.now();
    });
    await _notes.save(notes);
    _update();
  }

  void undelete(List<Note> notes) async {
    emit(ActionState.Default);
    notes.forEach((note) {
      note
        ..isPinned = false
        ..isArchived = false
        ..isDeleted = false
        ..lastUpdate = DateTime.now();
    });
    await _notes.save(notes);
    _update();
  }

  void fullDelete(List<Note> notes) async {
    emit(ActionState.Default);
    _notes.fullDelete(notes);
    _update();
  }

  void _update() {
    _allNotesBloc.add(LoadAllNotes());
    _pinnedNotesBloc.add(LoadPinnedNotes());
    _archivedNotesBloc.add(LoadArchivedNotes());
    _deletedNotesBloc.add(LoadDeletedNotes());
  }
}
