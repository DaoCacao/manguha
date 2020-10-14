import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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

import 'note_events.dart';
import 'note_states.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _notes;
  final AllNotesBloc _allNotesBloc;
  final PinnedNotesBloc _pinnedNotesBloc;
  final ArchivedNotesBloc _archivedNotesBloc;
  final DeletedNotesBloc _deletedNotesBloc;

  Note note;
  bool isEdited = false;

  NoteBloc(
    this._notes,
    this._allNotesBloc,
    this._pinnedNotesBloc,
    this._archivedNotesBloc,
    this._deletedNotesBloc,
  ) : super(NoteInitial());

  NoteBloc.get(BuildContext c)
      : this(
          c.repository(),
          c.bloc(),
          c.bloc(),
          c.bloc(),
          c.bloc(),
        );

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
    } else if (event is ArchiveNote) {
      yield* mapArchiveNote(event);
    } else if (event is DeleteNote) {
      yield* mapDeleteNote(event);
    } else if (event is CopyNote) {
      yield* mapCopyNote(event);
    } else if (event is AddNoteImage) {
      yield* mapAddImage(event);
    }
  }

  Stream<NoteState> mapLoadNote(LoadNote event) async* {
    yield NoteLoading();
    note = event.id == null ? Note.create() : await _notes.get(event.id);
    yield NoteLoaded(note, event.id == null);
  }

  Stream<NoteState> mapChangeNoteTitle(ChangeNoteTitle event) async* {
    note
      ..title = event.text
      ..lastUpdate = DateTime.now();
    isEdited = true;
  }

  Stream<NoteState> mapChangeNoteContent(ChangeNoteContent event) async* {
    note
      ..content = event.text
      ..lastUpdate = DateTime.now();
    isEdited = true;
  }

  Stream<NoteState> mapSaveNote(SaveNote event) async* {
    if (note != null && isEdited) {
      await _notes.save([note]);
      _allNotesBloc.add(LoadAllNotes());
      _pinnedNotesBloc.add(LoadPinnedNotes());
      _archivedNotesBloc.add(LoadArchivedNotes());
      _deletedNotesBloc.add(LoadDeletedNotes());
    }
  }

  Stream<NoteState> mapPinNote(PinNote event) async* {
    note
      ..isPinned = !note.isPinned
      ..lastUpdate = DateTime.now();
    isEdited = true;
  }

  Stream<NoteState> mapArchiveNote(ArchiveNote event) async* {
    note
      ..isDeleted = true
      ..lastUpdate = DateTime.now();
    isEdited = true;
    yield NoteDeleted();
  }

  Stream<NoteState> mapDeleteNote(DeleteNote event) async* {
    note
      ..isDeleted = true
      ..lastUpdate = DateTime.now();
    isEdited = true;
    yield NoteDeleted();
  }

  Stream<NoteState> mapCopyNote(CopyNote event) async* {
    Clipboard.setData(ClipboardData(text: note.title + "\n" + note.content));
    yield NoteCopied();
  }

  Stream<NoteState> mapAddImage(AddNoteImage event) async* {
    final bytes = await ImagePicker()
        .getImage(source: event.source)
        .then((image) => image.readAsBytes())
        .catchError((e) => null); //TODO check if denied

    if (bytes == null) {
      yield ImageAddedError();
    } else {
      note
        ..image = bytes
        ..lastUpdate = DateTime.now();
      isEdited = true;
      yield ImageAdded(bytes);
    }
  }
}
