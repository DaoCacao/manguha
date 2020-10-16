import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/menu/menu_bloc.dart';
import 'blocs/notes_all/all_notes_bloc.dart';
import 'blocs/notes_archived/archived_notes_bloc.dart';
import 'blocs/notes_deleted/deleted_notes_bloc.dart';
import 'blocs/notes_pinned/pinned_notes_bloc.dart';
import 'data/database.dart';
import 'data/note_repository.dart';

class DataLayer extends StatelessWidget {
  final Widget child;

  const DataLayer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => NoteDatabase()),
        RepositoryProvider(create: (c) => NoteRepository(c.repository())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => MenuCubit()),
          BlocProvider(create: (c) => AllNotesBloc(c.repository())),
          BlocProvider(create: (c) => PinnedNotesBloc(c.repository())),
          BlocProvider(create: (c) => ArchivedNotesBloc(c.repository())),
          BlocProvider(create: (c) => DeletedNotesBloc(c.repository())),
        ],
        child: child,
      ),
    );
  }
}
