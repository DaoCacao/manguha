abstract class SearchState {}

class Default extends SearchState {}

class Search extends SearchState {
  final String query;

  Search(this.query);
}
