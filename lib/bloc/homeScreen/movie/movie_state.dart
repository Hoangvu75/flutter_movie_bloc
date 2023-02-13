import '../../../apiResponse/movie_response.dart';

abstract class MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  MovieLoadedState(this.trendingMovies, this.upcomingMovies, this.topRatedMovies, this.popularMovies);
  final List<Movie> trendingMovies;
  final List<Movie> upcomingMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> popularMovies;
}

class MovieErrorState extends MovieState {
  MovieErrorState(this.error);
  final String error;
}