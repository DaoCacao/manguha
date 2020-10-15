import 'package:contextualactionbar/actions/action_mode.dart';
import 'package:contextualactionbar/widgets/contextual_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manguha/blocs/action/action_bloc.dart';
import 'package:manguha/blocs/menu/menu_bloc.dart';
import 'package:manguha/blocs/menu/menu_state.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/images.dart';
import 'package:manguha/res/strings.dart';
import 'package:manguha/widgets/dialog/dialog.dart';
import 'package:manguha/widgets/dialog/dialog_item.dart';

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
                if (state is All || state is Archive)
                  ContextualAction(
                    itemsHandler: action.pin,
                    child: SvgPicture.asset(
                      AppImages.pin,
                      color: AppColors.white,
                    ),
                  ),
                if (state is Pinned)
                  ContextualAction<Note>(
                    itemsHandler: action.unpin,
                    child: SvgPicture.asset(
                      AppImages.pin,
                      color: AppColors.accent,
                    ),
                  ),
                if (state is All || state is Pinned)
                  ContextualAction<Note>(
                    itemsHandler: action.archive,
                    child: Icon(
                      Icons.archive,
                      color: AppColors.white,
                    ),
                  ),
                if (state is Archive)
                  ContextualAction<Note>(
                    itemsHandler: action.unarchive,
                    child: Icon(
                      Icons.unarchive,
                      color: AppColors.white,
                    ),
                  ),
                if (state is Trash)
                  ContextualAction<Note>(
                    itemsHandler: action.undelete,
                    child: Icon(
                      Icons.unarchive,
                      color: AppColors.white,
                    ),
                  ),
                ContextualAction<Note>(
                  itemsHandler: (items) =>
                      showConfirmDownloadDialog(context, items),
                  child: Icon(
                    Icons.file_download,
                    color: AppColors.white,
                  ),
                ),
                if (state is! Trash)
                  ContextualAction<Note>(
                    itemsHandler: action.delete,
                    child: Icon(
                      Icons.delete,
                      color: AppColors.white,
                    ),
                  ),
                if (state is Trash)
                  ContextualAction<Note>(
                    itemsHandler: (items) =>
                        showConfirmDeleteDialog(context, items),
                    child: Icon(
                      Icons.delete,
                      color: AppColors.white,
                    ),
                  ),
              ],
            ),
          );
        }
      },
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
            onClick: () => context.bloc<ActionCubit>().download(notes, "txt"),
          ),
          AppDialogItem(
            text: saveAsPdf,
            icon: Icons.download_sharp,
            onClick: () => context.bloc<ActionCubit>().download(notes, "pdf"),
          ),
        ]),
      ),
    );
  }
}
