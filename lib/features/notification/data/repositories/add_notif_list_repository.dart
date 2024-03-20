import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/notification/data/datasources/add_notif_list_remote_data_source.dart';
import 'package:movie_colony/features/notification/data/models/notification_list_model.dart';

final addNotifListRepositoryProvider = Provider<AddNotifListRepository>((ref) {
  return AddNotifListRepository(
    remoteDataSource: ref.watch(addNotifListRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

class AddNotifListRepository {
  AddNotifListRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final AddNotifListRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  Future<void> addNotificationList(
    NotificationListModel model,
  ) async {
    final remote = await remoteDataSource.addNotifListRemote(model);
    return remote;
  }
}
