import 'package:get_it/get_it.dart';

import 'package:movie_colony/features/notification/data/datasources/add_notif_list_remote_data_source.dart';
import 'package:movie_colony/features/notification/data/repositories/add_notif_list_repository_impl.dart';
import 'package:movie_colony/features/notification/domain/repositories/add_notif_list_repository.dart';
import 'package:movie_colony/features/notification/domain/usecases/add_notif_list.dart';
import 'package:movie_colony/features/notification/presentation/notifiers/add_notif_list_notifier.dart';

class NotificationListServiceLocator {
  NotificationListServiceLocator(this.sl);
  final GetIt sl;

// ignore_for_file: cascade_invocations
  void init() {
    ///view models/notifiers

    sl.registerLazySingleton<AddNotifListNotifier>(
      () => AddNotifListNotifier(sl()),
    );

    ///datasources
    sl.registerLazySingleton<AddNotifListRemoteDataSource>(
      () => AddNotifListRemoteDataSourceImpl(
        methods: sl(),
      ),
    );

    ///usecases
    sl.registerLazySingleton(() => AddNotificationList(sl()));

    ///repository

    sl.registerLazySingleton<AddNotifListRepository>(
      () => AddNotifListRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );
  }
}
