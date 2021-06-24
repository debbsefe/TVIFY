import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../features/notification/data/models/notification_list_model.dart';

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
