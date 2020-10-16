import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/search/search_cubit.dart';
import 'package:manguha/blocs/search/search_state.dart';
import 'package:manguha/data/note_repository.dart';

import 'pinned_notes_events.dart';
import 'pinned_notes_states.dart';

class PinnedNotesBloc extends Bloc<PinnedNotesEvent, PinnedNotesState> {
  final NoteRepository _notes;

  PinnedNotesBloc(
    this._notes,
    SearchCubit search,
  ) : super(PinnedNotesInitial()) {
    _notes.observable.listen((e) => add(LoadPinnedNotes()));

    search.listen(
      (state) {
        if (state is Default) {
          add(LoadPinnedNotes());
        } else if (state is Search) {
          add(SearchPinnedNotes(state.query));
        }
      },
    );
  }

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

    final list = await _notes.getPinned();

    if (list.isEmpty)
      yield PinnedNotesEmpty();
    else
      yield PinnedNotesLoaded(list);
  }

  Stream<PinnedNotesState> mapSearchNotes(SearchPinnedNotes event) async* {
    yield PinnedNotesLoading();

    final list = await _notes.getPinnedByQuery(event.query);

    if (list.isEmpty)
      yield PinnedNotesEmpty();
    else
      yield PinnedNotesLoaded(list);
  }
}
