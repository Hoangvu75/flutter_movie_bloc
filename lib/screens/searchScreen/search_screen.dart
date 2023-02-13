import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/bloc/searchScreen/searchMovie/search_movie_bloc.dart';
import 'package:movie_app_bloc/repository/searchScreen/search_movie_repository.dart';
import 'package:movie_app_bloc/screens/searchScreen/search_screen_body.dart';

import '../../bloc/scroll_controller/scroll_controller_bloc.dart';
import '../../utils/app_utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    AppUtils.mainContext = context;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SearchMovieRepository>(
          create: (context) => SearchMovieRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ScrollControllerBloc>(
            create: (context) => ScrollControllerBloc(),
          ),
          BlocProvider<SearchMovieBloc>(
            create: (context) => SearchMovieBloc(
              RepositoryProvider.of<SearchMovieRepository>(context),
            ),
          ),
        ],
        child: const AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child: SearchScreenBody(),
        ),
      ),
    );
  }
}
