import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/blocs/action/action_bloc.dart';

import 'main.dart';

class MainPageRoute extends MaterialPageRoute {
  MainPageRoute()
      : super(
          builder: (context) {
            return BlocProvider(
              create: (c) => ActionCubit.get(c),
              child: MainPage(),
            );
          },
        );
}
