import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manguha/blocs/note/note_bloc.dart';
import 'package:manguha/blocs/note/note_events.dart';
import 'package:manguha/blocs/note/note_states.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/images.dart';
import 'package:manguha/res/strings.dart';
import 'package:manguha/widgets/loading.dart';

class DetailsPageArgs {
  final int noteId;

  DetailsPageArgs(this.noteId);
}

class DetailsPage extends StatelessWidget {
  final int _id;

  DetailsPage._(this._id);

  DetailsPage.open(DetailsPageArgs args) : this._(args.noteId);

  DetailsPage.create() : this._(null);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<NoteBloc>().add(SaveNote());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary_light,
          leading: IconButton(
            icon: SvgPicture.asset(AppImages.back),
            onPressed: () => Navigator.maybePop(context),
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(AppImages.pin),
              onPressed: () => context.bloc<NoteBloc>().add(PinNote()),
            ),
          ],
        ),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteInitial) context.bloc<NoteBloc>().add(LoadNote(_id));
            if (state is NoteLoaded) return content(context.bloc(), state.note);
            return LoadingPlaceholder();
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: AppColors.primary_light,
          child: Container(
            height: 44, //TODO why 44?
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
//                IconButton(
//                    icon: Icon(
//                      Icons.add_box,
//                      color: AppColors.brown,
//                    ),
//                    onPressed: () {
//                      //TODO add extra
//                    }),
                  Expanded(
                    child: Center(
                      child: BlocBuilder<NoteBloc, NoteState>(
                        builder: (context, state) {
                          if (state is NoteLoaded) {
                            final isMoreThenDay = DateTime.now()
                                    .difference(state.note.lastUpdate)
                                    .inDays >
                                0;
                            final lastUpdate =
                                isMoreThenDay ? state.note.dmy : state.note.hm;
                            return Text(
                              "${AppStrings.lastUpdate} $lastUpdate",
                              style: TextStyle(
                                fontSize: 12,
                                //TODO color with 0.7 opacity?
                                color: Color.fromRGBO(122, 90, 77, 0.7),
                              ),
                            );
                          }
                          return SizedBox.expand();
                        },
                      ),
                    ),
                  ),
//                IconButton(
//                    icon: Icon(
//                      Icons.more_vert,
//                      color: AppColors.brown,
//                    ),
//                    onPressed: () {
//                      //TODO add bottomsheet
//                    }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget content(NoteBloc cubit, Note note) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
            child: TextField(
              controller: TextEditingController(text: note.title),
              onChanged: (text) => cubit.add(ChangeNoteTitle(text)),
              style: TextStyle(fontSize: 18, color: AppColors.brown),
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: AppStrings.noteTitle,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: TextField(
              controller: TextEditingController(text: note.content),
              onChanged: (text) => cubit.add(ChangeNoteContent(text)),
              style: TextStyle(fontSize: 12, color: AppColors.brown),
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: AppStrings.noteContent,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
