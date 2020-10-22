import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/services.dart';
import 'package:manguha/data/entities/note.dart';
import 'package:path/path.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class SaveNoteAsPdfUseCase {
  Future<List<File>> save(List<Note> notes) async {
    return Permission.storage.request().then((status) {
      if (status.isGranted) {
        return Future.wait(notes.map(_save));
      } else
        throw Exception("Permission not granted");
    });
  }

  Future<File> _save(Note note) {
    return _createDocument(note)
        .then((document) => _saveToDevice(note.title, document));
  }

  Future<pw.Document> _createDocument(Note note) async {
    final data = await rootBundle.load("assets/fonts/Comfortaa-Regular.ttf");
    final font = pw.Font.ttf(data);
    final style = pw.TextStyle(font: font);

    //TODO add image
    return pw.Document()
      ..addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(children: [
            pw.Center(
              child: pw.Text(
                "${note.title}\n${note.content}",
                style: style,
              ),
            ),
          ]),
        ),
      );
  }

  Future<File> _saveToDevice(String name, pw.Document document) {
    if (name.isEmpty) name = DateTime.now().toString();
    return ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOCUMENTS)
        .then((path) => join(path, "$name.pdf"))
        .then((path) => File(path))
        .then((file) => file.writeAsBytes(document.save()));
  }
}
