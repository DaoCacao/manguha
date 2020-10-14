import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/data/note_repository.dart';

import 'all_notes_events.dart';
import 'all_notes_states.dart';

class AllNotesBloc extends Bloc<AllNotesEvent, AllNotesState> {
  final NoteRepository _notes;

  String query = "";

  AllNotesBloc(this._notes) : super(AllNotesInitial());

  @override
  Stream<AllNotesState> mapEventToState(AllNotesEvent event) async* {
    if (event is LoadAllNotes) {
      yield* mapLoadNotes(event);
    } else if (event is SearchAllNotes) {
      yield* mapSearchNotes(event);
    }
  }

  Stream<AllNotesState> mapLoadNotes(LoadAllNotes event) async* {
    yield AllNotesLoading();

    final list = query.isEmpty
        ? await _notes.getAll()
        : await _notes.getAllByQuery(query);

    if (list.isEmpty)
      yield AllNotesEmpty();
    else
      yield AllNotesLoaded(list);
  }

  Stream<AllNotesState> mapSearchNotes(SearchAllNotes event) async* {
    query = event.query;
    add(LoadAllNotes());
  }
}
