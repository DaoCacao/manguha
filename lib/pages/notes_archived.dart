import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/notes_archived/archived_notes_bloc.dart';
import 'package:manguha/blocs/notes_archived/archived_notes_events.dart';
import 'package:manguha/blocs/notes_archived/archived_notes_states.dart';
import 'package:manguha/res/strings.dart';
import 'package:manguha/widgets/note_list/note_list.dart';
import 'package:manguha/widgets/placeholders/empty.dart';
import 'package:manguha/widgets/placeholders/loading.dart';

class ArchivedNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => ArchivedNotesBloc(c.repository(), c.bloc()),
      child: BlocBuilder<ArchivedNotesBloc, ArchivedNotesState>(
        builder: (context, state) {
          if (state is ArchivedNotesInitial)
            context.bloc<ArchivedNotesBloc>().add(LoadArchivedNotes());
          if (state is ArchivedNotesLoaded)
            return NoteListView(notes: state.list);
          if (state is ArchivedNotesEmpty)
            return EmptyPlaceholder(text: AppStrings.emptyArchivedList);
          return LoadingPlaceholder();
        },
      ),
    );
  }
}
