import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/data/note_repository.dart';

import 'archived_notes_events.dart';
import 'archived_notes_states.dart';

class ArchivedNotesBloc extends Bloc<ArchivedNotesEvent, ArchivedNotesState> {
  final NoteRepository _notes;

  String query = "";

  ArchivedNotesBloc(this._notes) : super(ArchivedNotesInitial());

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

    final list = query.isEmpty
        ? await _notes.getArchived()
        : await _notes.getArchivedByQuery(query);

    if (list.isEmpty)
      yield ArchivedNotesEmpty();
    else
      yield ArchivedNotesLoaded(list);
  }

  Stream<ArchivedNotesState> mapSearchNotes(SearchArchivedNotes event) async* {
    query = event.query;
    add(LoadArchivedNotes());
  }
}
