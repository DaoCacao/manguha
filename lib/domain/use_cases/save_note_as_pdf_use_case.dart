import 'dart:io';

import 'package:flutter/services.dart';
import 'package:manguha/data/entities/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class SaveNoteAsPdfUseCase {
  Future save(List<Note> notes) async {
    final status = await Permission.storage.request();
    if (status.isGranted)
      notes.forEach(_save);
    else
      throw Exception("Not granted");
  }

  Future _save(Note note) {
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

  Future _saveToDevice(String name, pw.Document document) {
    return getExternalStorageDirectory()
        .then((dir) => dir.path)
        .then((path) => join(path, "$name.pdf"))
        .then((path) => File(path))
        .then((file) => file.writeAsBytes(document.save()));
  }
}
