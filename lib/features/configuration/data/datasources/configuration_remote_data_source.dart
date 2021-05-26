import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/strings.dart';
import '../models/configuration_model.dart';

abstract class ConfigurationRemoteDataSource {
  Future<ConfigurationModel> getRemoteConfiguration();
}

class ConfigurationRemoteDataSourceImpl
    implements ConfigurationRemoteDataSource {
  final http.Client client;
  final Config config;

  ConfigurationRemoteDataSourceImpl(
      {required this.client, required this.config});

  @override
  Future<ConfigurationModel> getRemoteConfiguration() async {
    String _token = await config.fetchToken(API_KEY_TMDB);
    String _url = '$BASE_URL/configuration/?api_key=$_token';
    final response = await client.get(
      Uri.parse(_url),
    );

    if (response.statusCode == 200) {
      return ConfigurationModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
