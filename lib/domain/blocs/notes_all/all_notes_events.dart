abstract class AllNotesEvent {}

class LoadAllNotes extends AllNotesEvent {}

class SearchAllNotes extends AllNotesEvent {
  final String query;

  SearchAllNotes(this.query);
}
