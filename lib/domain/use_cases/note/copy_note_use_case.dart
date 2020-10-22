import 'package:flutter/services.dart';
import 'package:manguha/data/entities/note.dart';

class CopyNoteUseCase {
  Future copy(Note note) async {
    Clipboard.setData(ClipboardData(text: note.title + "\n" + note.content));
  }
}
