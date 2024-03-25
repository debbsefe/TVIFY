import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_colony/core/model/notification_list_model.dart';
import 'package:movie_colony/providers.dart';

final firebaseMethodsProvider = Provider<FirebaseMethods>((ref) {
  return FirebaseMethods(
    store: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider),
    googleAuthProvider: ref.watch(googleAuthProvider),
    googleSignIn: ref.watch(googleSignInProvider),
  );
});

class FirebaseMethods {
  FirebaseMethods({
    required this.store,
    required this.auth,
    required this.googleAuthProvider,
    required this.googleSignIn,
  });

  final FirebaseFirestore store;
  final FirebaseAuth auth;
  final GoogleAuthProvider googleAuthProvider;
  final GoogleSignIn googleSignIn;

  Future<void> signInAnonymous() async {
    await auth.signInAnonymously();
  }

  Future<void> signInWithGoogle() async {
    if (kIsWeb) {
      await auth.signInWithPopup(googleAuthProvider);
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

        await auth.signInWithCredential(credential);
      }
    }
  }

  DocumentReference<NotificationListModel> readWriteNotificationList({
    required String docName,
    required String collection,
  }) {
    final userId = auth.currentUser?.uid;
    final reference = FirebaseFirestore.instance
        .collection(collection)
        .doc(userId)
        .collection('tv')
        .doc(docName)
        .withConverter<NotificationListModel>(
          fromFirestore: (snapshot, _) =>
              NotificationListModel.fromJson(snapshot.data()!),
          toFirestore: (tv, _) => tv.toJson(),
        );
    return reference;
  }
}
