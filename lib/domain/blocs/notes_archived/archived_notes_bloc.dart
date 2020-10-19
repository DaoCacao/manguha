import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/domain/use_cases/get_archived_notes_by_query_use_case.dart';
import 'package:manguha/domain/use_cases/get_archived_notes_use_case.dart';
import 'package:manguha/domain/use_cases/save_note_use_case.dart';
import 'package:manguha/domain/use_cases/search_use_case.dart';

import 'archived_notes_events.dart';
import 'archived_notes_states.dart';

class ArchivedNotesBloc extends Bloc<ArchivedNotesEvent, ArchivedNotesState> {
  final GetArchivedNotesUseCase _getArchivedNotesUseCase;
  final GetArchivedNotesByQueryUseCase _getArchivedNotesByQueryUseCase;
  final SearchNoteUseCase _searchNoteUseCase;
  final SaveNoteUseCase _saveNoteUseCase;

  ArchivedNotesBloc(
    this._getArchivedNotesUseCase,
    this._getArchivedNotesByQueryUseCase,
    this._searchNoteUseCase,
    this._saveNoteUseCase,
  ) : super(ArchivedNotesInitial()) {
    _searchNoteUseCase.onSearch
        .map((query) => SearchArchivedNotes(query))
        .listen(add);

    _saveNoteUseCase.onSaved.map((ids) => LoadArchivedNotes()).listen(add);
  }

  ArchivedNotesBloc.get(BuildContext c)
      : this(
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
        );

  @override
  Stream<ArchivedNotesState> mapEventToState(ArchivedNotesEvent event) async* {
    if (event is LoadArchivedNotes) {
      yield* mapLoadNotes(event);
    } else if (event is SearchArchivedNotes) {
      yield* mapSearchNotes(event);
    }
  }

  Stream<ArchivedNotesState> mapLoadNotes(LoadArchivedNotes event) async* {
    yield ArchivedNotesLoading();

    final list = await _getArchivedNotesUseCase.get();

    if (list.isEmpty)
      yield ArchivedNotesEmpty();
    else
      yield ArchivedNotesLoaded(list);
  }

  Stream<ArchivedNotesState> mapSearchNotes(SearchArchivedNotes event) async* {
    yield ArchivedNotesLoading();

    final list = await _getArchivedNotesByQueryUseCase.get(event.query);

    if (list.isEmpty)
      yield ArchivedNotesEmpty();
    else
      yield ArchivedNotesLoaded(list);
  }
}
