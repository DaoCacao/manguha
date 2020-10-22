import 'package:manguha/data/entities/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  //TODO --> add migration
  final Future<Database> database = getDatabasesPath().then((path) {
    print("db path $path");
    return path;
  }).then(
    (path) => openDatabase(
      join(path, 'notes_database.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE ${Note.TABLE_NAME}("
          "${Note.ID} INTEGER PRIMARY KEY AUTOINCREMENT, "
          "${Note.TITLE} TEXT, "
          "${Note.CONTENT} TEXT, "
          "${Note.IS_PINNED} BOOLEAN, "
          "${Note.IS_DELETED} BOOLEAN, "
          "${Note.IS_ARCHIVED} BOOLEAN, "
          "${Note.IMAGE} TEXT, "
          "${Note.LAST_UPDATE} INTEGER)",
        );
      },
    ),
  );

  Future<List<Note>> getAllNotes() {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where:
                  "NOT(${Note.IS_PINNED}) AND NOT(${Note.IS_DELETED}) AND NOT(${Note.IS_ARCHIVED})",
              orderBy: "${Note.LAST_UPDATE} DESC",
            ))
        .then((notes) => notes.map(Note.fromMap).toList());
  }

  Future<List<Note>> getAllNotesByQuery(String query) {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where:
                  "NOT(${Note.IS_PINNED}) AND NOT(${Note.IS_DELETED}) AND NOT(${Note.IS_ARCHIVED}) AND ${Note.TITLE} LIKE ?",
              whereArgs: ['%$query%'],
              orderBy: "${Note.LAST_UPDATE} DESC",
            ))
        .then((notes) => notes.map(Note.fromMap).toList());
  }

  Future<List<Note>> getPinnedNotes() {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where: Note.IS_PINNED,
              orderBy: "${Note.LAST_UPDATE} DESC",
            ))
        .then((notes) => notes.map(Note.fromMap).toList());
  }

  Future<List<Note>> getPinnedNotesByQuery(String query) {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where: "${Note.IS_PINNED} AND ${Note.TITLE} LIKE ?",
              whereArgs: ['%$query%'],
              orderBy: "${Note.LAST_UPDATE} DESC",
            ))
        .then((notes) => notes.map(Note.fromMap).toList());
  }

  Future<List<Note>> getDeletedNotes() {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where: Note.IS_DELETED,
              orderBy: "${Note.LAST_UPDATE} DESC",
            ))
        .then((notes) => notes.map(Note.fromMap).toList());
  }

  Future<List<Note>> getDeletedNotesByQuery(String query) {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where: "${Note.IS_DELETED} AND ${Note.TITLE} LIKE ?",
              whereArgs: ['%$query%'],
              orderBy: "${Note.LAST_UPDATE} DESC",
            ))
        .then((notes) => notes.map(Note.fromMap).toList());
  }

  Future<List<Note>> getArchivedNotes() {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where: Note.IS_ARCHIVED,
              orderBy: "${Note.LAST_UPDATE} DESC",
            ))
        .then((notes) => notes.map(Note.fromMap).toList());
  }

  Future<List<Note>> getArchivedNotesByQuery(String query) {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where: "${Note.IS_ARCHIVED} AND ${Note.TITLE} LIKE ?",
              whereArgs: ['%$query%'],
              orderBy: "${Note.LAST_UPDATE} DESC",
            ))
        .then((notes) => notes.map(Note.fromMap).toList());
  }

  Future<Note> getNoteById(int id) {
    return database
        .then((db) => db.query(
              Note.TABLE_NAME,
              where: "${Note.ID} = ?",
              whereArgs: [id],
              limit: 1,
            ))
        .then((notes) => notes.first)
        .then(Note.fromMap);
  }

  Future insertNote(List<Note> notes) {
    return database
        .then((db) => db.batch())
        .then((batch) => notes.forEach((note) {
              batch.insert(
                Note.TABLE_NAME,
                note.toMap(),
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
              batch.commit(noResult: true);
            }));
  }

  Future deleteNotes(List<int> noteIds) {
    return database.then((db) => db.delete(
          Note.TABLE_NAME,
          where: "${Note.ID} IN (${noteIds.map((e) => "?").join(", ")})",
          whereArgs: noteIds,
        ));
  }
}
