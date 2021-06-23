import 'package:firebase_auth/firebase_auth.dart';

abstract class AnonymousSignInRemoteDataSource {
  Future<User?> signInAnonymous();
}

class AnonymousSignInRemoteDataSourceImpl
    extends AnonymousSignInRemoteDataSource {
  AnonymousSignInRemoteDataSourceImpl({
    required this.auth,
  });
  final FirebaseAuth auth;

  @override
  Future<User?> signInAnonymous() async {
    User? user;

    UserCredential userCredential = await auth.signInAnonymously();
    user = userCredential.user;
    return user;
  }
}
