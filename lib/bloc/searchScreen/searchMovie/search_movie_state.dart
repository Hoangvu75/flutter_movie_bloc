import '../../../apiResponse/movie_response.dart';

abstract class SearchMovieState {}

class SearchMovieNoState extends SearchMovieState {}

class SearchMovieLoadingState extends SearchMovieState {}

class SearchMovieLoadedState extends SearchMovieState {
  SearchMovieLoadedState(this.searchMovies);
  final List<Movie> searchMovies;
}

class SearchMovieErrorState extends SearchMovieState {
  SearchMovieErrorState(this.error);
  final String error;
}