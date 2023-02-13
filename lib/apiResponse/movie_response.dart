class MovieResponse {
  final int? page;
  final List<Movie>? results;

  MovieResponse({this.page, this.results});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Movie> movieList =
    list.map((i) => Movie.fromJson(i)).toList();

    return MovieResponse(
        page: json['page'],
        results: movieList);
  }
}

class Movie {
  final int? id;
  final String? title;
  final String? name;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final String? firstAirDate;

  Movie(
      {this.id,
        this.title,
        this.name,
        this.overview,
        this.posterPath,
        this.releaseDate,
        this.firstAirDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      firstAirDate: json['first_air_date'],
    );
  }
}