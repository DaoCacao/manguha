import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/search/search_cubit.dart';
import 'package:manguha/blocs/search/search_state.dart';
import 'package:manguha/data/note_repository.dart';

import 'deleted_notes_events.dart';
import 'deleted_notes_states.dart';

class DeletedNotesBloc extends Bloc<DeletedNotesEvent, DeletedNotesState> {
  final NoteRepository _notes;

  DeletedNotesBloc(
    this._notes,
    SearchCubit search,
  ) : super(DeletedNotesInitial()) {
    _notes.observable.listen((e) => add(LoadDeletedNotes()));

    search.listen(
      (state) {
        if (state is Default) {
          add(LoadDeletedNotes());
        } else if (state is Search) {
          add(SearchDeletedNotes(state.query));
        }
      },
    );
  }

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

    final list = await _notes.getDeleted();

    if (list.isEmpty)
      yield DeletedNotesEmpty();
    else
      yield DeletedNotesLoaded(list);
  }

  Stream<DeletedNotesState> mapSearchNotes(SearchDeletedNotes event) async* {
    yield DeletedNotesLoading();

    final list = await _notes.getDeletedByQuery(event.query);

    if (list.isEmpty)
      yield DeletedNotesEmpty();
    else
      yield DeletedNotesLoaded(list);
  }
}
