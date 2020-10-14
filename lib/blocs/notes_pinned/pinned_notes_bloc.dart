import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/data/note_repository.dart';

import 'pinned_notes_events.dart';
import 'pinned_notes_states.dart';

class PinnedNotesBloc extends Bloc<PinnedNotesEvent, PinnedNotesState> {
  final NoteRepository _notes;

  String query = "";

  PinnedNotesBloc(this._notes) : super(PinnedNotesInitial());

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

    final list = query.isEmpty
        ? await _notes.getPinned()
        : await _notes.getPinnedByQuery(query);

    if (list.isEmpty)
      yield PinnedNotesEmpty();
    else
      yield PinnedNotesLoaded(list);
  }

  Stream<PinnedNotesState> mapSearchNotes(SearchPinnedNotes event) async* {
    query = event.query;
    add(LoadPinnedNotes());
  }
}
