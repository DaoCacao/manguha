import 'package:flutter/material.dart';
import 'package:manguha/presentation/res/strings.dart';

import 'bottom_sheet_item.dart';

class MoreBottomSheet extends StatelessWidget {
  final Function onDeleteClick;
  final Function onGalleryClick;
  final Function onCameraClick;
  final Function onCopyClick;

  MoreBottomSheet({
    this.onDeleteClick,
    this.onGalleryClick,
    this.onCameraClick,
    this.onCopyClick,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onDeleteClick != null)
            BottomSheetItem(
              icon: Icons.delete,
              title: AppStrings.deleteImage,
              onClick: () {
                Navigator.pop(context);
                onDeleteClick();
              },
            ),
          if (onGalleryClick != null)
            BottomSheetItem(
              icon: Icons.image,
              title: AppStrings.fromGallery,
              onClick: () {
                Navigator.pop(context);
                onGalleryClick();
              },
            ),
          if (onCameraClick != null)
            BottomSheetItem(
              icon: Icons.camera_alt,
              title: AppStrings.fromCamera,
              onClick: () {
                Navigator.pop(context);
                onCameraClick();
              },
            ),
          if (onCopyClick != null)
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
