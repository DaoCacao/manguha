import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/domain/use_cases/get_pinned_notes_by_query_use_case.dart';
import 'package:manguha/domain/use_cases/get_pinned_notes_use_case.dart';
import 'package:manguha/domain/use_cases/save_note_use_case.dart';
import 'package:manguha/domain/use_cases/search_use_case.dart';

import 'pinned_notes_events.dart';
import 'pinned_notes_states.dart';

class PinnedNotesBloc extends Bloc<PinnedNotesEvent, PinnedNotesState> {
  final GetPinnedNotesUseCase _getPinnedNotesUseCase;
  final GetPinnedNotesByQueryUseCase _getPinnedNotesByQueryUseCase;
  final SearchNoteUseCase _searchNoteUseCase;
  final SaveNoteUseCase _saveNoteUseCase;

  PinnedNotesBloc(
    this._getPinnedNotesUseCase,
    this._getPinnedNotesByQueryUseCase,
    this._searchNoteUseCase,
    this._saveNoteUseCase,
  ) : super(PinnedNotesInitial()) {
    _searchNoteUseCase.onSearch
        .map((query) => SearchPinnedNotes(query))
        .listen(add);

    _saveNoteUseCase.onSaved.map((ids) => LoadPinnedNotes()).listen(add);
  }

  PinnedNotesBloc.get(BuildContext c)
      : this(
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
        );

  @override
  Stream<PinnedNotesState> mapEventToState(PinnedNotesEvent event) async* {
    if (event is LoadPinnedNotes) {
      yield* mapLoadNotes(event);
    } else if (event is SearchPinnedNotes) {
      yield* mapSearchNotes(event);
    }
  }

  Stream<PinnedNotesState> mapLoadNotes(LoadPinnedNotes event) async* {
    yield PinnedNotesLoading();

    final list = await _getPinnedNotesUseCase.get();

    if (list.isEmpty)
      yield PinnedNotesEmpty();
    else
      yield PinnedNotesLoaded(list);
  }

  Stream<PinnedNotesState> mapSearchNotes(SearchPinnedNotes event) async* {
    yield PinnedNotesLoading();

    final list = await _getPinnedNotesByQueryUseCase.get(event.query);

    if (list.isEmpty)
      yield PinnedNotesEmpty();
    else
      yield PinnedNotesLoaded(list);
  }
}
