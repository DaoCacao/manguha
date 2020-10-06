import 'package:manguha/data/note.dart';

abstract class PinnedNotesState {}

class PinnedNotesInitial extends PinnedNotesState {}

class PinnedNotesLoading extends PinnedNotesState {}

class PinnedNotesLoaded extends PinnedNotesState {
  final List<Note> list;

  PinnedNotesLoaded(this.list);
}

class PinnedNotesEmpty extends PinnedNotesState {}
