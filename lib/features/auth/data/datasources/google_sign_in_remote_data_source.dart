import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_colony/core/error/exception.dart';

abstract class GoogleSignInRemoteDataSource {
  Future<User?> signInWithGoogle();
}

class GoogleSignInRemoteDataSourceImpl extends GoogleSignInRemoteDataSource {
  GoogleSignInRemoteDataSourceImpl({
    required this.auth,
    required this.authProvider,
    required this.googleSignIn,
  });
  final FirebaseAuth auth;
  final GoogleAuthProvider authProvider;
  final GoogleSignIn googleSignIn;

  @override
  Future<User?> signInWithGoogle() async {
    User? user;

    if (kIsWeb) {
      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        throw ServerException();
      }
    } else {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            throw ConflictException();
          } else if (e.code == 'invalid-credential') {
            throw InvalidException();
          }
        } catch (e) {
          throw ServerException();
        }
      }
    }

    return user;
  }
}
