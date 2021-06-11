import 'package:get_it/get_it.dart';

import 'data/datasources/categories_local_data_source.dart';
import 'data/datasources/categories_remote_data_source.dart';
import 'data/repositories/categories_repository_impl.dart';
import 'domain/repositories/categories_repository.dart';
import 'domain/usecases/get_categories.dart';
import 'presentation/notifiers/categories_notifier.dart';

// ignore_for_file: cascade_invocations

class CategoriesServiceLocator {
  CategoriesServiceLocator(this.sl);
  final GetIt sl;

  void init() {
    ///view models/notifiers

    sl.registerLazySingleton<CategoriesNotifier>(
      () => CategoriesNotifier(sl()),
    );

    ///datasources
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

    ///usecases
    sl.registerLazySingleton(() => GetAllCategories(sl()));

    ///repository

    sl.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl(
        cache: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );
  }
}
