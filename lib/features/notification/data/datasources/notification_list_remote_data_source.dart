import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/data/firebase_methods.dart';
import 'package:movie_colony/core/model/notification_list_model.dart';

final notificationListRemoteDataSourceProvider =
    Provider<NotificationListRemoteDataSource>((ref) {
  return NotificationListRemoteDataSource(
    methods: ref.watch(firebaseMethodsProvider),
  );
});

class NotificationListRemoteDataSource {
  NotificationListRemoteDataSource({required this.methods});
  final FirebaseMethods methods;

  Future<void> addNotification(NotificationListModel model) async {
    return methods
        .writeNotificationList(
          docName: model.id.toString(),
        )
        .set(model);
  }

  Future<void> removeNotification(NotificationListModel model) async {
    return methods
        .writeNotificationList(
          docName: model.id.toString(),
        )
        .delete();
  }

  Stream<QuerySnapshot<NotificationListModel>> fetchNotificationList() {
    return methods.readNotificationList();
  }
}
