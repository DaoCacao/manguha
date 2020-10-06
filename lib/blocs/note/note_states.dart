import 'package:manguha/data/note.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final Note note;

  NoteLoaded(this.note);
}

class NoteDeleted extends NoteState {}
