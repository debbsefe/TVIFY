import 'package:get_it/get_it.dart';

import 'data/datasources/trending_local_data_source.dart';
import 'data/datasources/trending_remote_data_source.dart';
import 'data/repositories/trending_repository_impl.dart';
import 'domain/repositories/trending_repository.dart';
import 'domain/usecases/get_trending_daily.dart';
import 'domain/usecases/get_trending_weekly.dart';
import 'presentation/notifiers/daily_trending_notifier.dart';
import 'presentation/notifiers/weekly_trending_notifier.dart';

class TrendingServiceLocator {
  TrendingServiceLocator(this.sl);
  final GetIt sl;
// ignore_for_file: cascade_invocations
  void init() {
    sl.registerLazySingleton<WeeklyTrendingNotifier>(
      () => WeeklyTrendingNotifier(sl()),
    );

    sl.registerLazySingleton<DailyTrendingNotifier>(
      () => DailyTrendingNotifier(sl()),
    );

    ///datasources

    sl.registerLazySingleton<TrendingRemoteDataSource>(
      () => TrendingRemoteDataSourceImpl(
        client: sl(),
        config: sl(),
      ),
    );

    sl.registerLazySingleton<TrendingLocalDataSource>(
      () => TrendingLocalDataSourceImpl(
        sl(),
      ),
    );

    ///usecases
    sl.registerLazySingleton(() => GetWeeklyTrending(sl()));
    sl.registerLazySingleton(() => GetDailyTrending(sl()));

    ///repository

    sl.registerLazySingleton<TrendingRepository>(
      () => TrendingRepositoryImpl(
        localDataSource: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );
  }
}
