import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/data/data_layer.dart';
import 'package:manguha/domain/domain_layer.dart';

import 'domain/blocs/bloc_observer.dart';
import 'presentation/app.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runApp(
    DataLayer(
      child: DomainLayer(
        child: App(),
      ),
    ),
  );
}
