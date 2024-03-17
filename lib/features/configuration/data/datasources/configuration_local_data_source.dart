import 'dart:convert';

import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/configuration/data/models/configuration_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ConfigurationLocalDataSource {
  ///method to fetch the last cache that was fetched,
  ///throws an exception if no cache data is present
  Future<ConfigurationModel> getCachedConfiguration();

  //method to cache the last cache that was fetched
  Future<void> cacheLastConfiguration(ConfigurationModel configurationModel);
}

class ConfigurationLocalDataSourceImpl implements ConfigurationLocalDataSource {
  ConfigurationLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<ConfigurationModel> getCachedConfiguration() {
    final jsonString = sharedPreferences.getString(Strings.cachedConfiguration);
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

  @override
  Future<void> cacheLastConfiguration(ConfigurationModel configurationModel) {
    sharedPreferences.setString(
      expiryDate(Strings.cachedConfiguration),
      sevenDaysLater,
    );

    return sharedPreferences.setString(
      Strings.cachedConfiguration,
      json.encode(configurationModel.toJson()),
    );
  }
}
