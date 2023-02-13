import 'package:bloc/bloc.dart';
import 'package:movie_app_bloc/repository/searchScreen/search_movie_repository.dart';

import 'search_movie_event.dart';
import 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  late final SearchMovieRepository _movieRepository;

  SearchMovieBloc(this._movieRepository) : super(SearchMovieNoState()) {
    on<LoadSearchMovieEvent>((event, emit) async {
      emit(SearchMovieLoadingState());
      try {
        final searchMovies = await _movieRepository.fetchSearchMovie(event.name);
        emit(SearchMovieLoadedState(searchMovies));
      } on Exception catch (e) {
        emit(SearchMovieErrorState(e.toString()));
      }
    });
  }
}