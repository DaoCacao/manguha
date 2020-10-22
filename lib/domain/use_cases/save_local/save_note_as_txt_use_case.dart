import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:manguha/data/entities/note.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveNoteAsTxtUseCase {
  Future<List<File>> save(List<Note> notes) async {
    return Permission.storage.request().then((status) {
      if (status.isGranted) {
        return Future.wait(notes.map(_save));
      } else
        throw Exception("Permission not granted");
    });
  }

  Future<File> _save(Note note) {
    var name = note.title;
    if (name.isEmpty) name = DateTime.now().toString();
    return ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOCUMENTS)
        .then((path) => join(path, "$name.txt"))
        .then((path) => File(path))
        .then((file) => file.writeAsString("${note.title}\n${note.content}"));
  }
}
