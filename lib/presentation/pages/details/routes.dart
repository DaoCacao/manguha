import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/domain/blocs/note/note_bloc.dart';
import 'package:manguha/presentation/pages/details/page_details.dart';

class CreateNotePageRoute extends MaterialPageRoute {
  CreateNotePageRoute()
      : super(
          builder: (context) {
            return BlocProvider(
              create: (c) => NoteBloc.get(c),
              child: DetailsPage.create(),
            );
          },
        );
}

class OpenNotePageRoute extends MaterialPageRoute {
  OpenNotePageRoute(int noteId)
      : super(
          builder: (context) {
            return BlocProvider(
              create: (c) => NoteBloc.get(c),
              child: DetailsPage.open2(noteId),
            );
          },
        );
}
