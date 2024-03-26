import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/configuration/data/datasources/configuration_local_data_source.dart';
import 'package:movie_colony/features/configuration/data/datasources/configuration_remote_data_source.dart';

final configurationRepositoryProvider =
    Provider<ConfigurationRepository>((ref) {
  return ConfigurationRepository(
    sharedPreferencesRepository: ref.watch(sharedPreferencesRepositoryProvider),
    remoteDataSource: ref.watch(configurationRemoteDataSourceProvider),
    localDataSource: ref.watch(configurationLocalDataSourceProvider),
  );
});

class ConfigurationRepository {
  ConfigurationRepository({
    required this.sharedPreferencesRepository,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  final ConfigurationRemoteDataSource remoteDataSource;
  final ConfigurationLocalDataSource localDataSource;
  final SharedPreferencesRepository sharedPreferencesRepository;

  Future<ConfigurationModel?> getConfiguration() async {
    final bool hasExpired =
        sharedPreferencesRepository.isExpired(Strings.cachedConfiguration);

    return getConfigurationSwitchCase(hasExpired);
  }

  Future<ConfigurationModel?> getConfigurationSwitchCase(
    bool hasExpired,
  ) async {
    switch (hasExpired) {
      case true:
        return remoteData();
      case false:
        return localData();
      default:
        return remoteData();
    }
  }

  Future<ConfigurationModel?> remoteData() async {
    final remote = await remoteDataSource.getRemoteConfiguration();
    await localDataSource.cacheLastConfiguration(remote);
    return remote;
  }

  Future<ConfigurationModel?> localData() async {
    final local = localDataSource.getCachedConfiguration();
    return local;
  }
}
