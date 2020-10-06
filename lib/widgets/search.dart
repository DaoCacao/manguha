import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/all_notes/all_notes_bloc.dart';
import 'package:manguha/blocs/all_notes/all_notes_events.dart';
import 'package:manguha/blocs/pinned_notes/pinned_notes_bloc.dart';
import 'package:manguha/blocs/pinned_notes/pinned_notes_events.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/strings.dart';

//TODO box style with inner shadow
class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      child: TextField(
        textInputAction: TextInputAction.search,
        style: TextStyle(
          fontSize: 12,
          color: AppColors.brown,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.search),
          hintText: AppStrings.searchByName,
          hintStyle: TextStyle(
            fontSize: 12,
            //TODO no such color
            color: Color.fromRGBO(192, 173, 165, 1),
          ),
        ),
        onChanged: (query) {
          context.bloc<AllNotesBloc>().add(SearchAllNotes(query));
          context.bloc<PinnedNotesBloc>().add(SearchPinnedNotes(query));
        },
      ),
    );
  }
}
