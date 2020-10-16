import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/search/search_cubit.dart';
import 'package:manguha/blocs/search/search_state.dart';
import 'package:manguha/data/note_repository.dart';

import 'all_notes_events.dart';
import 'all_notes_states.dart';

class AllNotesBloc extends Bloc<AllNotesEvent, AllNotesState> {
  final NoteRepository _notes;

  AllNotesBloc(
    this._notes,
    SearchCubit search,
  ) : super(AllNotesInitial()) {
    _notes.observable.listen((e) => add(LoadAllNotes()));

    search.listen(
      (state) {
        if (state is Default) {
          add(LoadAllNotes());
        } else if (state is Search) {
          add(SearchAllNotes(state.query));
        }
      },
    );
  }

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

    final list = await _notes.getAll();

    if (list.isEmpty)
      yield AllNotesEmpty();
    else
      yield AllNotesLoaded(list);
  }

  Stream<AllNotesState> mapSearchNotes(SearchAllNotes event) async* {
    yield AllNotesLoading();

    final list = await _notes.getAllByQuery(event.query);

    if (list.isEmpty)
      yield AllNotesEmpty();
    else
      yield AllNotesLoaded(list);
  }
}
