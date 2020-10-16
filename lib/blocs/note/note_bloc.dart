import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/data/note_repository.dart';

import 'note_events.dart';
import 'note_states.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _notes;

  Note note;
  bool isEdited = false;

  NoteBloc(this._notes) : super(NoteInitial());

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
    } else if (event is DeleteNoteImage) {
      yield* mapDeleteImage(event);
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
        .catchError((e) => null);

    if (bytes == null) {
      yield ImageAddedError();
    } else {
      note
        ..image = bytes
        ..lastUpdate = DateTime.now();
      isEdited = true;
      yield ImageChanged(note.image);
    }
  }

  Stream<NoteState> mapDeleteImage(DeleteNoteImage event) async* {
    note
      ..image = Uint8List(0)
      ..lastUpdate = DateTime.now();
    isEdited = true;
    yield ImageChanged(note.image);
  }
}
