import 'package:flutter/material.dart';
import 'package:manguha/res/strings.dart';

import 'bottom_sheet_item.dart';

class MoreBottomSheet extends StatelessWidget {
  final Function onGalleryClick;
  final Function onCameraClick;
  final Function onCopyClick;

  MoreBottomSheet({this.onGalleryClick, this.onCameraClick, this.onCopyClick});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetItem(
            icon: Icons.image,
            title: AppStrings.fromGallery,
            onClick: () {
              Navigator.pop(context);
              onGalleryClick();
            },
          ),
          BottomSheetItem(
            icon: Icons.camera_alt,
            title: AppStrings.fromCamera,
            onClick: () {
              Navigator.pop(context);
              onCameraClick();
            },
          ),
          BottomSheetItem(
            icon: Icons.copy,
            title: AppStrings.copy,
            onClick: () {
              Navigator.pop(context);
              onCopyClick();
            },
          ),
        ],
      ),
    );
  }
}
