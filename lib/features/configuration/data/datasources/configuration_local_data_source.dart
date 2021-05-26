import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/utils/strings.dart';
import '../../../configuration/data/models/configuration_model.dart';

abstract class ConfigurationLocalDataSource {
  ///method to fetch the last cache that was fetched, throws an exception if no cache data is present
  Future<ConfigurationModel> getCachedConfiguration();

  //method to cache the last cache that was fetched
  Future<void> cacheLastConfiguration(ConfigurationModel configurationModel);
}

class ConfigurationLocalDataSourceImpl implements ConfigurationLocalDataSource {
  final SharedPreferences sharedPreferences;
  ConfigurationLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<ConfigurationModel> getCachedConfiguration() {
    final jsonString = sharedPreferences.getString(CACHED_CONFIGURATION);
    if (jsonString != null) {
      return Future.value(ConfigurationModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLastConfiguration(ConfigurationModel configurationModel) {
    sharedPreferences.setString(
        expiryDate(CACHED_CONFIGURATION), sevenDaysLater);

    return sharedPreferences.setString(
      CACHED_CONFIGURATION,
      json.encode(configurationModel.toJson()),
    );
  }
}
