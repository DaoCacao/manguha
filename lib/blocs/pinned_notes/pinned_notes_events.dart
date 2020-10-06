abstract class PinnedNotesEvent {}

class LoadPinnedNotes extends PinnedNotesEvent {}

class SearchPinnedNotes extends PinnedNotesEvent {
  final String query;

  SearchPinnedNotes(this.query);
}
