import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_colony/features/trending/domain/usecases/get_trending_weekly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/cache/app_cache.dart';
import 'core/config.dart';
import 'core/custom_shared_preference/custom_shared_preference.dart';
import 'core/network/network_info.dart';
import 'core/theme/theme.dart';
import 'core/theme/theme_shared_preference.dart';
import 'features/categories/data/datasources/categories_local_data_source.dart';
import 'features/categories/data/datasources/categories_remote_data_source.dart';
import 'features/categories/data/repositories/categories_repository_impl.dart';
import 'features/categories/domain/repositories/categories_repository.dart';
import 'features/categories/domain/usecases/get_categories.dart';
import 'features/categories/presentation/notifiers/categories_notifier.dart';
import 'features/trending/data/datasources/trending_local_data_source.dart';
import 'features/trending/data/datasources/trending_remote_data_source.dart';
import 'features/trending/data/repositories/trending_repository_impl.dart';
import 'features/trending/domain/repositories/trending_repository.dart';
import 'features/trending/domain/usecases/get_trending_daily.dart';
import 'features/trending/presentation/notifiers/daily_trending_notifier.dart';
import 'features/trending/presentation/notifiers/weekly_trending_notifier.dart';

final sl = GetIt.instance;

// ignore_for_file: cascade_invocations
Future<void> init() async {
  //view models/notifiers
  sl.registerLazySingleton<CustomTheme>(
    () => CustomTheme(sl()),
  );
  sl.registerLazySingleton<CategoriesNotifier>(
    () => CategoriesNotifier(sl()),
  );
  sl.registerLazySingleton<WeeklyTrendingNotifier>(
    () => WeeklyTrendingNotifier(sl()),
  );

  sl.registerLazySingleton<DailyTrendingNotifier>(
    () => DailyTrendingNotifier(sl()),
  );
  sl.registerLazySingleton<ThemeSharedPreference>(
    () => ThemeSharedPreference(sl()),
  );

  ///datasources
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(
      client: sl(),
      config: sl(),
    ),
  );

  sl.registerLazySingleton<TrendingRemoteDataSource>(
    () => TrendingRemoteDataSourceImpl(
      client: sl(),
      config: sl(),
    ),
  );

  sl.registerLazySingleton<CategoriesLocalDataSource>(
    () => CategoriesLocalDataSourceImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton<TrendingLocalDataSource>(
    () => TrendingLocalDataSourceImpl(
      sl(),
    ),
  );

  ///usecases
  sl.registerLazySingleton(() => GetAllCategories(sl()));
  sl.registerLazySingleton(() => GetWeeklyTrending(sl()));
  sl.registerLazySingleton(() => GetDailyTrending(sl()));

  ///repository

  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
      cache: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<TrendingRepository>(
    () => TrendingRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<AppCache>(() => AppCacheImpl(sl()));
  sl.registerLazySingleton<CustomSharedPreference>(
      () => CustomSharedPreference(sl()));

  sl.registerLazySingleton<Config>(() => ConfigImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  final RemoteConfig remoteConfig = RemoteConfig.instance;

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => remoteConfig);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
