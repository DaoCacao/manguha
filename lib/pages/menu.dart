import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/menu/menu_bloc.dart';
import 'package:manguha/blocs/search_cubit.dart';
import 'package:manguha/pages/pinned_notes.dart';
import 'package:manguha/widgets/drawer/drawer.dart';
import 'package:manguha/widgets/search.dart';

import '../app_router.dart';
import 'all_notes.dart';

class MenuPage extends StatelessWidget {
  final searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: AppDrawer(),
      appBar: appBar(context),
      bottomNavigationBar: bottomAppBar(context),
      floatingActionButton: fab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          if (state is All) return AllNotesPage();
          if (state is Pinned) return PinnedNotesPage();
          if (state is Archive) return AllNotesPage(); //TODO
          if (state is Trash) return AllNotesPage(); //TODO
        },
      ),
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
    return BlocBuilder<SearchCubit, bool>(
      builder: (context, isSearchState) {
        return isSearchState
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
    return BlocBuilder<SearchCubit, bool>(
      builder: (context, isSearchState) {
        return IconButton(
          icon: Icon(isSearchState ? Icons.close : Icons.search),
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
}
