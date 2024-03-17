import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/models/tv_list/tv_list_model.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/core/utils/strings.dart';

abstract class TrendingRemoteDataSource {
  Future<List<TvListModel>> getRemoteTrendingWeekly();
  Future<List<TvListModel>> getRemoteTrendingDaily();
}

class TrendingRemoteDataSourceImpl implements TrendingRemoteDataSource {
  TrendingRemoteDataSourceImpl({required this.client, required this.config});

  final http.Client client;
  final Config config;

  @override
  Future<List<TvListModel>> getRemoteTrendingWeekly() async {
    final String token = await config.fetchToken(Strings.apiKeyTmdb);
    final String url = 'trending/tv/week?api_key=$token'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return (parsed['results'] as List)
          .map((i) => TvListModel.fromJson(i as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvListModel>> getRemoteTrendingDaily() async {
    final String token = await config.fetchToken(Strings.apiKeyTmdb);
    final String url = 'trending/tv/day?api_key=$token'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return (parsed['results'] as List<Map<String, dynamic>>)
          .map(TvListModel.fromJson)
          .toList();
    } else {
      throw ServerException();
    }
  }
}
