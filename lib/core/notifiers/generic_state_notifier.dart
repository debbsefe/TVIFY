import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/utils/strings.dart';

class GenericStateNotifier<T> extends StateNotifier<GenericState<T>> {
  GenericStateNotifier() : super(const GenericState.initial());

  Future<GenericState<T>> sendRequest(
    Future<Either<Failure, T>> Function() function,
  ) async {
    state = GenericState<T>.loading();
    final response = await function();
    return response.fold(
      (failure) => state = GenericState<T>.error(
        failure.message == null
            ? mapFailureToMessage(failure)
            : failure.message!,
      ),
      (success) => state = GenericState<T>.loaded(success),
    );
  }
}
