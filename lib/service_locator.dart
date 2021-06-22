import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/cache/app_cache.dart';
import 'core/config.dart';
import 'core/network/network_info.dart';
import 'core/theme/theme.dart';
import 'features/auth/service_locator.dart';
import 'features/categories/service_locator.dart';
import 'features/configuration/service_locator.dart';
import 'features/single_tv/service_locator.dart';
import 'features/trending/service_locator.dart';

final sl = GetIt.instance;

// ignore_for_file: cascade_invocations
Future<void> init() async {
  ConfigurationServiceLocator(sl).init();
  CategoriesServiceLocator(sl).init();
  TrendingServiceLocator(sl).init();
  SingleTvServiceLocator(sl).init();
  AuthServiceLocator(sl).init();

  ///view models/notifiers
  sl.registerLazySingleton<CustomTheme>(
    () => CustomTheme(sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<AppCache>(() => AppCacheImpl(sl()));
  sl.registerLazySingleton<Config>(() => ConfigImpl(sl()));

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

  sl.registerLazySingleton<http.Client>(() => http.Client());
}
