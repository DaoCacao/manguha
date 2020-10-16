import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/notes_all/all_notes_bloc.dart';
import 'package:manguha/blocs/notes_all/all_notes_events.dart';
import 'package:manguha/blocs/notes_all/all_notes_states.dart';
import 'package:manguha/res/strings.dart';
import 'package:manguha/widgets/note_list/note_list.dart';
import 'package:manguha/widgets/placeholders/empty.dart';
import 'package:manguha/widgets/placeholders/loading.dart';

class AllNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => AllNotesBloc(c.repository(), c.bloc()),
      child: BlocBuilder<AllNotesBloc, AllNotesState>(
        builder: (context, state) {
          if (state is AllNotesInitial)
            context.bloc<AllNotesBloc>().add(LoadAllNotes());
          if (state is AllNotesLoaded) return NoteListView(notes: state.list);
          if (state is AllNotesEmpty)
            return EmptyPlaceholder(text: AppStrings.emptyNoteList);
          return LoadingPlaceholder();
        },
      ),
    );
  }
}
