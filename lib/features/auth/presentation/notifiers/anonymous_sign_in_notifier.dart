import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:tvify/core/model/loading_state.dart';
import 'package:tvify/features/auth/repositories/anonymous_repository.dart';

final anonymousSignInNotifierProvider =
    StateNotifierProvider<AnonymousSignInNotifier, LoadingState>((ref) {
  return AnonymousSignInNotifier(ref.watch(anonymousSignInRepositoryrovider));
});

class AnonymousSignInNotifier extends StateNotifier<LoadingState> {
  AnonymousSignInNotifier(this.repository) : super(const LoadingState.idle());

  final AnonymousSignInRepository repository;
  final logger = Logger('AnonymousSignInNotifier');

  Future<void> signInAnonymous() async {
    try {
      state = const LoadingState.loading();
      await repository.anonymousSignInAuth();
      state = const LoadingState.success();
    } catch (e) {
      state = LoadingState.error(e.toString());
      logger.fine(e.toString());
    }
  }
}
