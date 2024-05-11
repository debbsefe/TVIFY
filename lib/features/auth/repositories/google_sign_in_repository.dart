import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tvify/core/data/firebase_methods.dart';

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

  Future<UserCredential?> googleSignInAuth() async {
    return firebaseMethods.signInWithGoogle();
  }
}
