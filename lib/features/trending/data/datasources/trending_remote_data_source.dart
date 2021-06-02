import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/strings.dart';
import '../models/trending_model.dart';

abstract class TrendingRemoteDataSource {
  Future<List<TrendingModel>> getRemoteTrending();
}

class TrendingRemoteDataSourceImpl implements TrendingRemoteDataSource {
  TrendingRemoteDataSourceImpl({required this.client, required this.config});

  final http.Client client;
  final Config config;

  @override
  Future<List<TrendingModel>> getRemoteTrending() async {
    String _token = await config.fetchToken(Strings.apiKeyTmdb);
    String _url = 'trending/tv/week?api_key=$_token'.baseurl;
    final response = await client.get(
      Uri.parse(_url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return parsed['results']
          .map<TrendingModel>((json) => TrendingModel.fromJson(json))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
