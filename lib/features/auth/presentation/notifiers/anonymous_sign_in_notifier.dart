import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/auth/data/repositories/anonymous_repository.dart';

final anonymousSignInNotifierProvider =
    StateNotifierProvider<AnonymousSignInNotifier, GenericState<void>>((ref) {
  return AnonymousSignInNotifier(ref.watch(anonymousSignInRepositoryrovider));
});

class AnonymousSignInNotifier extends GenericStateNotifier<void> {
  AnonymousSignInNotifier(this.repository);

  final AnonymousSignInRepository repository;

  void signInAnonymous() {
    sendRequest(() async {
      return repository.anonymousSignInAuth();
    });
  }
}
