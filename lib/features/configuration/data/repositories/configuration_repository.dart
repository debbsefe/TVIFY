import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/core/repository.dart/shared_preferences_repository.dart';
import 'package:tvfiy/core/utils/strings.dart';
import 'package:tvfiy/features/configuration/data/datasources/configuration_local_data_source.dart';
import 'package:tvfiy/features/configuration/data/datasources/configuration_remote_data_source.dart';

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
    final bool hasExpired = sharedPreferencesRepository
        .shouldRenewCache(Strings.cachedConfiguration);

    return hasExpired ? await remoteData() : localData();
  }

  Future<ConfigurationModel?> remoteData() async {
    final remote = await remoteDataSource.getRemoteConfiguration();
    await localDataSource.cacheLastConfiguration(remote);
    return remote;
  }

  ConfigurationModel? localData() {
    return localDataSource.getCachedConfiguration();
  }
}
