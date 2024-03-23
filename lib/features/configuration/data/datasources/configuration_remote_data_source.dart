import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/configuration/data/datasources/configuration_local_data_source.dart';
import 'package:movie_colony/features/configuration/data/models/configuration_model.dart';
import 'package:movie_colony/providers.dart';

final configurationRemoteDataSourceProvider =
    Provider<ConfigurationRemoteDataSource>((ref) {
  return ConfigurationRemoteDataSource(
    client: ref.watch(httpClientProvider),
    config: ref.watch(configProvider),
    localDataSource: ref.watch(configurationLocalDataSourceProvider),
  );
});

class ConfigurationRemoteDataSource {
  ConfigurationRemoteDataSource({
    required this.client,
    required this.config,
    required this.localDataSource,
  });
  final http.Client client;
  final Config config;
  final ConfigurationLocalDataSource localDataSource;

  Future<ConfigurationModel> getRemoteConfiguration() async {
    final String token = await config.fetchToken(Strings.apiKeyTmdb);
    final String url = 'configuration/?api_key=$token'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      return ConfigurationModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      return localDataSource.getCachedConfiguration();
    }
  }
}
