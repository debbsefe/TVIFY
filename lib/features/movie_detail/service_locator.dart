import 'package:get_it/get_it.dart';

import 'data/datasources/movie_detail_remote_data_source.dart';
import 'data/repositories/movie_detail_repository_impl.dart';
import 'domain/repositories/movie_detail_repository.dart';
import 'domain/usecases/get_movie_detail.dart';
import 'presentation/notifiers/movie_detail_notifier.dart';

class MovieDetailServiceLocator {
  MovieDetailServiceLocator(this.sl);
  final GetIt sl;

// ignore_for_file: cascade_invocations
  void init() {
    ///view models/notifiers

    sl.registerLazySingleton<MovieDetailNotifier>(
      () => MovieDetailNotifier(sl()),
    );

    ///datasources
    sl.registerLazySingleton<MovieDetailRemoteDataSource>(
      () => MovieDetailRemoteDataSourceImpl(
        client: sl(),
        config: sl(),
      ),
    );

    ///usecases
    sl.registerLazySingleton(() => GetMovieDetail(sl()));

    ///repository

    sl.registerLazySingleton<MovieDetailRepository>(
      () => MovieDetailRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );
  }
}
