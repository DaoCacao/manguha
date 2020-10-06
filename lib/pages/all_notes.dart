import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/all_notes/all_notes_bloc.dart';
import 'package:manguha/blocs/all_notes/all_notes_events.dart';
import 'package:manguha/blocs/all_notes/all_notes_states.dart';
import 'package:manguha/res/strings.dart';
import 'package:manguha/widgets/empty.dart';
import 'package:manguha/widgets/loading.dart';
import 'package:manguha/widgets/note_list.dart';

class AllNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllNotesBloc, AllNotesState>(
      builder: (context, state) {
        if (state is AllNotesInitial)
          context.bloc<AllNotesBloc>().add(LoadAllNotes());
        if (state is AllNotesLoaded) return NoteListView(notes: state.list);
        if (state is AllNotesEmpty)
          return EmptyPlaceholder(text: AppStrings.emptyNoteList);
        return LoadingPlaceholder();
      },
    );
  }
}
