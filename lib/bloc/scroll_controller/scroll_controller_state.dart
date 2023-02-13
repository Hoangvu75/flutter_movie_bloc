class ScrollControllerState {
  bool isOnTop;
  ScrollControllerState({required this.isOnTop});
}

class ScrollControllerInitialState extends ScrollControllerState {
  ScrollControllerInitialState(): super(isOnTop: true);
}

