import 'package:flutter/material.dart';
import 'package:manguha/res/colors.dart';

class EmptyPlaceholder extends StatelessWidget {
  final String text;

  const EmptyPlaceholder({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}
