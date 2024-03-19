import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
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

  Future<Either<Failure, void>> addNotificationList(
    NotificationListModel model,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.addNotifListRemote(model);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(CacheFailure());
    }
  }
}
