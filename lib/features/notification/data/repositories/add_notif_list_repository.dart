import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/model/notification_list_model.dart';
import 'package:movie_colony/features/notification/data/datasources/add_notif_list_remote_data_source.dart';

final addNotifListRepositoryProvider = Provider<AddNotifListRepository>((ref) {
  return AddNotifListRepository(
    remoteDataSource: ref.watch(addNotifListRemoteDataSourceProvider),
  );
});

class AddNotifListRepository {
  AddNotifListRepository({
    required this.remoteDataSource,
  });
  final AddNotifListRemoteDataSource remoteDataSource;

  Future<void> addNotificationList(
    NotificationListModel model,
  ) async {
    return remoteDataSource.addNotifListRemote(model);
  }
}
