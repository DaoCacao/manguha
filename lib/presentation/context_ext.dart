import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  void showSnackBar(String text) {
    Scaffold.of(this).hideCurrentSnackBar();
    Scaffold.of(this).showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
