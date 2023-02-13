abstract class SearchMovieEvent {
  const SearchMovieEvent();
}

class LoadSearchMovieEvent extends SearchMovieEvent {
  final String name;
  const LoadSearchMovieEvent(this.name);
}