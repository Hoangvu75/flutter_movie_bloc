import '../../apiResponse/movie_response.dart';
import '../../services/api_service.dart';
import '../../utils/app_utils.dart';

class SearchMovieRepository {
  Future<List<Movie>> fetchSearchMovie(String name) async {
    final response = await ApiService.create().getSearchMovies(apiKey, name, true);
    final List<Movie> movies = response.results!;
    return movies;
  }
}