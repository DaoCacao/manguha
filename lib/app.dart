import 'package:flutter/material.dart';
import 'package:manguha/pages/splash.dart';
import 'package:manguha/res/colors.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        primaryColor: AppColors.primaryDark,
        accentColor: AppColors.accent,
        bottomAppBarColor: AppColors.primaryDark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Comfortaa',
      ),
      home: SplashPage(),
    );
  }
}
