import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/domain/use_cases/notes/get_deleted_notes_by_query_use_case.dart';
import 'package:manguha/domain/use_cases/notes/get_deleted_notes_use_case.dart';
import 'package:manguha/domain/use_cases/note/save_note_use_case.dart';
import 'package:manguha/domain/use_cases/search/search_use_case.dart';

import '../../use_cases/note/delete_note_use_case.dart';
import 'deleted_notes_events.dart';
import 'deleted_notes_states.dart';

class DeletedNotesBloc extends Bloc<DeletedNotesEvent, DeletedNotesState> {
  final GetDeletedNotesUseCase _getDeletedNotesUseCase;
  final GetDeletedNotesByQueryUseCase _getDeletedNotesByQueryUseCase;
  final SearchNoteUseCase _searchNoteUseCase;
  final SaveNoteUseCase _saveNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;

  DeletedNotesBloc(
    this._getDeletedNotesUseCase,
    this._getDeletedNotesByQueryUseCase,
    this._searchNoteUseCase,
    this._saveNoteUseCase,
    this._deleteNoteUseCase,
  ) : super(DeletedNotesInitial()) {
    _searchNoteUseCase.onSearch
        .map((query) => SearchDeletedNotes(query))
        .listen(add);

    _saveNoteUseCase.onSaved.map((ids) => LoadDeletedNotes()).listen(add);
    _deleteNoteUseCase.onDeleted.map((ids) => LoadDeletedNotes()).listen(add);
  }

  DeletedNotesBloc.get(BuildContext c)
      : this(
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
        );

  @override
  Stream<DeletedNotesState> mapEventToState(DeletedNotesEvent event) async* {
    if (event is LoadDeletedNotes) {
      yield* mapLoadNotes(event);
    } else if (event is SearchDeletedNotes) {
      yield* mapSearchNotes(event);
    }
  }

  Stream<DeletedNotesState> mapLoadNotes(LoadDeletedNotes event) async* {
    yield DeletedNotesLoading();

    final list = await _getDeletedNotesUseCase.get();

    if (list.isEmpty)
      yield DeletedNotesEmpty();
    else
      yield DeletedNotesLoaded(list);
  }

  Stream<DeletedNotesState> mapSearchNotes(SearchDeletedNotes event) async* {
    yield DeletedNotesLoading();

    final list = await _getDeletedNotesByQueryUseCase.get(event.query);

    if (list.isEmpty)
      yield DeletedNotesEmpty();
    else
      yield DeletedNotesLoaded(list);
  }
}
