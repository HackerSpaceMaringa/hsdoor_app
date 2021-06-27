abstract class KeysState {}

class KeysInitialState extends KeysState {}

class KeysLoadingState extends KeysState {}

class KeysLoadedState extends KeysState {
  final List<String> keys;
  final int threshold;

  KeysLoadedState({
    required this.keys,
    required this.threshold,
  });
}

class KeysErrorState extends KeysState {
  final String message;

  KeysErrorState({
    required this.message,
  });
}
