import 'dart:io';

import 'package:manguha/data/entities/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveNoteAsTxtUseCase {
  Future save(List<Note> notes) async {
    final status = await Permission.storage.request();
    if (status.isGranted)
      notes.forEach(_save);
    else
      throw Exception("Not granted");
  }

  Future _save(Note note) async {
    getExternalStorageDirectory()
        .then((dir) => dir.path)
        .then((path) => join(path, "${note.title}.txt"))
        .then((path) => File(path))
        .then((file) => file.writeAsString("${note.title}\n${note.content}"));
  }
}
