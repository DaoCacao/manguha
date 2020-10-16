import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/search/search_cubit.dart';
import 'package:manguha/res/colors.dart';
import 'package:manguha/res/strings.dart';

class SearchField extends StatelessWidget {
  final FocusNode focus;

  SearchField({this.focus});

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focus,
      textInputAction: TextInputAction.search,
      style: TextStyle(fontSize: 12, color: AppColors.textPrimary),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: AppStrings.searchByName,
        hintStyle: TextStyle(
          fontSize: 12,
          color: AppColors.textSecondary,
          decoration: TextDecoration.underline,
        ),
      ),
      onChanged: (query) => context.bloc<SearchCubit>().searchState(query),
    );
  }
}
