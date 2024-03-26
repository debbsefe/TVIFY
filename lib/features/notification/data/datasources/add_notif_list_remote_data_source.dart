import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/data/firebase_methods.dart';
import 'package:movie_colony/core/model/notification_list_model.dart';
import 'package:movie_colony/core/utils/strings.dart';

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
    return methods
        .readWriteNotificationList(
          collection: Strings.notificationList,
          docName: model.id.toString(),
        )
        .set(model);
  }
}
