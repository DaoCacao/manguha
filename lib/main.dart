import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/app_router.dart';
import 'package:manguha/blocs/menu/menu_bloc.dart';
import 'package:manguha/blocs/note/note_bloc.dart';
import 'package:manguha/blocs/pinned_notes/pinned_notes_bloc.dart';
import 'package:manguha/data/database.dart';
import 'package:manguha/data/note_repository.dart';
import 'package:manguha/pages/details/page_details.dart';
import 'package:manguha/pages/menu.dart';
import 'package:manguha/pages/splash.dart';
import 'package:manguha/res/colors.dart';

import 'blocs/bloc_observer.dart';
import 'blocs/all_notes/all_notes_bloc.dart';
import 'blocs/search_cubit.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => NoteDatabase()),
        RepositoryProvider(create: (c) => NoteRepository(c.repository())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => MenuCubit()),
          BlocProvider(create: (c) => AllNotesBloc(c.repository())),
          BlocProvider(create: (c) => PinnedNotesBloc(c.repository())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.background,
            primaryColor: AppColors.primary,
            accentColor: AppColors.accent,
            bottomAppBarColor: AppColors.primary,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Comfortaa',
          ),
          routes: {
            AppRouter.splash: (_) => SplashPage(),
            AppRouter.main: (_) => BlocProvider(
                  create: (c) => SearchCubit(c.bloc(), c.bloc()),
                  child: MenuPage(),
                ),
            AppRouter.create: (_) => BlocProvider(
                  create: (c) => NoteBloc(c.repository(), c.bloc(), c.bloc()),
                  child: DetailsPage.create(),
                ),
          },
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case AppRouter.details:
                return MaterialPageRoute(
                  builder: (_) => BlocProvider(
                      create: (c) =>
                          NoteBloc(c.repository(), c.bloc(), c.bloc()),
                      child: DetailsPage.open(settings.arguments)),
                );
              default:
                return null;
            }
          },
        ),
      ),
    );
  }
}
