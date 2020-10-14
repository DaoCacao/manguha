import 'package:flutter/material.dart';
import 'package:manguha/app_router.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/images.dart';

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
              //TODO trouble with svg, no shadow
              Image.asset(AppImages.logo),
              SizedBox(height: 16),
              //TODO no shadow
              Image.asset(AppImages.name),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateNext() async {
    await Future.delayed(Duration(seconds: 1));
    AppRouter.toMain(context);
  }
}
