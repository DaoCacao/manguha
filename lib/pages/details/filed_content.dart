import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/note/note_bloc.dart';
import 'package:manguha/blocs/note/note_events.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/strings.dart';

class ContentField extends StatelessWidget {
  final String content;

  const ContentField({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: content),
      onChanged: (text) => context.bloc<NoteBloc>().add(ChangeNoteContent(text)),
      style: TextStyle(fontSize: 12, color: AppColors.textPrimary),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: AppColors.primary),
        hintText: AppStrings.noteContent,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}
