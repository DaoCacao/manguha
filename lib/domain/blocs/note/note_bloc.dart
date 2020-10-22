import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manguha/data/entities/note.dart';
import 'package:manguha/domain/use_cases/copy_note_use_case.dart';
import 'package:manguha/domain/use_cases/get_note_use_case.dart';
import 'package:manguha/domain/use_cases/load_camera_image_use_case.dart';
import 'package:manguha/domain/use_cases/load_gallery_image_use_case.dart';
import 'package:manguha/domain/use_cases/save_note_use_case.dart';

import 'note_events.dart';
import 'note_states.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNoteUseCase _getNoteUseCase;
  final LoadGalleryImageUseCase _loadGalleryImageUseCase;
  final LoadCameraImageUseCase _loadCameraImageUseCase;
  final CopyNoteUseCase _copyNoteUseCase;
  final SaveNoteUseCase _saveNoteUseCase;

  Note note;
  bool isEdited = false;

  NoteBloc(
    this._getNoteUseCase,
    this._loadGalleryImageUseCase,
    this._loadCameraImageUseCase,
    this._copyNoteUseCase,
    this._saveNoteUseCase,
  ) : super(NoteInitial());

  NoteBloc.get(BuildContext c)
      : this(
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
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
    note = await _getNoteUseCase.get(event.id);
    yield NoteLoaded(note, note.id == null);
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
      await _saveNoteUseCase.save([note]);
    }
  }

  Stream<NoteState> mapCopyNote(CopyNote event) async* {
    await _copyNoteUseCase.copy(note);
    yield NoteCopied();
  }

  Stream<NoteState> mapAddImage(AddNoteImage event) async* {
    var bytes;
    if (event.source == ImageSource.gallery) {
      bytes = await _loadGalleryImageUseCase.load();
    } else {
      bytes = await _loadCameraImageUseCase.load();
    }

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
