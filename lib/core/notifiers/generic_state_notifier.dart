import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';

class GenericStateNotifier<T> extends StateNotifier<GenericState<T>> {
  GenericStateNotifier() : super(const GenericState.initial());
  final logger = Logger('GenericStateNotifier $T');

  Future<GenericState<T>> sendRequest(
    Future<T> Function() function,
  ) async {
    try {
      state = GenericState<T>.loading();
      final response = await function();
      state = GenericState<T>.loaded(response);
    } catch (e) {
      state = GenericState<T>.error(e);
      logger.fine(e);
    }
    return state;
  }
}
