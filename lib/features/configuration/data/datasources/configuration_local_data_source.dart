import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';

final configurationLocalDataSourceProvider =
    Provider<ConfigurationLocalDataSource>((ref) {
  return ConfigurationLocalDataSource(
    ref.watch(sharedPreferencesRepositoryProvider),
  );
});

class ConfigurationLocalDataSource {
  ConfigurationLocalDataSource(this.sharedPreferencesRepository);

  final SharedPreferencesRepository sharedPreferencesRepository;

  ConfigurationModel? getCachedConfiguration() {
    final jsonString = sharedPreferencesRepository.getConfigurationCache();
    if (jsonString != null) {
      return configurationModelFromJson(jsonString);
    }
    return null;
  }

  Future<void> cacheLastConfiguration(
    ConfigurationModel? configurationModel,
  ) async {
    if (configurationModel != null) {
      await sharedPreferencesRepository
          .setConfigurationCache(configurationModel);
    }
  }
}
