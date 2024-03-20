import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/auth/data/repositories/google_sign_in_repository.dart';

final googleSignInNotifierProvider =
    StateNotifierProvider<GoogleSignInNotifier, GenericState<void>>((ref) {
  return GoogleSignInNotifier(ref.watch(googleSignInRepositoryProvider));
});

class GoogleSignInNotifier extends GenericStateNotifier<void> {
  GoogleSignInNotifier(this.googleSignInRepository);

  final GoogleSignInRepository googleSignInRepository;

  void signInWithGoogle() {
    sendRequest(() async {
      return googleSignInRepository.googleSignInAuth();
    });
  }
}
