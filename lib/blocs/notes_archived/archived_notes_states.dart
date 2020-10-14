import 'package:manguha/data/note.dart';

abstract class ArchivedNotesState {}

class ArchivedNotesInitial extends ArchivedNotesState {}

class ArchivedNotesLoading extends ArchivedNotesState {}

class ArchivedNotesLoaded extends ArchivedNotesState {
  final List<Note> list;

  ArchivedNotesLoaded(this.list);
}

class ArchivedNotesEmpty extends ArchivedNotesState {}
