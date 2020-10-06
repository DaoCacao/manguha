import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manguha/app_router.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/images.dart';

class NoteListItem extends StatelessWidget {
  final Note note;

  const NoteListItem({Key key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius()),
      elevation: 4,
      child: Container(
        height: 40,
        child: InkWell(
          borderRadius: borderRadius(),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      note.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColors.brown, fontSize: 12),
                    ),
                  ),
                  if (note.isPinned)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SvgPicture.asset(AppImages.pin),
                    ),
                ],
              ),
            ),
          ),
          onTap: () => AppRouter.toDetails(context, note.id),
        ),
      ),
    );
  }

  BorderRadius borderRadius() => BorderRadius.circular(8);
}
