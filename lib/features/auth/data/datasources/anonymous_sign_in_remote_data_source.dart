import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/providers.dart';

final anonymousSignInRemoteDataSourceProvider =
    Provider<AnonymousSignInRemoteDataSource>((ref) {
  return AnonymousSignInRemoteDataSource(auth: ref.watch(firebaseAuthProvider));
});

class AnonymousSignInRemoteDataSource {
  AnonymousSignInRemoteDataSource({
    required this.auth,
  });
  final FirebaseAuth auth;

  Future<void> signInAnonymous() async {
    await auth.signInAnonymously();
  }
}
