import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/note/note_bloc.dart';
import 'package:manguha/blocs/note/note_events.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/strings.dart';

class MoreBottomSheet extends StatelessWidget {
  final NoteBloc bloc;

  MoreBottomSheet(this.bloc);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        BottomSheetItem(
          icon: Icons.delete,
          title: AppStrings.delete,
          onClick: () {
            Navigator.pop(context);
            bloc.add(DeleteNote());
          },
        ),
        // BottomSheetItem(
        //   icon: Icons.share,
        //   title: AppStrings.share,
        //   onClick: () {
        //     Navigator.pop(context);
        //   },
        // ),
        // BottomSheetItem(
        //   icon: Icons.download_sharp,
        //   title: AppStrings.download,
        //   onClick: () {
        //     Navigator.pop(context);
        //   },
        // ),
        // BottomSheetItem(
        //   icon: Icons.copy,
        //   title: AppStrings.copy,
        //   onClick: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ],
    );
  }
}

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
        //TODO incorrect frame size in figma
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: AppColors.brown),
            SizedBox(width: 8),
            Text(title, style: TextStyle(color: AppColors.brown, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
