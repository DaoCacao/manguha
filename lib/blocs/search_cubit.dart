import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/pinned_notes/pinned_notes_bloc.dart';
import 'package:manguha/blocs/pinned_notes/pinned_notes_events.dart';

import 'all_notes/all_notes_bloc.dart';
import 'all_notes/all_notes_events.dart';

class SearchCubit extends Cubit<bool> {
  final AllNotesBloc allNotes;
  final PinnedNotesBloc pinnedNotes;

  SearchCubit(this.allNotes, this.pinnedNotes) : super(false);

  void switchState() {
    if (state) search("");
    emit(!state);
  }

  void search(String query) {
    allNotes.add(SearchAllNotes(query));
    pinnedNotes.add(SearchPinnedNotes(query));
  }
}
