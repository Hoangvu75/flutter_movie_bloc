import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../apiResponse/movie_response.dart';
import '../../services/api_service.dart';
import '../../utils/app_utils.dart';

class PosterRepository {
  Future<NetworkImage> getPoster() async {
    final response = await ApiService.create().getTrendingMovies(apiKey);
    final List<Movie> movies = response.results!;
    return NetworkImage(
      "https://image.tmdb.org/t/p/w500${movies[0].posterPath}",
    );
  }
}
