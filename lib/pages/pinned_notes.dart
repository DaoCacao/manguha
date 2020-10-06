import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/pinned_notes/pinned_notes_bloc.dart';
import 'package:manguha/blocs/pinned_notes/pinned_notes_events.dart';
import 'package:manguha/blocs/pinned_notes/pinned_notes_states.dart';
import 'package:manguha/res/strings.dart';
import 'package:manguha/widgets/empty.dart';
import 'package:manguha/widgets/loading.dart';
import 'package:manguha/widgets/note_list.dart';

class PinnedNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinnedNotesBloc, PinnedNotesState>(
      builder: (context, state) {
        if (state is PinnedNotesInitial)
          context.bloc<PinnedNotesBloc>().add(LoadPinnedNotes());
        if (state is PinnedNotesLoaded) return NoteListView(notes: state.list);
        if (state is PinnedNotesEmpty)
          return EmptyPlaceholder(text: AppStrings.emptyPinnedList);
        return LoadingPlaceholder();
      },
    );
  }
}