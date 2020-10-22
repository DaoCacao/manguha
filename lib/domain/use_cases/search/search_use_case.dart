import 'dart:async';

class SearchNoteUseCase {
  StreamController<String> _controller;
  Stream<String> onSearch;

  SearchNoteUseCase() {
    _controller = StreamController.broadcast();
    onSearch = _controller.stream;
  }

  Future search(String query) async {
    _controller.add(query);
  }
}
