import 'package:flutter/material.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/images.dart';

import 'main/routes.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.gradientSplash),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppImages.logo),
              SizedBox(height: 16),
              Image.asset(AppImages.name),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateNext() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(context, MainPageRoute());
  }
}
