import 'package:http/http.dart' as http;
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/features/configuration/data/datasources/configuration_local_data_source.dart';

final configurationRemoteDataSourceProvider =
    Provider<ConfigurationRemoteDataSource>((ref) {
  return ConfigurationRemoteDataSource(
    client: ref.watch(httpClientProvider),
    localDataSource: ref.watch(configurationLocalDataSourceProvider),
  );
});

class ConfigurationRemoteDataSource {
  ConfigurationRemoteDataSource({
    required this.client,
    required this.localDataSource,
  });
  final http.Client client;
  final ConfigurationLocalDataSource localDataSource;

  Future<ConfigurationModel?> getRemoteConfiguration() async {
    final String url = 'configuration'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      return configurationModelFromJson(response.body);
    } else {
      return localDataSource.getCachedConfiguration();
    }
  }
}
