import 'package:bloc/bloc.dart';
import 'package:movie_app_bloc/bloc/scroll_controller/scroll_controller_event.dart';
import 'package:movie_app_bloc/bloc/scroll_controller/scroll_controller_state.dart';

class ScrollControllerBloc extends Bloc<ScrollControllerEvent, ScrollControllerState> {
  ScrollControllerBloc() : super(ScrollControllerInitialState()) {
    on<ScrollControllerEvent>((event, emit) {
      if (event is OnTopEvent) {
        emit(ScrollControllerState(isOnTop: true));
      } else {
        emit(ScrollControllerState(isOnTop: false));
      }
    });
  }
}
