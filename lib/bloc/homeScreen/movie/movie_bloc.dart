import 'package:bloc/bloc.dart';
import 'package:movie_app_bloc/repository/homeScreen/movie_repository.dart';

import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  late final MovieRepository _movieRepository;

  MovieBloc(this._movieRepository) : super(MovieLoadingState()) {
    on<LoadMovieEvent>((event, emit) async {
      emit(MovieLoadingState());
      try {
        final trendingMovies = await _movieRepository.fetchTrendingMovie();
        final upcomingMovies = await _movieRepository.fetchUpcomingMovie();
        final topRatedMovies = await _movieRepository.fetchTopRatedMovie();
        final popularMovies = await _movieRepository.fetchPopularMovie();
        emit(MovieLoadedState(trendingMovies, upcomingMovies, topRatedMovies, popularMovies));
      } on Exception catch (e) {
        emit(MovieErrorState(e.toString()));
      }
    });
  }
}