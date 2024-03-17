import 'package:get_it/get_it.dart';

import 'package:movie_colony/features/auth/data/datasources/anonymous_sign_in_remote_data_source.dart';
import 'package:movie_colony/features/auth/data/datasources/google_sign_in_remote_data_source.dart';
import 'package:movie_colony/features/auth/data/repositories/anonymous_repository_impl.dart';
import 'package:movie_colony/features/auth/data/repositories/google_sign_in_repository_impl.dart';
import 'package:movie_colony/features/auth/domain/repositories/anonymous_sign_in_repository.dart';
import 'package:movie_colony/features/auth/domain/repositories/google_sign_in_repository.dart';
import 'package:movie_colony/features/auth/domain/usecases/sign_in_anonymous.dart';
import 'package:movie_colony/features/auth/domain/usecases/sign_in_google.dart';
import 'package:movie_colony/features/auth/presentation/notifiers/anonymous_sign_in_notifier.dart';
import 'package:movie_colony/features/auth/presentation/notifiers/google_sign_in_notifier.dart';

class AuthServiceLocator {
  AuthServiceLocator(this.sl);
  final GetIt sl;

// ignore_for_file: cascade_invocations
  void init() {
    ///view models/notifiers

    sl.registerLazySingleton<GoogleSignInNotifier>(
      () => GoogleSignInNotifier(sl()),
    );

    sl.registerLazySingleton<AnonymousSignInNotifier>(
      () => AnonymousSignInNotifier(sl()),
    );

    ///datasources
    sl.registerLazySingleton<GoogleSignInRemoteDataSource>(
      () => GoogleSignInRemoteDataSourceImpl(
        googleSignIn: sl(),
        auth: sl(),
        authProvider: sl(),
      ),
    );

    sl.registerLazySingleton<AnonymousSignInRemoteDataSource>(
      () => AnonymousSignInRemoteDataSourceImpl(
        auth: sl(),
      ),
    );

    ///usecases
    sl.registerLazySingleton(() => SignInGoogle(sl()));
    sl.registerLazySingleton(() => SignInAnonymous(sl()));

    ///repository

    sl.registerLazySingleton<GoogleSignInRepository>(
      () => GoogleSignInRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );

    sl.registerLazySingleton<AnonymousSignInRepository>(
      () => AnonymousSignInRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );
  }
}
