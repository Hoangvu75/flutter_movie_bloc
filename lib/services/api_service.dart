import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

import '../apiResponse/movie_response.dart';
import '../utils/app_utils.dart';


part 'api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options.connectTimeout = 60000;
    dio.interceptors.add(PrettyDioLogger());

    return ApiService(
      dio,
      baseUrl: baseUrl,
    );
  }

  // Get movie list
  @GET("/trending/movie/day")
  Future<MovieResponse> getTrendingMovies(@Query("api_key") String apiKey);

  @GET("/movie/upcoming")
  Future<MovieResponse> getUpcomingMovies(@Query("api_key") String apiKey);

  @GET("/movie/popular")
  Future<MovieResponse> getPopularMovies(@Query("api_key") String apiKey);

  @GET("/movie/top_rated")
  Future<MovieResponse> getTopRatedMovies(@Query("api_key") String apiKey);

  @GET("/search/movie")
  Future<MovieResponse> getSearchMovies(
      @Query("api_key") String apiKey, @Query("query") String query, @Query("include_adult") bool includeAdult);
}
