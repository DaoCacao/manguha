import 'package:flutter/material.dart';
import 'package:manguha/presentation/res/colors.dart';

class AppDialogItem extends StatelessWidget {
  final Text text;
  final IconData icon;
  final Function onClick;

  const AppDialogItem({this.text, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if (onClick != null) onClick();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: AppColors.icon),
            SizedBox(width: 16),
            text,
          ],
        ),
      ),
    );
  }
}
