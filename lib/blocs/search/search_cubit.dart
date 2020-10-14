import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/notes_archived/archived_notes_events.dart';
import 'package:manguha/blocs/notes_deleted/deleted_notes_bloc.dart';
import 'package:manguha/blocs/notes_deleted/deleted_notes_events.dart';
import 'package:manguha/blocs/search/search_state.dart';

import '../notes_all/all_notes_bloc.dart';
import '../notes_all/all_notes_events.dart';
import '../notes_archived/archived_notes_bloc.dart';
import '../notes_pinned/pinned_notes_bloc.dart';
import '../notes_pinned/pinned_notes_events.dart';

class SearchCubit extends Cubit<SearchState> {
  final AllNotesBloc _allNotesBloc;
  final PinnedNotesBloc _pinnedNotesBloc;
  final ArchivedNotesBloc _archivedNotesBloc;
  final DeletedNotesBloc _deletedNotesBloc;

  SearchCubit(
    this._allNotesBloc,
    this._pinnedNotesBloc,
    this._archivedNotesBloc,
    this._deletedNotesBloc,
  ) : super(SearchState.Default);

  SearchCubit.get(BuildContext c)
      : this(
          c.bloc(),
          c.bloc(),
          c.bloc(),
          c.bloc(),
        );

  void switchState() {
    switch (state) {
      case SearchState.Default:
        emit(SearchState.Search);
        break;
      case SearchState.Search:
        search("");
        emit(SearchState.Default);
        break;
    }
  }

  void search(String query) {
    _allNotesBloc.add(SearchAllNotes(query));
    _pinnedNotesBloc.add(SearchPinnedNotes(query));
    _archivedNotesBloc.add(SearchArchivedNotes(query));
    _deletedNotesBloc.add(SearchDeletedNotes(query));
  }
}
