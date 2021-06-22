import 'package:get_it/get_it.dart';

import 'data/datasources/google_sign_in_remote_data_source.dart';
import 'data/repositories/google_sign_in_repository_impl.dart';
import 'domain/repositories/google_sign_in_repository.dart';
import 'domain/usecases/sign_in_google.dart';
import 'presentation/notifiers/google_sign_in_notifier.dart';

class AuthServiceLocator {
  AuthServiceLocator(this.sl);
  final GetIt sl;

// ignore_for_file: cascade_invocations
  void init() {
    ///view models/notifiers

    sl.registerLazySingleton<GoogleSignInNotifier>(
      () => GoogleSignInNotifier(sl()),
    );

    ///datasources
    sl.registerLazySingleton<GoogleSignInRemoteDataSource>(
      () => GoogleSignInRemoteDataSourceImpl(
        googleSignIn: sl(),
        auth: sl(),
        authProvider: sl(),
      ),
    );

    ///usecases
    sl.registerLazySingleton(() => SignInGoogle(sl()));

    ///repository

    sl.registerLazySingleton<GoogleSignInRepository>(
      () => GoogleSignInRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );
  }
}
