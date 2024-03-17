import 'package:get_it/get_it.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_local_data_source.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_remote_data_source.dart';
import 'package:movie_colony/features/trending/data/repositories/trending_repository_impl.dart';
import 'package:movie_colony/features/trending/domain/usecases/get_trending_daily.dart';
import 'package:movie_colony/features/trending/domain/usecases/get_trending_weekly.dart';
import 'package:movie_colony/features/trending/presentation/notifiers/daily_trending_notifier.dart';
import 'package:movie_colony/features/trending/presentation/notifiers/weekly_trending_notifier.dart';

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
      () => TrendingRemoteDataSource(
        client: sl(),
        config: sl(),
      ),
    );

    sl.registerLazySingleton<TrendingLocalDataSource>(
      () => TrendingLocalDataSource(
        sl(),
      ),
    );

    ///usecases
    sl.registerLazySingleton(() => GetWeeklyTrending(sl()));
    sl.registerLazySingleton(() => GetDailyTrending(sl()));

    ///repository

    sl.registerLazySingleton<TrendingRepository>(
      () => TrendingRepository(
        localDataSource: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );
  }
}
