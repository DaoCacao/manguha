import 'package:flutter/material.dart';
import 'package:manguha/res/colors.dart';

class BottomSheetItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onClick;

  BottomSheetItem({this.icon, this.title, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: AppColors.icon),
            SizedBox(width: 8),
            Text(title, style: TextStyle(color: AppColors.textPrimary, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
