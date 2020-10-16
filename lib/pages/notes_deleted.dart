import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/notes_deleted/deleted_notes_bloc.dart';
import 'package:manguha/blocs/notes_deleted/deleted_notes_events.dart';
import 'package:manguha/blocs/notes_deleted/deleted_notes_states.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/strings.dart';
import 'package:manguha/widgets/note_list/note_list.dart';
import 'package:manguha/widgets/placeholders/empty.dart';
import 'package:manguha/widgets/placeholders/loading.dart';

class DeletedNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => DeletedNotesBloc(c.repository(), c.bloc()),
      child: Stack(
        children: [
          BlocBuilder<DeletedNotesBloc, DeletedNotesState>(
            builder: (context, state) {
              if (state is DeletedNotesInitial)
                context.bloc<DeletedNotesBloc>().add(LoadDeletedNotes());
              if (state is DeletedNotesLoaded)
                return Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: NoteListView(notes: state.list),
                );
              if (state is DeletedNotesEmpty)
                return EmptyPlaceholder(text: AppStrings.emptyTrashList);
              return LoadingPlaceholder();
            },
          ),
          Container(
            height: 40,
            width: double.maxFinite,
            color: AppColors.textSecondary,
            child: Center(
              child: Text(
                AppStrings.hintClearTrash,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
