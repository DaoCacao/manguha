import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manguha/blocs/menu/menu_bloc.dart';
import 'package:manguha/blocs/menu/menu_state.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/images.dart';
import 'package:manguha/res/strings.dart';

import 'drawer_item.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            header(context),
            SizedBox(height: 16),
            list(context),
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      height: Scaffold.of(context).appBarMaxHeight,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      color: AppColors.primary,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            Image.asset(AppImages.name_drawer),
            Image.asset(AppImages.logo_drawer),
          ],
        ),
      ),
    );
  }

  Widget list(BuildContext context) {
    final items = [
      MenuItem(
        SvgPicture.asset(AppImages.pin, color: AppColors.icon),
        AppStrings.pinned,
        Pinned(),
      ),
      MenuItem(
        Icon(Icons.archive, color: AppColors.icon),
        AppStrings.archive,
        Archive(),
      ),
      MenuItem(
        Icon(Icons.delete, color: AppColors.icon),
        AppStrings.trash,
        Trash(),
      ),
    ];
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 16),
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, i) => item(items[i], state),
          separatorBuilder: (context, i) => SizedBox(height: 8),
        );
      },
    );
  }

  Widget item(MenuItem item, MenuState state) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: AppDrawerItem(
        icon: item.icon,
        text: item.text,
        isSelected: item.state.runtimeType == state.runtimeType,
        state: item.state,
      ),
    );
  }
}

class MenuItem {
  final Widget icon;
  final String text;
  final MenuState state;

  MenuItem(this.icon, this.text, this.state);
}
