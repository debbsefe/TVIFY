import 'package:get_it/get_it.dart';

import 'data/datasources/tv_detail_remote_data_source.dart';
import 'data/repositories/tv_detail_repository_impl.dart';
import 'domain/repositories/tv_detail_repository.dart';
import 'domain/usecases/get_tv_detail.dart';
import 'presentation/notifiers/movie_detail/tv_detail_notifier.dart';

class SingleTvServiceLocator {
  SingleTvServiceLocator(this.sl);
  final GetIt sl;

// ignore_for_file: cascade_invocations
  void init() {
    ///view models/notifiers

    sl.registerLazySingleton<TvDetailNotifier>(
      () => TvDetailNotifier(sl()),
    );

    ///datasources
    sl.registerLazySingleton<TvDetailRemoteDataSource>(
      () => TvDetailRemoteDataSourceImpl(
        client: sl(),
        config: sl(),
      ),
    );

    ///usecases
    sl.registerLazySingleton(() => GetTvDetail(sl()));

    ///repository

    sl.registerLazySingleton<TvDetailRepository>(
      () => TvDetailRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );
  }
}
