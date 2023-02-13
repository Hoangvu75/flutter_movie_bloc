import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app_bloc/bloc/homeScreen/poster/poster_event.dart';
import 'package:movie_app_bloc/bloc/homeScreen/poster/poster_state.dart';
import 'package:movie_app_bloc/repository/homeScreen/poster_repository.dart';

class PosterBloc extends Bloc<PosterEvent, PosterState> {
  late final PosterRepository _homePosterRepository;

  PosterBloc(this._homePosterRepository) : super(PosterLoadingState()) {
    on<LoadPosterEvent>((event, emit) async {
      emit(PosterLoadingState());
      try {
        final poster = await _homePosterRepository.getPoster();
        emit(PosterLoadedState(poster: poster));
      } on Exception catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    });
  }
}