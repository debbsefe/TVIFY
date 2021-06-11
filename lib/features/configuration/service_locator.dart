import 'package:get_it/get_it.dart';
import 'data/datasources/configuration_local_data_source.dart';
import 'data/datasources/configuration_remote_data_source.dart';
import 'data/repositories/configuration_repository_impl.dart';
import 'domain/repositories/configuration_repository.dart';
import 'domain/usecases/get_configuration.dart';
import 'presentation/notifiers/configuration_notifier.dart';

class ConfigurationServiceLocator {
  ConfigurationServiceLocator(this.sl);
  final GetIt sl;

// ignore_for_file: cascade_invocations
  void init() {
    ///view models/notifiers

    sl.registerLazySingleton<ConfigurationNotifier>(
      () => ConfigurationNotifier(sl()),
    );

    ///datasources
    sl.registerLazySingleton<ConfigurationRemoteDataSource>(
      () => ConfigurationRemoteDataSourceImpl(
        client: sl(),
        config: sl(),
      ),
    );

    sl.registerLazySingleton<ConfigurationLocalDataSource>(
      () => ConfigurationLocalDataSourceImpl(
        sl(),
      ),
    );

    ///usecases
    sl.registerLazySingleton(() => GetAllConfiguration(sl()));

    ///repository

    sl.registerLazySingleton<ConfigurationRepository>(
      () => ConfigurationRepositoryImpl(
        cache: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );
  }
}
