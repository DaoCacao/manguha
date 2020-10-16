import 'dart:async';

import 'package:manguha/data/database.dart';
import 'package:manguha/data/note.dart';

class NoteRepository {
  final NoteDatabase _database;
  final StreamController<int> _observable = StreamController.broadcast();

  Stream observable;
  int i = 0;

  NoteRepository(this._database) {
    observable = _observable.stream;
  }

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

  Future<List<Note>> getArchived() {
    return _database.getArchivedNotes();
  }

  Future<List<Note>> getArchivedByQuery(String query) {
    return _database.getArchivedNotesByQuery(query);
  }

  Future<List<Note>> getDeleted() {
    return _database.getDeletedNotes();
  }

  Future<List<Note>> getDeletedByQuery(String query) {
    return _database.getDeletedNotesByQuery(query);
  }

  Future<Note> get(int id) {
    return _database.getNoteById(id);
  }

  Future save(List<Note> notes) async {
    await _database.insertNote(notes);
    _observable.add(++i);
  }

  Future fullDelete(List<Note> notes) async {
    await _database.deleteNotes(notes.map((e) => e.id).toList());
    _observable.add(++i);
  }
}
