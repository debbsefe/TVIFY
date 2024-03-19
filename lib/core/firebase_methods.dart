import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/features/notification/data/models/notification_list_model.dart';
import 'package:movie_colony/providers.dart';

final firebaseMethodsProvider = Provider<FirebaseMethods>((ref) {
  return FirebaseMethods(
    store: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider),
  );
});

class FirebaseMethods {
  FirebaseMethods({required this.store, required this.auth});

  final FirebaseFirestore store;
  final FirebaseAuth auth;

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
