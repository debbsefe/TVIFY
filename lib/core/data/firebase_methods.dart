import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_colony/core/model/notification_list_model.dart';
import 'package:movie_colony/core/utils/strings.dart';
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
  final notificationCollection = Strings.notificationList;

  Future<UserCredential?> signInAnonymous() async {
    return _auth.signInAnonymously();
  }

  Future<UserCredential?> signInWithGoogle() async {
    if (kIsWeb) {
      return _auth.signInWithPopup(_googleAuthProvider);
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
        return _auth.signInWithCredential(credential);
      }
      return null;
    }
  }

  DocumentReference<NotificationListModel> writeNotificationList({
    required String docName,
  }) {
    final userId = _auth.currentUser?.uid;
    final reference = _store
        .collection(notificationCollection)
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

  Future<QuerySnapshot<NotificationListModel>> getPaginatedNotificationList(
    DocumentSnapshot? lastDocument,
  ) {
    final userId = _auth.currentUser?.uid;
    Query<NotificationListModel> query = _store
        .collection(notificationCollection)
        .doc(userId)
        .collection('tv')
        .withConverter<NotificationListModel>(
          fromFirestore: (snapshot, _) =>
              NotificationListModel.fromJson(snapshot.data()!),
          toFirestore: (tv, _) => tv.toJson(),
        )
        .orderBy('created_at', descending: true)
        .limit(20);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.get();
  }

  Stream<bool> isInNotificationList(
    String docId,
  ) {
    final userId = _auth.currentUser?.uid;
    final reference = _store
        .collection(notificationCollection)
        .doc(userId)
        .collection('tv')
        .doc(docId);

    return reference.snapshots().map((snapshot) => snapshot.exists);
  }

  Stream<int> getNotificationListLength() {
    final userId = _auth.currentUser?.uid;
    final reference =
        _store.collection(notificationCollection).doc(userId).collection('tv');

    return reference.snapshots().map((snapshot) => snapshot.size);
  }
}
