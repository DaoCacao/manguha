import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/all_notes/all_notes_bloc.dart';
import 'package:manguha/blocs/all_notes/all_notes_events.dart';
import 'package:manguha/blocs/pinned_notes/pinned_notes_bloc.dart';
import 'package:manguha/blocs/pinned_notes/pinned_notes_events.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/data/note_repository.dart';

import 'note_events.dart';
import 'note_states.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _notes;
  final AllNotesBloc _allNotesBloc;
  final PinnedNotesBloc _pinnedNotesBloc;

  Note _note;
  bool isEdited = false;

  NoteBloc(this._notes, this._allNotesBloc, this._pinnedNotesBloc)
      : super(NoteInitial());

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is LoadNote) {
      yield* mapLoadNote(event);
    } else if (event is ChangeNoteTitle) {
      yield* mapChangeNoteTitle(event);
    } else if (event is ChangeNoteContent) {
      yield* mapChangeNoteContent(event);
    } else if (event is SaveNote) {
      yield* mapSaveNote(event);
    } else if (event is PinNote) {
      yield* mapPinNote(event);
    }
  }

  Stream<NoteState> mapLoadNote(LoadNote event) async* {
    yield NoteLoading();
    _note = event.id == null ? Note.create() : await _notes.get(event.id);
    yield NoteLoaded(_note);
  }

  Stream<NoteState> mapChangeNoteTitle(ChangeNoteTitle event) async* {
    _note
      ..title = event.text
      ..lastUpdate = DateTime.now();
    isEdited = true;
  }

  Stream<NoteState> mapChangeNoteContent(ChangeNoteContent event) async* {
    _note
      ..content = event.text
      ..lastUpdate = DateTime.now();
    isEdited = true;
  }

  Stream<NoteState> mapSaveNote(SaveNote event) async* {
    if (_note != null && isEdited) {
      await _notes.save(_note);
      _allNotesBloc.add(LoadAllNotes());
      _pinnedNotesBloc.add(LoadPinnedNotes());
    }
  }

  Stream<NoteState> mapPinNote(PinNote event) async* {
    _note..isPinned = !_note.isPinned;
    isEdited = true;
  }
}
