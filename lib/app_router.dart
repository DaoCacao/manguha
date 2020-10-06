import 'package:flutter/cupertino.dart';
import 'package:manguha/pages/details.dart';

class AppRouter {
  static const splash = "/";
  static const main = "/main";
  static const details = "/details";
  static const create = "/create";

  static void toMain(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRouter.main);
  }

  static void toCreateNote(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.create);
  }

  static void toDetails(BuildContext context, int id) {
    Navigator.pushNamed(
      context,
      AppRouter.details,
      arguments: DetailsPageArgs(id),
    );
  }
}
