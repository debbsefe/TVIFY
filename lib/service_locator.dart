import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/cache/app_cache.dart';
import 'core/config.dart';
import 'core/network/network_info.dart';
import 'core/theme/theme.dart';
import 'features/categories/service_locator.dart';
import 'features/configuration/service_locator.dart';
import 'features/single_movie/service_locator.dart';
import 'features/trending/service_locator.dart';

final sl = GetIt.instance;

// ignore_for_file: cascade_invocations
Future<void> init() async {
  ConfigurationServiceLocator(sl).init();
  CategoriesServiceLocator(sl).init();
  TrendingServiceLocator(sl).init();
  SingleMovieServiceLocator(sl).init();

  ///view models/notifiers
  sl.registerLazySingleton<CustomTheme>(
    () => CustomTheme(sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<AppCache>(() => AppCacheImpl(sl()));
  sl.registerLazySingleton<Config>(() => ConfigImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  final RemoteConfig remoteConfig = RemoteConfig.instance;

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<RemoteConfig>(() => remoteConfig);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
}
