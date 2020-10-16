import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/search/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(Default());

  void switchState() {
    if (state is Default) {
      emit(Search(""));
    } else if (state is Search) {
      emit(Default());
    }
  }

  void searchState(String query) => emit(Search(query));

  void defaultState() => emit(Default());
}
