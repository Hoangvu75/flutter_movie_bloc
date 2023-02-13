import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/bloc/homeScreen/poster/poster_bloc.dart';
import 'package:movie_app_bloc/repository/homeScreen/poster_repository.dart';
import 'package:movie_app_bloc/screens/homeScreen/home_screen_body.dart';

import '../../bloc/homeScreen/movie/movie_bloc.dart';
import '../../bloc/scroll_controller/scroll_controller_bloc.dart';
import '../../repository/homeScreen/movie_repository.dart';
import '../../utils/app_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppUtils.mainContext = context;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PosterRepository>(
          create: (context) => PosterRepository(),
        ),
        RepositoryProvider<MovieRepository>(
          create: (context) => MovieRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ScrollControllerBloc>(
            create: (context) => ScrollControllerBloc(),
          ),
          BlocProvider<PosterBloc>(
            create: (context) => PosterBloc(
              RepositoryProvider.of<PosterRepository>(context),
            ),
          ),
          BlocProvider<MovieBloc>(
            create: (context) => MovieBloc(
              RepositoryProvider.of<MovieRepository>(context),
            ),
          ),
        ],
        child: const AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child: HomeScreenBody(),
        ),
      ),
    );
  }
}
