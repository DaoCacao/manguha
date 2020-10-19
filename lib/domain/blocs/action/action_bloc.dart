import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/data/entities/note.dart';
import 'package:manguha/domain/use_cases/archive_note_use_case.dart';
import 'package:manguha/domain/use_cases/delete_note_use_case.dart';
import 'package:manguha/domain/use_cases/move_note_to_trash_use_case.dart';
import 'package:manguha/domain/use_cases/pin_note_use_case.dart';
import 'package:manguha/domain/use_cases/restore_note_from_trash_use_case.dart';
import 'package:manguha/domain/use_cases/save_note_as_pdf_use_case.dart';
import 'package:manguha/domain/use_cases/save_note_as_txt_use_case.dart';
import 'package:manguha/domain/use_cases/unarchive_note_use_case.dart';
import 'package:manguha/domain/use_cases/unpin_note_use_case.dart';

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

  void downloadAsTxt(List<Note> notes) {
    emit(ActionState.Default);
    _saveAsTxtUseCase.save(notes);
  }

  void downloadAsPdf(List<Note> notes) {
    emit(ActionState.Default);
    _saveAsPdfUseCase.save(notes);
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
