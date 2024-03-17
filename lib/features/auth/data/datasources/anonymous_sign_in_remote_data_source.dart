import 'package:firebase_auth/firebase_auth.dart';

class AnonymousSignInRemoteDataSource {
  AnonymousSignInRemoteDataSource({
    required this.auth,
  });
  final FirebaseAuth auth;

  Future<void> signInAnonymous() async {
    await auth.signInAnonymously();
  }
}
