import 'package:flutter/cupertino.dart';

abstract class PosterState {
  NetworkImage poster;
  PosterState({required this.poster});
}

class PosterLoadingState extends PosterState {
  PosterLoadingState(): super(poster: const NetworkImage(""));
}

class PosterLoadedState extends PosterState {
  PosterLoadedState({required super.poster});
}