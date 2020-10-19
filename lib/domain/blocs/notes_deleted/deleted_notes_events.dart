abstract class DeletedNotesEvent {}

class LoadDeletedNotes extends DeletedNotesEvent {}

class SearchDeletedNotes extends DeletedNotesEvent {
  final String query;

  SearchDeletedNotes(this.query);
}
