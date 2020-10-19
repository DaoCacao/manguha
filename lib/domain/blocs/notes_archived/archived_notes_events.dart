abstract class ArchivedNotesEvent {}

class LoadArchivedNotes extends ArchivedNotesEvent {}

class SearchArchivedNotes extends ArchivedNotesEvent {
  final String query;

  SearchArchivedNotes(this.query);
}
