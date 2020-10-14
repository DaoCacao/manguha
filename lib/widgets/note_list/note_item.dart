import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:flutter/material.dart';
import 'package:manguha/app_router.dart';
import 'package:manguha/data/note.dart';
import 'package:manguha/res/colors.dart';

class NoteListItem extends StatelessWidget {
  final Note note;

  const NoteListItem({Key key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius()),
      elevation: 2,
      child: ContextualActionWidget(
        data: note,
        selectedColor: Colors.transparent,
        selectedWidget: selected(),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            borderRadius: borderRadius(),
            gradient: AppColors.gradientCard,
          ),
          child: InkWell(
            borderRadius: borderRadius(),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                note.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
              ),
            ),
            onTap: () => AppRouter.toDetails(context, note.id),
          ),
        ),
      ),
    );
  }

  BorderRadius borderRadius() => BorderRadius.circular(8);

  Widget selected() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.icon),
        borderRadius: borderRadius(),
      ),
    );
  }
}
