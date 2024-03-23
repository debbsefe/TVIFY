import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';

class GenericStateNotifier<T> extends StateNotifier<GenericState<T>> {
  GenericStateNotifier() : super(const GenericState.initial());

  Future<GenericState<T>> sendRequest(
    Future<T> Function() function,
  ) async {
    try {
      state = GenericState<T>.loading();
      final response = await function();
      state = GenericState<T>.loaded(response);
    } catch (e) {
      // TODO(anyone): handle error later
      state = GenericState<T>.error('There is an error');
    }
    return state;
  }
}
