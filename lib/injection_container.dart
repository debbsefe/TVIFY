import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:http/http.dart' as http;

import 'core/config.dart';
import 'core/network/network_info.dart';
import 'core/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

import 'core/theme/theme_shared_preference.dart';
import 'features/categories/data/datasources/categories_local_data_source.dart';
import 'features/categories/data/datasources/categories_remote_data_source.dart';
import 'features/categories/data/repositories/categories_repository_impl.dart';
import 'features/categories/domain/repositories/categories_repository.dart';
import 'features/categories/domain/usecases/get_categories.dart';
import 'features/categories/presentation/notifiers/categories_notifier.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<CustomTheme>(
    () => CustomTheme(sl()),
  );
  sl.registerLazySingleton<CategoriesNotifier>(
    () => CategoriesNotifier(sl()),
  );
  sl.registerLazySingleton<ThemeSharedPreference>(
    () => ThemeSharedPreference(sl()),
  );
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(
      client: sl(),
      config: sl(),
    ),
  );

  sl.registerLazySingleton<CategoriesLocalDataSource>(
    () => CategoriesLocalDataSourceImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton(() => GetAllCategories(sl()));

  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
      cache: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<Config>(() => ConfigImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  final RemoteConfig remoteConfig = await RemoteConfig.instance;

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => remoteConfig);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
