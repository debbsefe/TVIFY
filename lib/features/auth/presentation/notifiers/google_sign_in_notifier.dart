import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:movie_colony/core/model/loading_state.dart';
import 'package:movie_colony/features/auth/repositories/google_sign_in_repository.dart';

final googleSignInNotifierProvider =
    StateNotifierProvider<GoogleSignInNotifier, LoadingState>((ref) {
  return GoogleSignInNotifier(ref.watch(googleSignInRepositoryProvider));
});

class GoogleSignInNotifier extends StateNotifier<LoadingState> {
  GoogleSignInNotifier(this.googleSignInRepository)
      : super(const LoadingState.idle());

  final GoogleSignInRepository googleSignInRepository;
  final logger = Logger('GoogleSignInNotifier');

  Future<void> signInWithGoogle() async {
    try {
      state = const LoadingState.loading();
      final result = await googleSignInRepository.googleSignInAuth();
      if (result == null) {
        state = const LoadingState.error('Google Sign In Failed');
        return;
      }
      state = const LoadingState.success();
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
