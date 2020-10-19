import 'package:contextualactionbar/contextual_scaffold.dart';
import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/data/entities/note.dart';
import 'package:manguha/domain/blocs/action/action_bloc.dart';
import 'package:manguha/domain/blocs/menu/menu_bloc.dart';
import 'package:manguha/domain/blocs/menu/menu_state.dart';
import 'package:manguha/domain/blocs/search/search_cubit.dart';
import 'package:manguha/domain/blocs/search/search_state.dart';
import 'package:manguha/presentation/pages/details/routes.dart';
import 'package:manguha/presentation/widgets/drawer/drawer.dart';
import 'package:manguha/presentation/widgets/search.dart';

import '../notes_all.dart';
import '../notes_archived.dart';
import '../notes_deleted.dart';
import '../notes_pinned.dart';
import 'bottom_app_bar.dart';

class MainPage extends StatelessWidget {
  final searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (c) => SearchCubit()),
        BlocProvider(create: (c) => MenuCubit(c.bloc())),
        BlocProvider(create: (c) => ActionCubit.get(c)),
      ],
      child: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          return ContextualScaffold<Note>(
            drawer: AppDrawer(),
            contextualAppBar: contextualAppBar(context.bloc()),
            appBar: appBar(context),
            bottomNavigationBar: AppBottomAppBar(),
            floatingActionButton: fab(context),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            body: content(state),
          );
        },
      ),
    );
  }

  Widget contextualAppBar(ActionCubit action) {
    return ContextualAppBar<Note>(
      centerTitle: false,
      counterBuilder: (itemsCount) => Text(itemsCount.toString()),
      contextualActions: [],
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
        return state is Search
            ? SearchField(focus: searchFocus)
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
            onPressed: () => context.bloc<MenuCubit>().changeState(All()),
          );
      },
    );
  }

  Widget search() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(state is Search ? Icons.close : Icons.search),
          onPressed: () {
            context.bloc<SearchCubit>().switchState();
            searchFocus.requestFocus();
          },
        );
      },
    );
  }

  Widget fab(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.push(context, CreateNotePageRoute()),
    );
  }

  Widget content(MenuState state) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: page(state),
    );
  }

  Widget page(MenuState state) {
    if (state is All) return AllNotesPage();
    if (state is Pinned) return PinnedNotesPage();
    if (state is Archive) return ArchivedNotesPage();
    if (state is Trash) return DeletedNotesPage();
  }
}
