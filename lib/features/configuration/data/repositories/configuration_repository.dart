import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/configuration/data/datasources/configuration_local_data_source.dart';
import 'package:movie_colony/features/configuration/data/datasources/configuration_remote_data_source.dart';
import 'package:movie_colony/features/configuration/domain/entities/configuration.dart';

final configurationRepositoryProvider =
    Provider<ConfigurationRepository>((ref) {
  return ConfigurationRepository(
    sharedPreferencesRepository: ref.watch(sharedPreferencesRepositoryProvider),
    remoteDataSource: ref.watch(configurationRemoteDataSourceProvider),
    localDataSource: ref.watch(configurationLocalDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

class ConfigurationRepository {
  ConfigurationRepository({
    required this.sharedPreferencesRepository,
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final ConfigurationRemoteDataSource remoteDataSource;
  final ConfigurationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final SharedPreferencesRepository sharedPreferencesRepository;

  Future<Configuration> getConfiguration() async {
    final bool hasExpired =
        sharedPreferencesRepository.isExpired(Strings.cachedConfiguration);

    return getConfigurationSwitchCase(hasExpired);
  }

  Future<Configuration> getConfigurationSwitchCase(
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

  Future<Configuration> remoteData() async {
    final bool isConnected = networkInfo.isConnected;
    if (isConnected) {
      final remote = await remoteDataSource.getRemoteConfiguration();
      await localDataSource.cacheLastConfiguration(remote);
      return remote;
    } else {
      final local = await localDataSource.getCachedConfiguration();
      return local;
    }
  }

  Future<Configuration> localData() async {
    final local = await localDataSource.getCachedConfiguration();
    return local;
  }
}
