import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manguha/blocs/note/note_bloc.dart';
import 'package:manguha/blocs/note/note_events.dart';
import 'package:manguha/blocs/note/note_states.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/pages/details/bottom_sheet_more.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/images.dart';
import 'package:manguha/res/strings.dart';
import 'package:manguha/widgets/loading.dart';

import 'filed_content.dart';
import 'filed_title.dart';

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
        appBar: appBar(context),
        body: BlocConsumer<NoteBloc, NoteState>(
          listener: (context, state) {
            if (state is NoteDeleted) Navigator.maybePop(context);
          },
          builder: (context, state) {
            if (state is NoteInitial)
              context.bloc<NoteBloc>().add(LoadNote(_id));
            if (state is NoteLoaded) return content(state.note);
            return LoadingPlaceholder();
          },
        ),
        bottomNavigationBar: bottomAppBar(context),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary_light,
      leading: iconBack(context),
      actions: [iconPin(context)],
    );
  }

  Widget iconBack(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(AppImages.back),
      onPressed: () => Navigator.maybePop(context),
    );
  }

  Widget iconPin(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(AppImages.pin),
      onPressed: () => context.bloc<NoteBloc>().add(PinNote()),
    );
  }

  Widget bottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: AppColors.primary_light,
      child: Container(
        height: 44, //TODO why 44?
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // iconExtra(),
              textUpdateAt(),
              iconMore(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconExtra() {
    return IconButton(
        icon: Icon(
          Icons.add_box,
          color: AppColors.brown,
        ),
        onPressed: () {
          //TODO add extra
        });
  }

  Widget textUpdateAt() {
    return Expanded(
      child: Center(
        child: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteLoaded) {
              final isMoreThenDay =
                  DateTime.now().difference(state.note.lastUpdate).inDays > 0;
              final lastUpdate = isMoreThenDay ? state.note.dmy : state.note.hm;
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
    );
  }

  Widget iconMore(BuildContext context) {
    final bloc = context.bloc<NoteBloc>();
    return IconButton(
        icon: Icon(Icons.more_vert, color: AppColors.brown),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => MoreBottomSheet(bloc),
          );
        });
  }

  Widget content(Note note) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          child: TitleField(title: note.title),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: ContentField(content: note.content),
        ),
      ],
    );
  }
}
