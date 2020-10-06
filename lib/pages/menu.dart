import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manguha/blocs/menu_bloc.dart';
import 'package:manguha/pages/pinned_notes.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/images.dart';
import 'package:manguha/widgets/drawer.dart';
import 'package:manguha/widgets/search.dart';

import '../app_router.dart';
import 'all_notes.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: AppDrawer(),
      appBar: appBar(context),
      bottomNavigationBar: bottomAppBar(),
      floatingActionButton: fab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          if (state is All) return AllNotesPage();
          if (state is Pinned) return PinnedNotesPage();
          // if (state is Archive) return AllNotesPage();
          // if (state is Trash) return AllNotesPage();
          // if (state is Support) return AllNotesPage();
        },
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: Search(),
      leading: Builder(builder: (context) => menu()),
    );
  }

  Widget menu() {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        if (state is All)
          return IconButton(
            icon: const Icon(Icons.menu, color: AppColors.brown),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        else
          return IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.brown),
            onPressed: () => context.bloc<MenuCubit>().toNone(),
          );
      },
    );
  }

  Widget bottomAppBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: AppColors.primary,
      notchMargin: 8,
      child: Container(height: 56),
    );
  }

  Widget fab(BuildContext context) {
    return FloatingActionButton(
      child: SvgPicture.asset(AppImages.plus),
      backgroundColor: AppColors.fab,
      onPressed: () => AppRouter.toCreateNote(context),
    );
  }
}
