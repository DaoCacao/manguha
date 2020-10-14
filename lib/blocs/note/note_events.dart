import 'package:image_picker/image_picker.dart';

abstract class NoteEvent {}

class LoadNote extends NoteEvent {
  final int id;

  LoadNote(this.id);
}

class ChangeNoteTitle extends NoteEvent {
  final String text;

  ChangeNoteTitle(this.text);
}

class ChangeNoteContent extends NoteEvent {
  final String text;

  ChangeNoteContent(this.text);
}

class SaveNote extends NoteEvent {}

class PinNote extends NoteEvent {}

class ArchiveNote extends NoteEvent {}

class DeleteNote extends NoteEvent {}

class CopyNote extends NoteEvent {}

class AddNoteImage extends NoteEvent {
  final ImageSource source;

  AddNoteImage(this.source);
}
