import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/data_layer.dart';

import 'app.dart';
import 'blocs/bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runApp(
    DataLayer(
      child: App(),
    ),
  );
}
