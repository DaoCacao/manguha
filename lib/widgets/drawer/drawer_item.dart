import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/menu/menu_bloc.dart';
import 'package:manguha/blocs/menu/menu_state.dart';
import 'package:manguha/res/colors.dart';

class AppDrawerItem extends StatelessWidget {
  final Widget icon;
  final String text;
  final bool isSelected;
  final MenuState state;

  AppDrawerItem({this.icon, this.text, this.isSelected, this.state});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius(),
        onTap: () {
          context.bloc<MenuCubit>().changeState(state);
          Scaffold.of(context).openEndDrawer();
        },
        child: Container(
          height: 44,
          padding: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : Colors.transparent,
            borderRadius: borderRadius(),
          ),
          child: Row(
            children: [
              icon,
              SizedBox(width: 16),
              Text(text, style: TextStyle(color: AppColors.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius borderRadius() {
    return const BorderRadius.only(
      topRight: const Radius.circular(8),
      bottomRight: const Radius.circular(8),
    );
  }
}
