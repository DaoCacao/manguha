import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xffFFE2E2);
  static const primaryDark = Color(0xffC88C9E);
  static const textSecondary = Color(0xffFED7DE);
  static const textPrimary = Color(0xff410917);
  static const icon = Color(0xff410917);
  static const accent = Color(0xffF40F6F);
  static const white = Color(0xffffffff);

  static const gradientSplash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.textSecondary,
      AppColors.primaryDark,
    ],
  );

  static const gradientCard = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.white,
      AppColors.primary,
    ],
  );
}
