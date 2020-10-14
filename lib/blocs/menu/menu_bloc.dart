import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/res/strings.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(All());

  void changeState(MenuState newState) => emit(newState);

  void toNone() => emit(All());

  void toPinned() => emit(Pinned());

  void toArchive() => emit(Archive());

  void toTrash() => emit(Trash());
}

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
