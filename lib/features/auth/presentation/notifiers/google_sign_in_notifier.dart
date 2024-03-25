import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/features/auth/repositories/google_sign_in_repository.dart';

final googleSignInNotifierProvider =
    StateNotifierProvider<GoogleSignInNotifier, GenericState<void>>((ref) {
  return GoogleSignInNotifier(ref.watch(googleSignInRepositoryProvider));
});

class GoogleSignInNotifier extends StateNotifier<GenericState<void>> {
  GoogleSignInNotifier(this.googleSignInRepository)
      : super(const GenericState.initial());

  final GoogleSignInRepository googleSignInRepository;

  Future<void> signInWithGoogle() async {
    try {
      state = const GenericState.loading();
      await googleSignInRepository.googleSignInAuth();
      state = const GenericState.loaded();
    } catch (e) {
      state = GenericState.error(e);
    }
  }
}
