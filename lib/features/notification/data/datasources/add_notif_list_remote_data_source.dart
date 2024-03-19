import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/firebase_methods.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/notification/data/models/notification_list_model.dart';

final addNotifListRemoteDataSourceProvider =
    Provider<AddNotifListRemoteDataSource>((ref) {
  return AddNotifListRemoteDataSource(
    methods: ref.watch(firebaseMethodsProvider),
  );
});

class AddNotifListRemoteDataSource {
  AddNotifListRemoteDataSource({required this.methods});
  final FirebaseMethods methods;

  Future<void> addNotifListRemote(NotificationListModel model) async {
    try {
      final ref = methods.readWriteNotificationList(
        collection: Strings.notificationList,
        docName: model.id.toString(),
      );
      await ref.set(model);
    } catch (e) {
      throw ServerException();
    }
  }
}
