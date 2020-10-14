import 'package:manguha/res/strings.dart';

abstract class MenuState {
  final String title;

  MenuState(this.title);
}

class All extends MenuState {
  All() : super(AppStrings.titleAll);
}

class Pinned extends MenuState {
  Pinned() : super(AppStrings.titlePinned);
}

class Archive extends MenuState {
  Archive() : super(AppStrings.titleArchive);
}

class Trash extends MenuState {
  Trash() : super(AppStrings.titleTrash);
}
