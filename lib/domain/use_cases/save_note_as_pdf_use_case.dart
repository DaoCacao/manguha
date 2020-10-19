import 'package:manguha/data/entities/note.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveNoteAsPdfUseCase {
  Future save(List<Note> notes) async {
    final status = await Permission.storage.request();
    if (status.isGranted)
      notes.forEach(_save);
    else
      throw Exception("Not granted");
  }

  Future _save(Note note) async {
    //TODO
  }
}
