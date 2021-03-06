import 'dart:typed_data';

import 'package:manguha/data/entities/note.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final Note note;
  final bool isNew;

  NoteLoaded(this.note, this.isNew);
}

class NoteDeleted extends NoteState {}

class NoteCopied extends NoteState {}

class ImageLoading extends NoteState {}

class ImageChanged extends NoteState {
  final String path;

  ImageChanged(this.path);
}

class ImageAddedError extends NoteState {}
