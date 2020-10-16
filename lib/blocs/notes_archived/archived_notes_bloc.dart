import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/search/search_cubit.dart';
import 'package:manguha/blocs/search/search_state.dart';
import 'package:manguha/data/note_repository.dart';

import 'archived_notes_events.dart';
import 'archived_notes_states.dart';

class ArchivedNotesBloc extends Bloc<ArchivedNotesEvent, ArchivedNotesState> {
  final NoteRepository _notes;

  ArchivedNotesBloc(
    this._notes,
    SearchCubit search,
  ) : super(ArchivedNotesInitial()) {
    _notes.observable.listen((e) => add(LoadArchivedNotes()));

    search.listen(
      (state) {
        if (state is Default) {
          add(LoadArchivedNotes());
        } else if (state is Search) {
          add(SearchArchivedNotes(state.query));
        }
      },
    );
  }

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

    final list = await _notes.getArchived();

    if (list.isEmpty)
      yield ArchivedNotesEmpty();
    else
      yield ArchivedNotesLoaded(list);
  }

  Stream<ArchivedNotesState> mapSearchNotes(SearchArchivedNotes event) async* {
    yield ArchivedNotesLoading();

    final list = await _notes.getArchivedByQuery(event.query);

    if (list.isEmpty)
      yield ArchivedNotesEmpty();
    else
      yield ArchivedNotesLoaded(list);
  }
}
