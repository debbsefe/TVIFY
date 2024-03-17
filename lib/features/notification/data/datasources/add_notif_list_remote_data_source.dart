import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/firebase_methods.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/notification/data/models/notification_list_model.dart';

abstract class AddNotifListRemoteDataSource {
  Future<void> addNotifListRemote(NotificationListModel model);
}

class AddNotifListRemoteDataSourceImpl implements AddNotifListRemoteDataSource {
  AddNotifListRemoteDataSourceImpl({required this.methods});
  final FirebaseMethods methods;

  @override
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
