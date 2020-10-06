import 'package:manguha/data/note.dart';

abstract class AllNotesState {}

class AllNotesInitial extends AllNotesState {}

class AllNotesLoading extends AllNotesState {}

class AllNotesLoaded extends AllNotesState {
  final List<Note> list;

  AllNotesLoaded(this.list);
}

class AllNotesEmpty extends AllNotesState {}
