import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:movie_colony/core/cache/app_cache.dart';
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/firebase_methods.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/core/theme/theme.dart';
import 'package:movie_colony/features/auth/service_locator.dart';
import 'package:movie_colony/features/categories/service_locator.dart';
import 'package:movie_colony/features/configuration/service_locator.dart';
import 'package:movie_colony/features/notification/service_locator.dart';
import 'package:movie_colony/features/single_tv/service_locator.dart';
import 'package:movie_colony/features/trending/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

// ignore_for_file: cascade_invocations
Future<void> init() async {
  ConfigurationServiceLocator(sl).init();
  CategoriesServiceLocator(sl).init();
  TrendingServiceLocator(sl).init();
  SingleTvServiceLocator(sl).init();
  AuthServiceLocator(sl).init();
  NotificationListServiceLocator(sl).init();

  ///view models/notifiers
  sl.registerLazySingleton<CustomTheme>(
    () => CustomTheme(sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(NetworkInfoImpl.new);
  sl.registerLazySingleton<AppCache>(() => AppCacheImpl(sl()));
  sl.registerLazySingleton<Config>(() => Config(sl()));
  sl.registerLazySingleton<FirebaseMethods>(
    () => FirebaseMethods(
      store: sl(),
      auth: sl(),
    ),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleAuthProvider authProvider = GoogleAuthProvider();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<FirebaseFirestore>(() => firestore);
  sl.registerLazySingleton<FirebaseAuth>(() => auth);
  sl.registerLazySingleton<GoogleAuthProvider>(() => authProvider);
  sl.registerLazySingleton<GoogleSignIn>(() => googleSignIn);

  sl.registerLazySingleton<http.Client>(http.Client.new);
}
