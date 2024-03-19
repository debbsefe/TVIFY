import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/auth/domain/usecases/sign_in_anonymous.dart';

final anonymousSignInNotifierProvider =
    StateNotifierProvider<AnonymousSignInNotifier, GenericState<void>>((ref) {
  return AnonymousSignInNotifier(ref.watch(signInAnonymousProvider));
});

class AnonymousSignInNotifier extends GenericStateNotifier<void> {
  AnonymousSignInNotifier(this.usecase);

  final SignInAnonymous usecase;

  void signInAnonymous() {
    sendRequest(() async {
      return usecase(NoParams());
    });
  }
}
