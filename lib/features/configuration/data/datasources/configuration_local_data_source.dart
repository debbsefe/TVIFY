import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/core/utils/strings.dart';

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
    final jsonString =
        sharedPreferencesRepository.retrieveString(Strings.cachedConfiguration);
    if (jsonString != null) {
      return ConfigurationModel.fromJson(
        json.decode(jsonString) as Map<String, dynamic>,
      );
    }
    return null;
  }

  Future<void> cacheLastConfiguration(ConfigurationModel? configurationModel) {
    sharedPreferencesRepository.saveString(
      expiryDate(Strings.cachedConfiguration),
      sevenDaysLater,
    );

    return sharedPreferencesRepository.saveString(
      Strings.cachedConfiguration,
      json.encode(configurationModel?.toJson()),
    );
  }
}
