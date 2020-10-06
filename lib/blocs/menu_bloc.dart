import 'package:flutter_bloc/flutter_bloc.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(All());

  void changeState(MenuState newState) => emit(newState);

  void toNone() => emit(All());

  void toPinned() => emit(Pinned());

  void toArchive() => emit(Archive());

  void toTrash() => emit(Trash());

  void toSupport() => emit(Support());
}

abstract class MenuState {}

class All extends MenuState {}

class Pinned extends MenuState {}

class Archive extends MenuState {}

class Trash extends MenuState {}

class Support extends MenuState {}
