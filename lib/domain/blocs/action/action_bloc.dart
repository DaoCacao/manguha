import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/data/entities/note.dart';
import 'package:manguha/domain/use_cases/note/archive_note_use_case.dart';
import 'package:manguha/domain/use_cases/note/delete_note_use_case.dart';
import 'package:manguha/domain/use_cases/note/move_note_to_trash_use_case.dart';
import 'package:manguha/domain/use_cases/note/pin_note_use_case.dart';
import 'package:manguha/domain/use_cases/note/restore_note_from_trash_use_case.dart';
import 'package:manguha/domain/use_cases/note/unarchive_note_use_case.dart';
import 'package:manguha/domain/use_cases/note/unpin_note_use_case.dart';
import 'package:manguha/domain/use_cases/save_local/save_note_as_pdf_use_case.dart';
import 'package:manguha/domain/use_cases/save_local/save_note_as_txt_use_case.dart';

import 'action_state.dart';

class ActionCubit extends Cubit<ActionState> {
  final SaveNoteAsTxtUseCase _saveAsTxtUseCase;
  final SaveNoteAsPdfUseCase _saveAsPdfUseCase;
  final PinNoteUseCase _pinNoteUseCase;
  final UnpinNoteUseCase _unpinNoteUseCase;
  final ArchiveNoteUseCase _archiveNoteUseCase;
  final UnarchiveNoteUseCase _unarchiveNoteUseCase;
  final MoveNoteToTrashUseCase _moveToTrashUseCase;
  final RestoreNoteFromTrashUseCase _restoreFromTrashUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;

  ActionCubit(
    this._saveAsTxtUseCase,
    this._saveAsPdfUseCase,
    this._pinNoteUseCase,
    this._unpinNoteUseCase,
    this._archiveNoteUseCase,
    this._unarchiveNoteUseCase,
    this._moveToTrashUseCase,
    this._restoreFromTrashUseCase,
    this._deleteNoteUseCase,
  ) : super(ActionState.Default);

  ActionCubit.get(BuildContext c)
      : this(
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
        );

  void changeState(ActionState state) => emit(state);

  void pin(List<Note> notes) {
    emit(ActionState.Default);
    _pinNoteUseCase.pin(notes);
  }

  void unpin(List<Note> notes) {
    emit(ActionState.Default);
    _unpinNoteUseCase.unpin(notes);
  }

  void archive(List<Note> notes) {
    emit(ActionState.Default);
    _archiveNoteUseCase.archive(notes);
  }

  void unarchive(List<Note> notes) {
    emit(ActionState.Default);
    _unarchiveNoteUseCase.unarchive(notes);
  }

  Future<String> downloadAsTxt(List<Note> notes) {
    emit(ActionState.Default);
    return _saveAsTxtUseCase
        .save(notes)
        .then((files) => files.first.parent.path);
  }

  Future downloadAsPdf(List<Note> notes) {
    emit(ActionState.Default);
    return _saveAsPdfUseCase
        .save(notes)
        .then((files) => files.first.parent.path);
  }

  void delete(List<Note> notes) {
    emit(ActionState.Default);
    _moveToTrashUseCase.moveToTrash(notes);
  }

  void undelete(List<Note> notes) {
    emit(ActionState.Default);
    _restoreFromTrashUseCase.restoreFromTrash(notes);
  }

  void fullDelete(List<Note> notes) {
    emit(ActionState.Default);
    _deleteNoteUseCase.delete(notes);
  }
}
