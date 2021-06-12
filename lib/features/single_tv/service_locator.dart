import 'package:get_it/get_it.dart';

import 'data/datasources/tv_cast_remote_data_source.dart';
import 'data/datasources/tv_detail_remote_data_source.dart';
import 'data/repositories/tv_cast_repository_impl.dart';
import 'data/repositories/tv_detail_repository_impl.dart';
import 'domain/repositories/tv_cast_repository.dart';
import 'domain/repositories/tv_detail_repository.dart';
import 'domain/usecases/get_tv_cast.dart';
import 'domain/usecases/get_tv_detail.dart';
import 'presentation/notifiers/tv_cast/tv_cast_notifier.dart';
import 'presentation/notifiers/tv_detail/tv_detail_notifier.dart';

class SingleTvServiceLocator {
  SingleTvServiceLocator(this.sl);
  final GetIt sl;

// ignore_for_file: cascade_invocations
  void init() {
    ///view models/notifiers

    sl.registerLazySingleton<TvDetailNotifier>(
      () => TvDetailNotifier(sl()),
    );

    sl.registerLazySingleton<TvCastNotifier>(
      () => TvCastNotifier(sl()),
    );

    ///datasources
    sl.registerLazySingleton<TvDetailRemoteDataSource>(
      () => TvDetailRemoteDataSourceImpl(
        client: sl(),
        config: sl(),
      ),
    );

    sl.registerLazySingleton<TvCastRemoteDataSource>(
      () => TvCastRemoteDataSourceImpl(
        client: sl(),
        config: sl(),
      ),
    );

    ///usecases
    sl.registerLazySingleton(() => GetTvDetail(sl()));
    sl.registerLazySingleton(() => GetTvCast(sl()));

    ///repository

    sl.registerLazySingleton<TvDetailRepository>(
      () => TvDetailRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );

    sl.registerLazySingleton<TvCastRepository>(
      () => TvCastRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );
  }
}
