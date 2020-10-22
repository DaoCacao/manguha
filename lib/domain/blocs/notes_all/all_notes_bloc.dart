import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/domain/use_cases/notes/get_all_notes_by_query_use_case.dart';
import 'package:manguha/domain/use_cases/notes/get_all_notes_use_case.dart';
import 'package:manguha/domain/use_cases/note/save_note_use_case.dart';
import 'package:manguha/domain/use_cases/search/search_use_case.dart';

import 'all_notes_events.dart';
import 'all_notes_states.dart';

class AllNotesBloc extends Bloc<AllNotesEvent, AllNotesState> {
  final GetAllNotesUseCase _getAllNoteUseCase;
  final GetAllNotesByQueryUseCase _getAllNotesByQueryUseCase;
  final SearchNoteUseCase _searchNoteUseCase;
  final SaveNoteUseCase _saveNoteUseCase;

  AllNotesBloc(
    this._getAllNoteUseCase,
    this._getAllNotesByQueryUseCase,
    this._searchNoteUseCase,
    this._saveNoteUseCase,
  ) : super(AllNotesInitial()) {
    _searchNoteUseCase.onSearch
        .map((query) => SearchAllNotes(query))
        .listen(add);

    _saveNoteUseCase.onSaved.map((ids) => LoadAllNotes()).listen(add);
  }

  AllNotesBloc.get(BuildContext c)
      : this(
          c.repository(),
          c.repository(),
          c.repository(),
          c.repository(),
        );

  @override
  Stream<AllNotesState> mapEventToState(AllNotesEvent event) async* {
    if (event is LoadAllNotes) {
      yield* mapLoadAllNotes(event);
    } else if (event is SearchAllNotes) {
      yield* mapSearchNotes(event);
    }
  }

  Stream<AllNotesState> mapLoadAllNotes(LoadAllNotes event) async* {
    yield AllNotesLoading();

    final list = await _getAllNoteUseCase.get();

    if (list.isEmpty)
      yield AllNotesEmpty();
    else
      yield AllNotesLoaded(list);
  }

  Stream<AllNotesState> mapSearchNotes(SearchAllNotes event) async* {
    yield AllNotesLoading();

    final list = await _getAllNotesByQueryUseCase.get(event.query);

    if (list.isEmpty)
      yield AllNotesEmpty();
    else
      yield AllNotesLoaded(list);
  }
}
