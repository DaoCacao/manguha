import 'package:flutter/material.dart';
import 'package:manguha/presentation/res/colors.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final Widget content;

  const AppDialog({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
              ),
            ),
          ),
          content,
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
