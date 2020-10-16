import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: child,
    );
  }
}
