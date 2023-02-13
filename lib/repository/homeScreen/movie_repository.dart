
import '../../apiResponse/movie_response.dart';
import '../../services/api_service.dart';
import '../../utils/app_utils.dart';

class MovieRepository {
  Future<List<Movie>> fetchTrendingMovie() async {
    final response = await ApiService.create().getTrendingMovies(apiKey);
    final List<Movie> movies = response.results!;
    return movies;
  }

  Future<List<Movie>> fetchUpcomingMovie() async {
    final response = await ApiService.create().getUpcomingMovies(apiKey);
    final List<Movie> movies = response.results!;
    return movies;
  }

  Future<List<Movie>> fetchTopRatedMovie() async {
    final response = await ApiService.create().getTopRatedMovies(apiKey);
    final List<Movie> movies = response.results!;
    return movies;
  }

  Future<List<Movie>> fetchPopularMovie() async {
    final response = await ApiService.create().getPopularMovies(apiKey);
    final List<Movie> movies = response.results!;
    return movies;
  }
}