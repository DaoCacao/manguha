import 'package:manguha/data/database.dart';
import 'package:manguha/data/note.dart';

class NoteRepository {
  final NoteDatabase _database;

  NoteRepository(this._database);

  Future<List<Note>> getAll() {
    return _database.getAllNotes();
  }

  Future<List<Note>> getAllByQuery(String query) {
    return _database.getAllNotesByQuery(query);
  }

  Future<List<Note>> getPinned() {
    return _database.getPinnedNotes();
  }

  Future<List<Note>> getPinnedByQuery(String query) {
    return _database.getPinnedNotesByQuery(query);
  }

  Future<Note> get(int id) {
    return _database.getNoteById(id);
  }

  Future save(Note note) {
    return _database.insertNote(note);
  }
}
