import 'package:flutter_bloc/flutter_bloc.dart';

import 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(All());

  void changeState(MenuState newState) => emit(newState);

  void toNone() => emit(All());

  void toPinned() => emit(Pinned());

  void toArchive() => emit(Archive());

  void toTrash() => emit(Trash());
}
