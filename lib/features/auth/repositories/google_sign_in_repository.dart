import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/data/firebase_methods.dart';

final googleSignInRepositoryProvider = Provider<GoogleSignInRepository>((ref) {
  return GoogleSignInRepository(
    firebaseMethods: ref.watch(firebaseMethodsProvider),
  );
});

class GoogleSignInRepository {
  GoogleSignInRepository({
    required this.firebaseMethods,
  });
  final FirebaseMethods firebaseMethods;

  Future<void> googleSignInAuth() async {
    await firebaseMethods.signInWithGoogle();
  }
}
