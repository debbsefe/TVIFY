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
    required FirebaseFirestore store,
    required FirebaseAuth auth,
    required GoogleAuthProvider googleAuthProvider,
    required GoogleSignIn googleSignIn,
  })  : _store = store,
        _auth = auth,
        _googleAuthProvider = googleAuthProvider,
        _googleSignIn = googleSignIn;

  final FirebaseFirestore _store;
  final FirebaseAuth _auth;
  final GoogleAuthProvider _googleAuthProvider;
  final GoogleSignIn _googleSignIn;

  Future<void> signInAnonymous() async {
    await _auth.signInAnonymously();
  }

  Future<void> signInWithGoogle() async {
    if (kIsWeb) {
      await _auth.signInWithPopup(_googleAuthProvider);
    } else {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await _auth.signInWithCredential(credential);
      }
    }
  }

  DocumentReference<NotificationListModel> readWriteNotificationList({
    required String docName,
    required String collection,
  }) {
    final userId = _auth.currentUser?.uid;
    final reference = _store
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