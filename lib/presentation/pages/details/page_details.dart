import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manguha/data/entities/note.dart';
import 'package:manguha/domain/blocs/note/note_bloc.dart';
import 'package:manguha/domain/blocs/note/note_events.dart';
import 'package:manguha/domain/blocs/note/note_states.dart';
import 'package:manguha/presentation/context_ext.dart';
import 'package:manguha/presentation/res/colors.dart';
import 'package:manguha/presentation/res/strings.dart';
import 'package:manguha/presentation/widgets/bottom_sheet/bottom_sheet_more.dart';
import 'package:manguha/presentation/widgets/placeholders/loading.dart';

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

  DetailsPage.open2(int noteId) : this._(noteId);

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
          listenWhen: (previous, current) =>
              current is ImageAddedError || current is NoteCopied,
          listener: (context, state) {
            if (state is ImageAddedError)
              context.showSnackBar(AppStrings.addImageError);
            if (state is NoteCopied) context.showSnackBar(AppStrings.copied);
          },
          buildWhen: (previous, current) =>
              current is NoteLoading || current is NoteLoaded,
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
      centerTitle: true,
      title: BlocBuilder<NoteBloc, NoteState>(
        buildWhen: (previous, current) => current is NoteLoaded,
        builder: (context, state) {
          return state is NoteLoaded
              ? Text(
                  state.isNew ? AppStrings.titleCreate : AppStrings.titleEdit)
              : SizedBox.shrink();
        },
      ),
      leading: iconBack(context),
    );
  }

  Widget iconBack(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.maybePop(context),
    );
  }

  Widget bottomAppBar(BuildContext context) {
    final margin = MediaQuery.of(context).viewInsets.bottom;
    return BottomAppBar(
      child: Container(
        margin: EdgeInsets.only(bottom: margin),
        height: 44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 24),
            textUpdateAt(),
            iconMore(context),
          ],
        ),
      ),
    );
  }

  Widget textUpdateAt() {
    return Expanded(
      child: Center(
        child: BlocBuilder<NoteBloc, NoteState>(
          buildWhen: (previous, current) => current is NoteLoaded,
          builder: (context, state) {
            if (state is NoteLoaded) {
              final date = state.note.lastUpdate;
              final dmy = "${date.day}.${date.month}.${date.year}";
              final hm = "${date.hour}:${date.minute}";
              final isMoreThenDay = DateTime.now().difference(date).inDays > 0;
              final lastUpdate = isMoreThenDay ? dmy : hm;
              return Text(
                "${AppStrings.lastUpdate} $lastUpdate",
                style: TextStyle(color: AppColors.white, fontSize: 12),
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
        icon: Icon(Icons.more_vert, color: AppColors.white),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => MoreBottomSheet(
              onDeleteClick: bloc.note.image.isNotEmpty
                  ? () => bloc.add(DeleteNoteImage())
                  : null,
              onGalleryClick: () => bloc.add(AddNoteImage(ImageSource.gallery)),
              onCameraClick: () => bloc.add(AddNoteImage(ImageSource.camera)),
              onCopyClick: () => bloc.add(CopyNote()),
            ),
          );
        });
  }

  Widget content(Note note) {
    return ListView(
      children: [
        BlocBuilder<NoteBloc, NoteState>(
          buildWhen: (previous, current) => current is ImageChanged,
          builder: (context, state) => Image.memory(note.image),
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: TitleField(title: note.title),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ContentField(content: note.content),
        ),
      ],
    );
  }
}
