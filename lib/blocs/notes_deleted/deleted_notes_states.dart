import 'package:manguha/data/note.dart';

abstract class DeletedNotesState {}

class DeletedNotesInitial extends DeletedNotesState {}

class DeletedNotesLoading extends DeletedNotesState {}

class DeletedNotesLoaded extends DeletedNotesState {
  final List<Note> list;

  DeletedNotesLoaded(this.list);
}

class DeletedNotesEmpty extends DeletedNotesState {}
