import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manguha/blocs/menu_bloc.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/images.dart';
import 'package:manguha/res/strings.dart';

class AppDrawer extends StatelessWidget {
  final items = [
    DrawerItem.svg(AppImages.pin, AppStrings.pinnedNotes, Pinned()),
    DrawerItem.icon(Icons.archive, AppStrings.archive, Archive()),
    DrawerItem.icon(Icons.delete, AppStrings.trash, Trash()),
    DrawerItem.icon(Icons.info, AppStrings.support, Support()),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          header(context),
          SizedBox(height: 24),
          list(context),
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      height: Scaffold.of(context).appBarMaxHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.primary,
      child: Center(
        child: Row(
          children: [
            SvgPicture.asset(AppImages.logo_name_drawer),
            SvgPicture.asset(AppImages.logo_drawer),
          ],
        ),
      ),
    );
  }

  Widget list(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, i) => AppDrawerItem(item: items[i]),
        );
      },
    );
  }
}

class AppDrawerItem extends StatelessWidget {
  final DrawerItem item;

  const AppDrawerItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<MenuCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
      child: InkWell(
        borderRadius: borderRadius(),
        onTap: () {
          bloc.changeState(item.state);
          Scaffold.of(context).openEndDrawer();
        },
        child: Container(
          height: 32,
          padding: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: bloc.state == item.state
                ? AppColors.primary
                : Colors.transparent,
            borderRadius: borderRadius(),
          ),
          child: Row(
            children: [
              item.icon != null
                  ? Icon(item.icon, color: AppColors.brown)
                  : SvgPicture.asset(item.svg, color: AppColors.brown),
              SizedBox(width: 16),
              Text(
                item.text,
                style: TextStyle(color: AppColors.brown),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius borderRadius() => const BorderRadius.only(
        topRight: const Radius.circular(8),
        bottomRight: const Radius.circular(8),
      );
}

class DrawerItem {
  String svg;
  IconData icon;
  final String text;
  final MenuState state;

  DrawerItem.svg(this.svg, this.text, this.state);

  DrawerItem.icon(this.icon, this.text, this.state);
}
