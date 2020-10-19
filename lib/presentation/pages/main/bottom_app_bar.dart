import 'package:contextualactionbar/actions/action_mode.dart';
import 'package:contextualactionbar/widgets/contextual_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manguha/data/entities/note.dart';
import 'package:manguha/domain/blocs/action/action_bloc.dart';
import 'package:manguha/domain/blocs/menu/menu_bloc.dart';
import 'package:manguha/domain/blocs/menu/menu_state.dart';
import 'package:manguha/presentation/res/colors.dart';
import 'package:manguha/presentation/res/images.dart';
import 'package:manguha/presentation/res/strings.dart';
import 'package:manguha/presentation/widgets/dialog/dialog.dart';
import 'package:manguha/presentation/widgets/dialog/dialog_item.dart';

class AppBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final margin = MediaQuery.of(context).viewInsets.bottom;
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child: Container(
        margin: EdgeInsets.only(bottom: margin),
        height: 56,
        child: actionBar(context),
      ),
    );
  }

  Widget actionBar(BuildContext context) {
    return StreamBuilder<bool>(
      stream: ActionMode.enabledStream<Note>(context),
      initialData: false,
      builder: (context, state) {
        if (!state.data)
          return SizedBox.shrink();
        else {
          final action = context.bloc<ActionCubit>();
          final state = context.bloc<MenuCubit>().state;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                if (state is All || state is Archive) actionPin(action),
                if (state is Pinned) actionUnpin(action),
                if (state is All || state is Pinned) actionArchive(action),
                if (state is Archive) actionUnarchive(action),
                if (state is Trash) actionUndelete(action),
                actionDownload(action, context),
                if (state is! Trash) actionDelete(action),
                if (state is Trash) actionFullDelete(action, context),
              ],
            ),
          );
        }
      },
    );
  }

  Widget actionPin(ActionCubit action) {
    return ContextualAction(
      itemsHandler: action.pin,
      child: SvgPicture.asset(AppImages.pin, color: AppColors.white),
    );
  }

  Widget actionUnpin(ActionCubit action) {
    return ContextualAction<Note>(
      itemsHandler: action.unpin,
      child: SvgPicture.asset(AppImages.pin, color: AppColors.accent),
    );
  }

  Widget actionArchive(ActionCubit action) {
    return ContextualAction<Note>(
      itemsHandler: action.archive,
      child: Icon(Icons.archive, color: AppColors.white),
    );
  }

  Widget actionUnarchive(ActionCubit action) {
    return ContextualAction<Note>(
      itemsHandler: action.unarchive,
      child: Icon(Icons.unarchive, color: AppColors.white),
    );
  }

  Widget actionDownload(ActionCubit action, BuildContext context) {
    return ContextualAction<Note>(
      itemsHandler: (items) => showConfirmDownloadDialog(context, items),
      child: Icon(Icons.file_download, color: AppColors.white),
    );
  }

  Widget actionDelete(ActionCubit action) {
    return ContextualAction<Note>(
      itemsHandler: action.delete,
      child: Icon(Icons.delete, color: AppColors.white),
    );
  }

  Widget actionUndelete(ActionCubit action) {
    return ContextualAction<Note>(
      itemsHandler: action.undelete,
      child: Icon(Icons.unarchive, color: AppColors.white),
    );
  }

  Widget actionFullDelete(ActionCubit action, BuildContext context) {
    return ContextualAction<Note>(
      itemsHandler: (items) => showConfirmDeleteDialog(context, items),
      child: Icon(Icons.delete, color: AppColors.white),
    );
  }

  void showConfirmDeleteDialog(BuildContext context, List<Note> notes) {
    final confirm = Text(
      AppStrings.delete,
      style: TextStyle(color: AppColors.textPrimary, fontSize: 12),
    );
    final cancel = Text(
      AppStrings.cancel,
      style: TextStyle(color: AppColors.textPrimary, fontSize: 12),
    );

    showDialog(
      context: context,
      builder: (_) => AppDialog(
        title: AppStrings.deleteForever,
        content: Column(children: [
          AppDialogItem(
            text: confirm,
            icon: Icons.check,
            onClick: () => context.bloc<ActionCubit>().fullDelete(notes),
          ),
          AppDialogItem(
            text: cancel,
            icon: Icons.close,
          ),
        ]),
      ),
    );
  }

  void showConfirmDownloadDialog(BuildContext context, List<Note> notes) {
    final saveAs = TextSpan(
      text: AppStrings.saveAs,
      style: TextStyle(color: AppColors.textPrimary, fontSize: 12),
    );
    final typeTxt = TextSpan(
      text: "txt",
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 12,
        decoration: TextDecoration.underline,
      ),
    );
    final typePdf = TextSpan(
      text: "pdf",
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 12,
        decoration: TextDecoration.underline,
      ),
    );
    final saveAsTxt =
        Text.rich(TextSpan(children: [saveAs, TextSpan(text: " "), typeTxt]));
    final saveAsPdf =
        Text.rich(TextSpan(children: [saveAs, TextSpan(text: " "), typePdf]));

    showDialog(
      context: context,
      builder: (_) => AppDialog(
        title: AppStrings.saveToDevice,
        content: Column(children: [
          AppDialogItem(
            text: saveAsTxt,
            icon: Icons.download_sharp,
            onClick: () => context.bloc<ActionCubit>().downloadAsTxt(notes),
          ),
          AppDialogItem(
            text: saveAsPdf,
            icon: Icons.download_sharp,
            onClick: () => context.bloc<ActionCubit>().downloadAsPdf(notes),
          ),
        ]),
      ),
    );
  }
}
