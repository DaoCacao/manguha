import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/action/action_bloc.dart';
import 'package:manguha/blocs/search/search_cubit.dart';

import 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final SearchCubit _search;
  MenuCubit(this._search) : super(All());

  void changeState(MenuState newState) {
    _search.defaultState();
    emit(newState);
  }
}
