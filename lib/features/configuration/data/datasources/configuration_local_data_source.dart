import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/configuration/data/models/configuration_model.dart';

final configurationLocalDataSourceProvider =
    Provider<ConfigurationLocalDataSource>((ref) {
  return ConfigurationLocalDataSource(
    ref.watch(sharedPreferencesRepositoryProvider),
  );
});

class ConfigurationLocalDataSource {
  ConfigurationLocalDataSource(this.sharedPreferencesRepository);

  final SharedPreferencesRepository sharedPreferencesRepository;

  Future<ConfigurationModel> getCachedConfiguration() {
    final jsonString =
        sharedPreferencesRepository.retrieveString(Strings.cachedConfiguration);
    if (jsonString != null) {
      return Future.value(
        ConfigurationModel.fromJson(
          json.decode(jsonString) as Map<String, dynamic>,
        ),
      );
    } else {
      throw CacheException();
    }
  }

  Future<void> cacheLastConfiguration(ConfigurationModel configurationModel) {
    sharedPreferencesRepository.saveString(
      expiryDate(Strings.cachedConfiguration),
      sevenDaysLater,
    );

    return sharedPreferencesRepository.saveString(
      Strings.cachedConfiguration,
      json.encode(configurationModel.toJson()),
    );
  }
}
