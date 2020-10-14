import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/data/note_repository.dart';

import 'deleted_notes_events.dart';
import 'deleted_notes_states.dart';

class DeletedNotesBloc extends Bloc<DeletedNotesEvent, DeletedNotesState> {
  final NoteRepository _notes;

  String query = "";

  DeletedNotesBloc(this._notes) : super(DeletedNotesInitial());

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

    final list = query.isEmpty
        ? await _notes.getDeleted()
        : await _notes.getDeletedByQuery(query);

    if (list.isEmpty)
      yield DeletedNotesEmpty();
    else
      yield DeletedNotesLoaded(list);
  }

  Stream<DeletedNotesState> mapSearchNotes(SearchDeletedNotes event) async* {
    query = event.query;
    add(LoadDeletedNotes());
  }
}
