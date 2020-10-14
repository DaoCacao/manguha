import 'package:contextualactionbar/contextual_scaffold.dart';
import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manguha/blocs/action/action_bloc.dart';
import 'package:manguha/blocs/menu/menu_bloc.dart';
import 'package:manguha/blocs/menu/menu_state.dart';
import 'package:manguha/blocs/search/search_cubit.dart';
import 'package:manguha/blocs/search/search_state.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/pages/notes_archived.dart';
import 'package:manguha/pages/notes_deleted.dart';
import 'package:manguha/pages/notes_pinned.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/images.dart';
import 'package:manguha/widgets/drawer/drawer.dart';
import 'package:manguha/widgets/search.dart';

import '../app_router.dart';
import 'notes_all.dart';

class MainPage extends StatelessWidget {
  final searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        return ContextualScaffold<Note>(
          // extendBody: true,
          drawer: AppDrawer(),
          contextualAppBar: contextualAppBar(context.bloc(), state),
          appBar: appBar(context),
          bottomNavigationBar: bottomAppBar(context),
          floatingActionButton: fab(context),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          body: content(state),
        );
      },
    );
  }

  Widget contextualAppBar(ActionCubit action, MenuState state) {
    return ContextualAppBar<Note>(
      counterBuilder: (itemsCount) => Text(itemsCount.toString()),
      contextualActions: [
        if (state is All || state is Archive)
          ContextualAction(
            itemsHandler: action.pin,
            child: SvgPicture.asset(
              AppImages.pin,
              color: AppColors.white,
            ),
          ),
        if (state is Pinned)
          ContextualAction(
            itemsHandler: action.unpin,
            child: SvgPicture.asset(
              AppImages.pin,
              color: AppColors.accent,
            ),
          ),
        if (state is All || state is Pinned)
          ContextualAction(
            itemsHandler: action.archive,
            child: Icon(Icons.archive),
          ),
        if (state is Archive)
          ContextualAction(
            itemsHandler: action.unarchive,
            child: Icon(Icons.unarchive),
          ),
        if (state is Trash)
          ContextualAction(
            itemsHandler: action.undelete,
            child: Icon(Icons.unarchive),
          ),
        ContextualAction(
          //TODO add select format dialog
          itemsHandler: action.download,
          child: Icon(Icons.file_download),
        ),
        if (state is! Trash)
          ContextualAction(
            itemsHandler: action.delete,
            child: Icon(Icons.delete),
          ),
        if (state is Trash)
          ContextualAction(
            //TODO confirm dialog
            itemsHandler: action.fullDelete,
            child: Icon(Icons.delete),
          ),
      ],
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: menu(),
      title: title(),
      actions: [search()],
    );
  }

  Widget title() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return state == SearchState.Search
            ? Search(focus: searchFocus)
            : BlocBuilder<MenuCubit, MenuState>(
                builder: (context, state) => Text(state.title),
              );
      },
    );
  }

  Widget menu() {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        if (state is All)
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        else
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.bloc<MenuCubit>().toNone(),
          );
      },
    );
  }

  Widget search() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(state == SearchState.Search ? Icons.close : Icons.search),
          onPressed: () {
            context.bloc<SearchCubit>().switchState();
            searchFocus.requestFocus();
          },
        );
      },
    );
  }

  Widget bottomAppBar(BuildContext context) {
    final margin = MediaQuery.of(context).viewInsets.bottom;
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child: Container(
        margin: EdgeInsets.only(bottom: margin),
        height: 56,
      ),
    );
  }

  Widget fab(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => AppRouter.toCreateNote(context),
    );
  }

  Widget content(MenuState state) {
    if (state is All) return AllNotesPage();
    if (state is Pinned) return PinnedNotesPage();
    if (state is Archive) return ArchivedNotesPage();
    if (state is Trash) return DeletedNotesPage();
  }
}
