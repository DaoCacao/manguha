import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/domain/blocs/note/note_bloc.dart';
import 'package:manguha/domain/blocs/note/note_events.dart';
import 'package:manguha/presentation/res/colors.dart';
import 'package:manguha/presentation/res/strings.dart';

class TitleField extends StatelessWidget {
  final String title;

  const TitleField({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: title),
      onChanged: (text) => context.bloc<NoteBloc>().add(ChangeNoteTitle(text)),
      style: TextStyle(fontSize: 18, color: AppColors.textPrimary),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: AppColors.primaryDark),
        hintText: AppStrings.noteTitle,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}
