import 'package:manguha/data/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  //TODO --> add migration
  final Future<Database> database = getDatabasesPath().then((path) {
    print("DB path% $path");
    return path;
  }).then(
    (path) => openDatabase(
      join(path, 'notes_database.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE ${Note.TABLE_NAME}("
          "${Note.ID} INTEGER PRIMARY KEY AUTOINCREMENT, "
          "${Note.TITLE} TEXT, "
          "${Note.CONTENT} TEXT, "
          "${Note.IS_PINNED} BOOLEAN, "
          "${Note.LAST_UPDATE} INTEGER)",
        );
      },
    ),
  );

  Future<List<Note>> getAllNotes() {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              orderBy: "${Note.LAST_UPDATE} DESC",
            ))
        .then((notes) => notes.map((map) => Note.fromMap(map)).toList());
  }

  Future<List<Note>> getAllNotesByQuery(String query) {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where: "${Note.TITLE} LIKE ?",
              whereArgs: ['%$query%'],
              orderBy: "${Note.LAST_UPDATE} DESC",
            ))
        .then((notes) => notes.map((map) => Note.fromMap(map)).toList());
  }

  Future<List<Note>> getPinnedNotes() {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where: Note.IS_PINNED,
              orderBy: "${Note.LAST_UPDATE} DESC",
            ))
        .then((notes) => notes.map((map) => Note.fromMap(map)).toList());
  }

  Future<List<Note>> getPinnedNotesByQuery(String query) {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where: "${Note.IS_PINNED} AND ${Note.TITLE} LIKE ?",
              whereArgs: ['%$query%'],
              orderBy: "${Note.LAST_UPDATE} DESC",
            ))
        .then((notes) => notes.map((map) => Note.fromMap(map)).toList());
  }

  Future<Note> getNoteById(int id) {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where: "${Note.ID} = ?",
              whereArgs: [id],
              limit: 1,
            ))
        .then((notes) => Note.fromMap(notes.first));
  }

  Future insertNote(Note note) {
    return database.then((db) => db.insert(
          Note.TABLE_NAME,
          note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        ));
  }

  Future deleteNote(int id) {
    return database.then((db) => db.delete(
          Note.TABLE_NAME,
          where: "${Note.ID} = ?",
          whereArgs: [id],
        ));
  }
}
